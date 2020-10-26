this.legend_warlock_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_warlock_cloak";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/armor/named/legend_named_warlock_cloak");
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak");
		}
		this.m.Cost = 2000;
		local ingredients = [
			{
				Script = "scripts/items/misc/witch_hair_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/parched_skin_item",
				Num = 2
			},
		{
				Script = "scripts/items/supplies/strange_meat_item",
				Num = 1
			}
		];
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_tunic",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_dark_tunic",
			Num = 1,
			LegendsArmor = true
		})

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
		if (!this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			return false
		}

		return this.blueprint.isQualified()
	}

	function onCraft( _stash )
	{
		local item
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			item = this.new("scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak");
		}
		else
		{
			item = this.new("scripts/items/armor/named/legend_named_warlock_cloak");
		}
		item.m.Name = "";
		_stash.add(item);
	}

});

