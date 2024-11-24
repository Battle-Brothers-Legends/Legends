this.legend_armored_hound_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_armored_hound";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/accessory/legend_warhound_item");
		this.m.Cost = 120;
		local ingredients = [
			{
				Script = "scripts/items/accessory/legend_armored_warhound_item",
				Num = 2
			},
			{
				Script = "scripts/items/supplies/legend_fresh_meat_item",
				Num = 3
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/perks/perk_legend_dogbreeder"
				]
			}
		];
		this.initSkills(skills);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/accessory/legend_armored_warhound_item"));
		_stash.add(this.new("scripts/items/accessory/legend_armored_warhound_item"));
		_stash.add(this.new("scripts/items/accessory/legend_warhound_item"));
	}

});

