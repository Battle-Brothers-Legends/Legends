this.snake_oil_12_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_12";
		local ingredients = [
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/glistening_scales_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
