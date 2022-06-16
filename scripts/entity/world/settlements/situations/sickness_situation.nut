this.sickness_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.sickness";
		this.m.Name = "Sickness";
		this.m.Description = "A sickness has struck down many folks in this settlement. There are fewer recruits available, and food and medical supplies are scarce.";
		this.m.Icon = "ui/settlement_status/settlement_effect_23.png";
		this.m.Rumors = [
			"Don\'t go near %settlement%! A sickness struck that poor town and the folks are dying like flies over there...",
			"We had some folks coming here from %settlement%, but had to send them away at the gates. Everybody knows that a cruel disease is spreading in that cursed town.",
			"Fancy my herbal necklace? It protects me against even the most pestilent disease. You better get yourself one, too, if you\'re planning to ahead on towards %settlement%."
		];
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + " now is " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer is " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.05);
		}
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.MedicalPriceMult *= 3.0;
		_modifiers.RecruitsMult *= 0.25;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("monk_background");

		if (_gender)
		{
		_draftList.push("female_beggar_background");
		_draftList.push("legend_nun_background");
		_draftList.push("legend_herbalist_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
		}
	}
});

