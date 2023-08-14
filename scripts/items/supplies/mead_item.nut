this.mead_item <- this.inherit("scripts/items/supplies/legend_usable_food", {
	m = {},
	function create()
	{
		this.legend_usable_food.create();
		this.m.ID = "supplies.mead";
		this.m.Name = "Mead";
		this.m.Description = "Provisions. An alcoholic beverage made from honey. Both durable and tasty. Can be drunk in battle to grant +9% resolve, melee and ranged skill. At the expense of -36% initiative and -18% melee defense and ranged defense, the effect lasts for three turns. Will be used as provisions while travelling if left in the company stash.";
		this.m.Icon = "supplies/inventory_provisions_12.png";
		this.m.Value = 210;
		this.m.Amount = 45.0;
		this.m.GoodForDays = 16;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.beekeeper");
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getPriceMult() * this.World.State.getCurrentTown().getFoodPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() * (isBuildingPresent ? this.Const.World.Assets.BaseBuyPrice : this.Const.World.Assets.BuyPriceNotProducedHere)));
		}

		return this.item.getBuyPrice();
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local isBuildingPresent = this.World.State.getCurrentTown().hasAttachedLocation("attached_location.beekeeper");
			return this.Math.floor(this.item.getSellPrice() * (isBuildingPresent ? this.Const.World.Assets.BaseSellPrice : this.Const.World.Assets.SellPriceNotProducedHere));
		}

		return this.item.getSellPrice();
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

	function onEquip()
	{
		this.legend_usable_food.onEquip();
		local skill = this.new("scripts/skills/actives/legend_drink_mead_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}
});

