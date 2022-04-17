this.hyena_fur_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.hyena_fur_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		if (!::Legends.Mod.ModSettings.getSetting("unlayeredArmor").getValue())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade");
		}
		else
		{
			this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/hyena_fur_upgrade");
		}
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/misc/hyena_fur_item",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		if (!::Legends.Mod.ModSettings.getSetting("unlayeredArmor").getValue())
		{
			_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor_upgrades/hyena_fur_upgrade"));
		}

	}

});

