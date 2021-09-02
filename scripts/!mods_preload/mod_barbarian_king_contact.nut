this.getroottable().Const.LegendMod.hookBarbarianKingContract <- function()
{
	::mods_hookExactClass("contracts/contract/barbarian_king_contract", function(o) 
	{
		local createScreens = o.createScreens;
	    o.createScreens = function()
		{
			createScreens();
			foreach (s in this.m.Screens)
			{
				if (s.ID != "AGreaterThreat5")
				{
					continue;
				}

				s.start = function ()
				{
					if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull() && this.Contract.m.Destination.isAlive())
					{
						this.Contract.m.Destination.die();
						this.Contract.m.Destination = null;
					}

					local item = this.Const.World.Common.pickHelmet([[1, "barbarians/heavy_horned_plate_helmet"]]);
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
				break;
			}
		}
	});
	delete this.Const.LegendMod.hookBarbarianKingContract;
}