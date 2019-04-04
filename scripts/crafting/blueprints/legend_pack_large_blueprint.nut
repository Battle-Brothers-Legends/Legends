this.legend_pack_large_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_pack_large";
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_pack_large");
		this.m.Cost = 1250;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return true;
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_pack_large"));
	}

});
