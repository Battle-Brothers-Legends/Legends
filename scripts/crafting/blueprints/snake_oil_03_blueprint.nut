this.snake_oil_03_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_03";
		local ingredients = [
			{
				Script = "scripts/items/misc/ghoul_brain_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
