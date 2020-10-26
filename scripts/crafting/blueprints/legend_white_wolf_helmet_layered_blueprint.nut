this.legend_white_wolf_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_white_wolf_helmet_layered";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/vanity/legend_helmet_white_wolf_helm");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_white_wolf_pelt_item",
				Num = 2
			},
			{
				Script = "scripts/items/legend_helmets/hood/legend_helmet_chain_hood",
				Num = 1
			}
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_basinet",
				Num = 1
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
		local item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_white_wolf_helm");
		//item.m.Name = "";
		_stash.add(item);
	}

});

