this.siege_fortification_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Origin = null
	},
	function create()
	{
		this.m.ID = "siege_fortification_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (_faction.getPlayerRelation() <= 25)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		if (this.Math.rand(1, 100) > 30)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local hasCastle = false;

		foreach( s in _faction.getSettlements() )
		{
			if (s.isIsolated() || !s.isMilitary() || !s.isDiscovered())
			{
				continue;
			}

			hasCastle = true;
			break;
		}

		if (!hasCastle)
		{
			return;
		}

		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		foreach( i, h in nobleHouses )
		{
			if (h.getID() == this.m.Faction)
			{
				nobleHouses.remove(i);
				break;
			}
		}

		nobleHouses.sort(this.onSortBySettlements);
		local settlements = _faction.getSettlements();
		local lowest_distance = 9999;
		local best;
		local castles = 0;

		foreach( s in nobleHouses[0].getSettlements() )
		{
			if (s.isIsolated())
			{
				continue;
			}

			if (!s.isMilitary())
			{
				continue;
			}

			castles = ++castles;

			if (s.getSize() == 3)
			{
				continue;
			}

			foreach( a in settlements )
			{
				local d = a.getTile().getDistanceTo(s.getTile());

				if (d < lowest_distance)
				{
					lowest_distance = d;
					best = s;
				}
			}
		}

		if (best == null || castles <= 1)
		{
			return;
		}

		this.m.Origin = best;
		this.m.Score = 1;
	}

	function onClear()
	{
		this.m.Origin = null;
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/siege_fortification_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setOrigin(this.m.Origin);
		this.World.Contracts.addContract(contract);
	}

	function onSortBySettlements( _a, _b )
	{
		if (_a.getSettlements().len() > _b.getSettlements().len())
		{
			return -1;
		}
		else if (_a.getSettlements().len() < _b.getSettlements().len())
		{
			return 1;
		}

		return 0;
	}

});

