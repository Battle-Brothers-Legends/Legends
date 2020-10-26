this.intercept_raiding_parties_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "intercept_raiding_parties_action";
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

		if (!this.World.FactionManager.isHolyWar() || !_faction.getFlags().get("IsHolyWarParticipant"))
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

		local settlements = _faction.getSettlements();
		local hasQualifiedLocations = false;

		foreach( s in settlements )
		{
			if (s.isIsolated() || s.isMilitary() || !s.isDiscovered() || s.isCoastal() || s.getActiveAttachedLocations().len() < 2)
			{
				continue;
			}

			if (this.World.getTileSquare(s.getTile().SquareCoords.X, s.getTile().SquareCoords.Y - 12).Type == this.Const.World.TerrainType.Ocean)
			{
				continue;
			}

			hasQualifiedLocations = true;
			break;
		}

		if (!hasQualifiedLocations)
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/intercept_raiding_parties_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

