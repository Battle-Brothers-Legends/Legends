this.snake_oil_08_blueprint <- this.inherit("scripts/crafting/snake_oil_blueprint", {
	m = {},
	function create()
	{
		this.snake_oil_blueprint.create();
		this.m.ID = "blueprint.snake_oil_08";
		local ingredients = [
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/third_eye_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}
});
