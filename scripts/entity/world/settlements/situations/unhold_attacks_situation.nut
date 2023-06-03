this.unhold_attacks_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.unhold_attacks";
		this.m.Name = "Unhold Attacks";
		this.m.Description = "Large Unholds have been seen and heard in the area. The townsfolk are scared of leaving the vicinity of the settlement.";
		this.m.Icon = "ui/settlement_status/settlement_effect_26.png";
		this.m.Rumors = [
			"A traveling merchant told me about giant footprints near the road from %settlement%. Sure as hell would not want to meet whatever beast left those!",
			"When I was in %settlement% the other day, a group of hunters went missing. They were after some sort of giant...",
			"Ever heard of unholds? Huge monsters that stomp whole carts under a foot! I heard rumors of sightings near %settlement%."
		];
		this.m.IsStacking = false;
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


	function getAddedString( _s )
	{
		return _s + " has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.SellPriceMult *= 0.9;
		_modifiers.RarityMult *= 0.9;
		_modifiers.RecruitsMult *= 0.75;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}
	}

});

