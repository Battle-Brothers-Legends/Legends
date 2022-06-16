this.disbanded_troops_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.disbanded_troops";
		this.m.Name = "Disbanded Troops";
		this.m.Description = "With a local conflict now solved, many levied troops and their weapons are no longer needed. A good time to grab a bargain or hire experienced new men.";
		this.m.Icon = "ui/settlement_status/settlement_effect_30.png";
		this.m.Rumors = [
			"Standing armies are expensive, my friend. I heard an entire regiment was disbanded at %settlement%. Surely there\'ll be some veteran fighters lingering there still, desperate for coin.",
			"When I was young I used to be a soldier, and I liked it. Even the marching. But when my unit was disbanded I didn\'t know what the hell to do with myself. Now they\'re disbanding one of them regiments over at %settlement%, from what I hear.",
			"I\'m concerned for my niece; an entire unit of soldiers got disbanded at %settlement%, right near where she lives. Things won\'t end well if those brutes don\'t find employment soon!"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 4;
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
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.035);
		}
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.PriceMult *= 0.9;
		_modifiers.RecruitsMult *= 1.25;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_2h");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_ranged");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_noble_shield");
		_draftList.push("legend_master_archer_background");

		if (_gender)
		{
		_draftList.push("legend_shieldmaiden_background");
		_draftList.push("legend_shieldmaiden_background");
		_draftList.push("legend_shieldmaiden_background");

		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}
	}

});

