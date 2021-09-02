this.snake_oil_13_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_13";
		local ingredients = [
			{
				Script = "scripts/items/misc/werewolf_pelt_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
