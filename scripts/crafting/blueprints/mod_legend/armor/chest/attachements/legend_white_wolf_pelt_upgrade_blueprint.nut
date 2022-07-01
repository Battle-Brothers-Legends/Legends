this.legend_white_wolf_pelt_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_white_wolf_pelt_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_white_wolf_pelt_upgrade");
		}
		else
		{
			this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/legend_white_wolf_pelt_upgrade");
		}
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_white_wolf_pelt_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_armor_white_wolf_pelt_upgrade"));
		}
		else
		{
		_stash.add(this.new("scripts/items/armor_upgrades/legend_white_wolf_pelt_upgrade"));
		}

	}

});

