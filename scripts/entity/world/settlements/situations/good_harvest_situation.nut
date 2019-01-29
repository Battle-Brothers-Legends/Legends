this.good_harvest_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.good_harvest";
		this.m.Name = "Good Harvest";
		this.m.Description = "Conditions for crops have been perfect. Food is readily available and offered at lower prices.";
		this.m.Icon = "ui/settlement_status/settlement_effect_17.png";
		this.m.IsStacking = false;
		this.m.ValidDays = 7;
	}

	function getAddedString( _s )
	{
		return _s + " benefits from a " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer benefits from a " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}

});
