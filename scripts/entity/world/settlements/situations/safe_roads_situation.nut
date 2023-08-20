this.safe_roads_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.safe_roads";
		this.m.Name = "Safe Roads";
		this.m.Description = "The roads leading here have been reasonably safe of late, which allowed for many a profitable trade to be made and the settlement to prosper somewhat.";
		this.m.Icon = "ui/settlement_status/settlement_effect_06.png";
		this.m.Rumors = [
			"Seems the brigands around %settlement% are having a rough time now with all those patrols going on.",
			"Just got back from %settlement% last night. No brigand in sight on the roads, thank the gods.",
			"Been telling my cousin for years to stop robbing people on the road. Ain\'t no way for it but to end badly. And right I was, it did. Got his comeuppance the other day by %settlement%. Place is crawling with militia."
		];
		this.m.IsStacking = false;
	}

	function onAdded( _settlement )
	{
		_settlement.removeSituationByID("situation.ambushed_trade_routes");
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.1);
		}
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.PriceMult *= 1.1;
		_modifiers.RarityMult *= 1.1;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("vagabond_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("peddler_background");
		_draftList.push("messenger_background");
		_draftList.push("gambler_background");
		_draftList.push("tailor_background");
		_draftList.push("minstrel_background");
		_draftList.push("historian_background");
		_draftList.push("adventurous_noble_background");
		_draftList.push("legend_donkey_background");

		if (_gender)
		{
			_draftList.push("female_adventurous_noble_background");
		}
		
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
		{
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
		}

		if  ( this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
			_draftList.push("legend_leech_peddler_background");
		}
	}
});

