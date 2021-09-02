this.snake_oil_05_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_05";
		local ingredients = [
			{
				Script = "scripts/items/misc/glistening_scales_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/ghoul_teeth_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
