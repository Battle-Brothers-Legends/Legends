this.snake_oil_11_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_11";
		local ingredients = [
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}
});
