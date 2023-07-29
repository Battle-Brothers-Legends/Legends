this.legend_spices_blueprint <- this.inherit("scripts/crafting/food_blueprint", {
	m = {},
	function create()
	{
		this.food_blueprint.create();
		this.m.ID = "blueprint.legend_spices";
		this.m.PreviewCraftable = this.new("scripts/items/supplies/legend_cooking_spices_item");
		local ingredients = [
			{
				Script = "scripts/items/trade/spices_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/perks/perk_legend_camp_cook"]
			}
		]
		this.initSkills(skills);			
	}
	
	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
		_stash.add(this.new("scripts/items/supplies/legend_cooking_spices_item"));
	}

});

