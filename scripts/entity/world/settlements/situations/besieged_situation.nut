this.besieged_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.besieged";
		this.m.Name = "Besieged";
		this.m.Description = "This place is or has until recently been besieged by the enemy! It\'s suffered damage, the supplies are low and many have lost their lives.";
		this.m.Icon = "ui/settlement_status/settlement_effect_13.png";
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
		_settlement.resetShop();
		_settlement.resetRoster(false);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.0;
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.5;
		_modifiers.RarityMult *= 0.5;
	}

});

