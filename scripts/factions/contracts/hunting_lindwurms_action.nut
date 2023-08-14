this.hunting_lindwurms_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "hunting_lindwurms_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.Const.DLC.Unhold || !this.Const.DLC.Lindwurm)
		{
			return;
		}

		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (this.Math.rand(1, 100) > 10)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (!this.isKindOf(village, "legends_steppe_village") && !this.isKindOf(village, "legends_farming_village") && !this.isKindOf(village, "small_steppe_village") && !this.isKindOf(village, "medium_steppe_village") && !this.isKindOf(village, "large_steppe_village") && !this.isKindOf(village, "small_farming_village") && !this.isKindOf(village, "medium_farming_village") && !this.isKindOf(village, "large_farming_village"))
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
		local contract = this.new("scripts/contracts/contracts/hunting_lindwurms_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

