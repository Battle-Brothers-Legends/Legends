this.ambushed_trade_routes_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.ambushed_trade_routes";
		this.m.Name = "Ambushed Trade Routes";
		this.m.Description = "The roads leading here are unsafe of late, and many a caravan has been ambushed and plundered. With little successful trade, the selection of goods is lower and the prices higher.";
		this.m.Icon = "ui/settlement_status/settlement_effect_12.png";
		this.m.Rumors = [
			"Brigands and raiders are the bane of us traveling merchants! An old friend of mine got ambushed, robbed and beaten just outside of %settlement%!",
			"If you have any valuables on you, stay away from %settlement%. The place is scourged by cutthroats, bandits and highwaymen!",
			"The guardsmen are doing what they can, but these brigands just move on to the next town and waylay traders on the road. They\'re said to lurk around %settlement% now!"
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
		_settlement.removeSituationByID("situation.safe_roads");
		if(::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
		{
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * -0.025);
		}
		_settlement.resetShop();

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
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.75;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if  ( this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}
	}
});

