this.mod_well_supplied_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	//had to use a very hacky way to select player base, as otherwise deserialisation errors (or custom addSituation function)
	m = {
		Home = null
	},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.mod_well_supplied";
		this.m.Name = this.defineName();
		this.m.Description = this.defineDescription();
		this.m.Icon = "ui/settlement_status/settlement_effect_03.png";
		this.m.Rumors = [
			"Trade with %settlement% is prospering, my friend! Safe roads and full stocks, let\'s hope it stays this way...",
			"My cousin over in %settlement% keeps bragging about how good they have it there. Well stocked market stands and all. Not like this rotten place."
		];
		this.m.IsStacking = false;
		
	}
	function defineName()
	{
		local company_name = this.World.Assets.getName();
		local final_name = "The ";
		if (company_name.slice(company_name.len()-1, company_name.len()) == "s")
		{
			company_name = company_name.slice(0, company_name.len()-1);
		}
		final_name += company_name + "'s boon";
		return final_name;
	}
	function isValid()
	{
		return true;
	}

	function defineDescription()
	{
		local player_base = this.getPlayerBase();
		local description = "With no noble house asking for tariffs, you can get very good prices for your goods. ";
		local rarity = 0;
		local buyprice = 0;
		local sellprice = 0;
		if (player_base.m.Size == 1)
		{
			rarity = 1.04;
			buyprice = 1.00;
			sellprice = 1.00;
		}
		else if (player_base.m.Size == 2)
		{
			rarity = 1.08;
			buyprice = 0.95;
			sellprice = 1.05;
		}
		else
		{
			rarity = 1.12;
			buyprice = 0.9;
			sellprice = 1.1;
		}
		description += " \n Item rarity: " + rarity;
		description += " \n Buy price multiplier: " + buyprice;
		description += " \n Sell price multiplier: " + sellprice;
		return description
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onUpdate( _modifiers )
	{ 
		local player_base = this.getPlayerBase();
		if (player_base.m.Size == 1)
		{
			_modifiers.RarityMult = 1.04;
			_modifiers.BuyPriceMult = 1.00;
			_modifiers.SellPriceMult = 1.00;
		}
		else if (player_base.m.Size == 2)
		{
			_modifiers.RarityMult = 1.08;
			_modifiers.BuyPriceMult = 0.95;
			_modifiers.SellPriceMult = 1.05;
		}
		else
		{
			_modifiers.RarityMult = 1.12;
			_modifiers.BuyPriceMult = 0.9;
			_modifiers.SellPriceMult = 1.1;
		}
	}

});

