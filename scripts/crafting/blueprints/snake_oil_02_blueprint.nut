this.snake_oil_02_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_02";
		local ingredients = [
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/glistening_scales_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
