this.legend_cured_rations_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_cured_rations";
		this.m.Type = this.Const.Items.ItemType.Food;
		this.m.PreviewCraftable = this.new("scripts/items/supplies/cured_rations_item");
		this.m.Cost = 40;
		local ingredients = [
			{
				Script = "scripts/items/supplies/dried_fruits_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/legend_cooking_spices_trade_item",
				Num = 1
			},
			{
				Script = "scripts/items/supplies/cured_venison_item",
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
		_stash.add(this.new("scripts/items/supplies/cured_rations_item"));
	}

});

