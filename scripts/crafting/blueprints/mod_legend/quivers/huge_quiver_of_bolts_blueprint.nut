this.huge_quiver_of_bolts_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.huge_quiver_of_bolts";
		this.m.Type = this.Const.Items.ItemType.Accessory;
		this.m.PreviewCraftable = this.new("scripts/items/ammo/huge_quiver_of_bolts");
		this.m.Cost = 3000;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_ancient_green_wood_item",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/female_bowyer_background",
							"scripts/skills/backgrounds/bowyer_background"]
			}
		]
		this.initSkills(skills);	
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/ammo/huge_quiver_of_bolts"));
	}

});

