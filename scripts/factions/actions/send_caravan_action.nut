this.send_caravan_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Start = null,
		Dest = null
	},
	function setFaction( _f )
	{
		this.faction_action.setFaction(_f);

		if (_f.getType() == this.Const.FactionType.NobleHouse)
			this.m.Cooldown = this.World.getTime().SecondsPerDay * 2;
	}

	function create()
	{
		this.m.ID = "send_caravan_action";
		this.m.Cooldown = 100.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.World.getTime().IsDaytime)
			return;

		if (_faction.isEnemyNearby())
			return;

		local isNobleHouse = _faction.getType() == this.Const.FactionType.NobleHouse;

		if (!this.isAbleToSpawnCaravan(_faction, isNobleHouse ? 4 : 1))
			return;

		local mySettlements = this.getFactionSettlememts(_faction, isNobleHouse);
		local allSettlements = this.World.EntityManager.getSettlements();
		local destinations;

		if (!this.World.FactionManager.isGreaterEvil())
		{
			destinations = allSettlements;
		}
		else
		{
			destinations = [];

			foreach( s in allSettlements )
			{
				if (s.getOwner() == null || s.getOwner().isAlliedWith(_faction.getID()))
				{
					destinations.push(s);
				}
			}
		}

		local settlements = this.getRandomConnectedSettlements(2, mySettlements, destinations, true);

		if (settlements.len() < 2)
			return;

		this.m.Start = settlements[0];
		this.m.Dest = settlements[1];
		this.m.Score = 5 + (isNobleHouse ? this.m.Start.getSize() - 1 : 0);
	}

	function isAbleToSpawnCaravan( _faction, _maxNum = 0 )
	{
		local caravan = 0;

		foreach( party in _faction.getUnits() )
		{
			if (party.getFlags().get("IsCaravan"))
				++caravan;
		}

		return caravan < _maxNum;
	}

	function getFactionSettlememts( _faction, _onlyMilitary = false )
	{
		if (!_onlyMilitary)
			return _faction.getSettlements();

		local ret = [];

		foreach( s in _faction.getSettlements() )
		{
			if (!s.isMilitary())
				continue;

			ret.push(s);
		}

		if (ret.len() == 0)
			return _faction.getSettlements();

		return ret;
	}

	function onClear()
	{
		this.m.Start = null;
		this.m.Dest = null;
	}

	function getReputationToDifficultyLightMult()
	{
		return this.faction_action.getReputationToDifficultyLightMult() * (this.World.FactionManager.isCivilWar() ? 1.1 : 1.0);
	}

	function getResourcesForParty( _settlement, _faction )
	{
		if (_settlement == null) return this.Math.rand(100, 200) * this.getReputationToDifficultyLightMult();

		if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState)) return (this.Math.rand(80, 127) + this.Math.round(0.12 * ::Math.max(1, _settlement.getResources()))) * this.getReputationToDifficultyLightMult(); // this.m.Start.getResources() * 0.6

		return (this.Math.rand(45, 95) + this.Math.round(0.1 * ::Math.max(1, _settlement.getResources()))) * this.getReputationToDifficultyLightMult(); // this.m.Start.getResources() * 0.5
	}

	function convertBudgetToMult( _budget )
	{
		if (_budget == 0)
			return 1.0;

		return 1.0 + this.Math.floor(_budget / 1000) * 0.115;
	}

	function onExecute( _faction )
	{
		local budget = !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue() ? 0 : ::Const.World.Common.WorldEconomy.calculateTradingBudget(this.m.Start);
		local mult = this.convertBudgetToMult(budget);
		local party = _faction.spawnEntity(this.m.Start.getTile(), "Trading Caravan", false, this.pickSpawnList(this.m.Start, _faction), this.getResourcesForParty(this.m.Start, _faction) * mult); 
		party.getSprite("banner").Visible = false;
		party.getSprite("base").Visible = false;
		party.setMirrored(true);
		party.setDescription("A trading caravan from " + this.m.Start.getName() + " that is transporting all manner of goods between settlements.");
		party.setFootprintType(this.Const.World.FootprintsType.Caravan);
		party.getFlags().set("IsCaravan", true);
		party.getFlags().set("IsRandomlySpawned", true);

		if (this.World.Assets.m.IsBrigand && this.m.Start.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 70)
		{
			party.setVisibleInFogOfWar(true);
			party.setImportant(true);
			party.setDiscovered(true);
		}

		this.addLoot(party);

		// yes world economy
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			::Const.World.Common.WorldEconomy.setupTrade(party, this.m.Start, this.m.Dest, budget);
		}
		// no world economy
		else
		{
			this.addToPartyInventory(party);
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(this.m.Dest.getTile());
		move.setRoadsOnly(true);
		local unload = this.new("scripts/ai/world/orders/unload_order");
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(move);
		c.addOrder(unload);
		c.addOrder(despawn);

		this.afterSpawnCaravan(party);
	}

	function pickSpawnList( _settlement, _faction )
	{
		if (_faction.hasTrait(this.Const.FactionTrait.OrientalCityState)) return this.Const.World.Spawn.CaravanSouthern;

		return this.Const.World.Spawn.Caravan;
	}

	function addLoot( _party )
	{
		if (this.Math.rand(1, 2) <= 1) _party.getLoot().ArmorParts = this.Math.rand(0, 10);
	
		if (this.Math.rand(1, 2) <= 1) _party.getLoot().Medicine = this.Math.rand(0, 10);

		if (this.Math.rand(1, 2) <= 1) _party.getLoot().Ammo = this.Math.rand(0, 25);

		_party.getLoot().Money = this.Math.rand(0, 100);
	}

	function addToPartyInventory( _party )
	{
		switch(::Math.rand(1, 4))
		{
		case 1:
			_party.addToInventory("supplies/bread_item");
			break;

		case 2:
			_party.addToInventory("supplies/roots_and_berries_item");
			break;

		case 3:
			_party.addToInventory("supplies/dried_fruits_item");
			break;

		default:
			_party.addToInventory("supplies/ground_grains_item");
		}
	}

	function afterSpawnCaravan(_party)
	{
	}

});

