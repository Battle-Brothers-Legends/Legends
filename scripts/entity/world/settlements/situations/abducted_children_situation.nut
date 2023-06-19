this.abducted_children_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.abducted_children";
		this.m.Name = "Abducted Children";
		this.m.Description = "Children have been disappearing from this settlement. Distrust and fear rule the streets and are slowly poisoning the community.";
		this.m.Icon = "ui/settlement_status/settlement_effect_34.png";
		this.m.Rumors = [
			"Rumor is that children disappear from their cribs in %settlement% into thin air. Imagine the parents\' terror...",
			"My grandma told me a story about witches abducting children for their innocent blood. And now in %settlement%, kids have gone missing just like in the stories.",
			"Never ever strike a deal with witches! A relative in %settlement% did it years ago and now his kid is gone missing."
		];
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
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
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.5;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
	_draftList.push("witchhunter_background");
	}

});

