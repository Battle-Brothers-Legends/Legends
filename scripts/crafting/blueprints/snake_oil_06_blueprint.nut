this.snake_oil_06_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_06";
		local ingredients = [
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
