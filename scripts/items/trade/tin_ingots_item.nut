this.tin_ingots_item <- this.inherit("scripts/items/trade/trading_good_item", {
	m = {},
	function create()
	{
		this.trading_good_item.create();
		this.m.ID = "misc.tin_ingots";
		this.m.Name = "Tin Ingots";
		this.m.Description = "Tin smolten and cast into ingots for easy transportation. Used together with Copper to make Bronze.";
		this.m.Icon = "trade/inventory_trade_tin_bars.png";
		this.m.Culture = this.Const.World.Culture.Northern;
		this.m.ProducingBuildings = [
			"attached_location.trapper"
		];
		this.m.Value = 420;
		this.m.ResourceValue = 2;
	}

});

