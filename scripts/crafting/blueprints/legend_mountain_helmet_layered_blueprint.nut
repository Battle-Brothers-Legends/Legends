this.legend_mountain_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_mountain_helmet_layered";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/vanity/legend_helmet_mountain_helm");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_great_helm",
				Num = 1,
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 2
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/legend_blacksmith_background"]
			}
		]
		this.initSkills(skills);
	}


	function isQualified()
	{
		if (!this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			return false
		}

		return this.blueprint.isQualified()
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_helmets/vanity/legend_helmet_mountain_helm"));
	}

});

