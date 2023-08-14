this.send_undead_ambushers_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "send_undead_ambushers_action";
		this.m.Cooldown = 30.0;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!(this.World.FactionManager.getGreaterEvilType() == this.Const.World.GreaterEvilType.Undead && this.World.FactionManager.getGreaterEvilPhase() >= this.Const.World.GreaterEvilPhase.Warning))
		{
			return;
		}

		local settlements = _faction.getSettlements();

		if (settlements.len() < 7)
		{
			return;
		}

		if (this.World.FactionManager.getGreaterEvilPhase() == this.Const.World.GreaterEvilPhase.Live && this.World.FactionManager.getGreaterEvilStrength() >= 10.0)
		{
			if (_faction.getUnits().len() >= 6)
			{
				return;
			}
		}
		else if (_faction.getUnits().len() >= 3)
		{
			return;
		}

		local allowed = false;

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 150.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			allowed = true;
			break;
		}

		if (!allowed)
		{
			return;
		}

		this.m.Score = 10;
	
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
		{
		this.m.Score = 15;
		}	
		
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local settlements = [];

		foreach( s in _faction.getSettlements() )
		{
			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF())
			{
				continue;
			}

			settlements.push({
				D = s,
				P = 10
			});
		}

		if (settlements.len() == 0)
		{
			return;
		}

		local settlement = this.pickWeightedRandom(settlements);
		settlement.setLastSpawnTimeToNow();
		local mult = this.World.FactionManager.isUndeadScourge() ? 1.1 : 1.0;
		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			 mult = this.World.FactionManager.isUndeadScourge() ? 1.2 : 1.0;
			}
		local rand = this.Math.rand(75, 120)
		local distanceToNextSettlement = this.getDistanceToSettlements(settlement.getTile());
			if (::Legends.Mod.ModSettings.getSetting("DistanceScaling").getValue() && distanceToNextSettlement > 14)
			{
			 rand *= distanceToNextSettlement / 14.0;
			}
		local party = _faction.spawnEntity(settlement.getTile(), "Undead", false, this.Const.World.Spawn.UndeadScourge, rand * this.getScaledDifficultyMult() * mult);
		party.getSprite("banner").setBrush(settlement.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(this.Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = this.Math.rand(0, 15);
		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			party.addToInventory("loot/signet_ring_item");
		}

		local c = party.getController();
		c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
		local ambush = this.new("scripts/ai/world/orders/ambush_order");
		local move = this.new("scripts/ai/world/orders/move_order");
		move.setDestination(settlement.getTile());
		local despawn = this.new("scripts/ai/world/orders/despawn_order");
		c.addOrder(ambush);
		c.addOrder(move);
		c.addOrder(despawn);
		return true;
	}

});

