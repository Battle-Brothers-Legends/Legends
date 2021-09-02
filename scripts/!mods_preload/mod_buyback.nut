this.getroottable().Const.LegendMod.loadBuyback <- function()
{
	::mods_hookBaseClass("items/item", function ( o )
	{
		while(!("setSold" in o)) o = o[o.SuperName];

		o.setSold = function (sold)
		{
			if(!sold || this.isSold()) this.m.IsSold = false;
			else if(this.isBought())
			{
				this.m.IsBought = false;
				this.m.IsSold = false;
			}
			else this.m.IsSold = true;
		}

		o.setBought = function (bought)
		{
			if(!bought || this.isBought()) this.m.IsBought = false;
			else if(this.isSold())
			{
				this.m.IsSold = false;
				this.m.IsBought = false;
			}
			else this.m.IsBought = true;
		}
	});

	::mods_hookDescendants("items/item", function ( o )
	{
		local getSellPrice = ::mods_getMember(o, "getSellPrice");
		o.getSellPrice <- function ()
		{
			local originalTime;
			if (::mods_isClass(this, "legend_usable_food") && this.getSpoilInDays() > this.m.GoodForDays)
			{
				originalTime = this.m.BestBefore;
				this.m.BestBefore = 0;
			}
			local sellPrice;

			if (this.isBought())
			{
				this.m.IsBought = false;
				sellPrice = getBuyPrice();
				this.m.IsBought = true;
			}
			else 
			{
				sellPrice =  getSellPrice();
			}

			if (originalTime != null)
			{
				this.m.BestBefore = originalTime;
			}

			return sellPrice;
		}

		local getBuyPrice = ::mods_getMember(o, "getBuyPrice");
		o.getBuyPrice <- function ()
		{
			if (this.isSold())
			{				
				this.m.IsSold = false;
				local sellPrice = this.getSellPrice();
				this.m.IsSold = true;
				return sellPrice;
			}
			else 
			{
				local originalTime;
				if (::mods_isClass(this, "legend_usable_food") && this.getSpoilInDays() > this.m.GoodForDays)
				{
					if (this.getSpoilInDays() > this.m.GoodForDays)
					{
						originalTime = this.m.BestBefore;
						this.m.BestBefore = 0;
					}
				}
				local buyPrice = getBuyPrice();
				if (originalTime != null)
				{
					this.m.BestBefore = originalTime;
				}
				return buyPrice;
			}
		}
	});
	delete this.Const.LegendMod.loadBuyback;
}