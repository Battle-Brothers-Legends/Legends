this.snake_oil_04_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_04";
		local ingredients = [
			{
				Script = "scripts/items/misc/ghoul_brain_item",
				Num = 3
			},
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
