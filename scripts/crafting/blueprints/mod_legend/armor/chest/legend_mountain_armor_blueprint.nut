this.legend_mountain_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_mountain_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/armor/legendary/legend_mountain_armor");

		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_armor_mountain_named");
		}

		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 4
			}
		];
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_gambeson",
			Num = 1,
			LegendsArmor = true
		});
		ingredients.push({
			Script = "scripts/items/legend_armor/plate/legend_armor_plate_chest",
			Num = 1,
			LegendsArmor = true
		});
		ingredients.push({
			Script = "scripts/items/armor/coat_of_plates",
			Num = 1,
			LegendsArmor = false
		});
		this.init(ingredients);
		local skills = [
			{
				Scripts = [
					"scripts/skills/backgrounds/legend_blacksmith_background"
				]
			}
		];
		this.initSkills(skills);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			_stash.add(this.new("scripts/items/legend_armor/legendary/legend_armor_mountain_named"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor/legendary/legend_mountain_armor"));
		}
	}

});

