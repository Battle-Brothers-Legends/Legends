this.slave_revolt_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.slave_revolt";
		this.m.Name = "Slave Revolt";
		this.m.Description = "The indebted, the slave class of the city states, have taken up arms and rise against their masters! Indebted are hard to come by, and weapons and armors have been swept from the market.";
		this.m.Icon = "ui/settlement_status/settlement_effect_40.png";
		this.m.Rumors = [
			"The slaves over at %settlement% took up arms and turned to banditry and waylaying. Unsullied or whatever they call them, I mean. There is surely some work to be done for a mercenary like you.",
			"Word has made it here that the slaves at %settlement% are rebelling. A proper revolt could topple their whole city, and I hope it does."
		];
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + " has a " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has a " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
	}

	function onResolved( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.125);
		}
	}
	
	function onUpdate( _modifiers )
	{
		_modifiers.RecruitsMult *= 0.75;
		_modifiers.RarityMult *= 0.5;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		for( local i = _draftList.len() - 1; i >= 0; i = --i )
		{
			if (_draftList[i] == "slave_background" || _draftList[i] == "slave_southern_background")
			{
				_draftList.remove(i);
			}
		}
		_draftList.push("legend_muladi_background");
	}

});

