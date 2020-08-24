this.legend_lindwurm_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_lindwurm_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor");
		this.m.Cost = 3500;
		local ingredients = [
			{
				Script = "scripts/items/misc/lindwurm_scales_item",
				Num = 4
			},
		];
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_padded_surcoat",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/legend_armor/chain/legend_armor_basic_mail",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/legend_armor/plate/legend_armor_scale_coat",
			Num = 1,
			LegendsArmor = true
		})
		ingredients.push({
			Script = "scripts/items/armor/coat_of_scales",
			Num = 1,
			LegendsArmor = false
		})

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
		return true;
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/legendary/legend_lindwurm_armor"));
	}

});

