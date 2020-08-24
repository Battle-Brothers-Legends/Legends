this.slave_uprising_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		Location = null
	},
	function create()
	{
		this.m.ID = "slave_uprising_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
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

		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.World.getTime().Days < 2)
		{
			return;
		}

		if (this.World.getTime().Days <= 100 && this.Math.rand(1, 100) > 2 || this.World.getTime().Days > 100 && this.Math.rand(1, 100) > 1)
		{
			return;
		}

		this.m.Location = null;

		foreach( a in _faction.getSettlements()[0].getAttachedLocations() )
		{
			if (!a.isMilitary() && a.isUsable() && a.getTile().getDistanceTo(_faction.getSettlements()[0].getTile()) >= 3)
			{
				this.m.Location = a;
				break;
			}
		}

		if (this.m.Location == null)
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
		this.m.Location = null;
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/slave_uprising_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setLocation(this.m.Location);
		contract.setHome(_faction.getSettlements()[0]);
		this.World.Contracts.addContract(contract);
	}

});

