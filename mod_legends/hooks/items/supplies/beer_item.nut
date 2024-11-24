::mods_hookExactClass("items/supplies/beer_item", function(o) {
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Description = "Provisions. This fermented hop or barley drink is more durable and safer to drink than plain water.  Can either be consumed as provisions or drunk in battle";
		this.m.Amount = 20.0;
		this.m.GoodForDays = 25;
	}

	o.getBuyPrice = function ()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = false;
			return this.Math.floor(this.item.getSellPrice() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getBuyPrice();
	}

	o.onPutIntoBag <- function ()
	{
		this.onEquip();
	}

	o.onEquip <- function ()
	{
		this.food_item.onEquip();
		local skill = this.new("scripts/skills/actives/legend_drink_beer_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});