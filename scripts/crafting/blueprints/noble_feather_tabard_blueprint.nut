this.noble_feather_tabard_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.noble_feather_tabard_blueprint";
		this.m.Type = this.Const.Items.ArmorUpgrades.Tabbard;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/tabard/legend_noble_tabard");
		this.m.PreviewCraftable.setVariant(5)
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/legend_armor/cloth/legend_tunic",
				Num = 1
			}
		];
		this.init(ingredients);
		local skills = [
			{
				Scripts = ["scripts/skills/backgrounds/female_tailor_background",
							"scripts/skills/backgrounds/tailor_background"]
			}
		]
		this.initSkills(skills);
	}

	function isQualified()
	{
		return  this.World.LegendsMod.Configs().LegendArmorsEnabled()
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_armor/tabard/legend_noble_tabard");
		item.m.Name = "Feather Tabard";
		item.setVariant(5)
		_stash.add(item);
	}

});

