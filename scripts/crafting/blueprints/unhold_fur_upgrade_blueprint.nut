this.unhold_fur_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.unhold_fur_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_unhold_fur_upgrade");
		}
		else
		{
			this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/unhold_fur_upgrade");
		}
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/misc/frost_unhold_fur_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_unhold_fur_upgrade"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor_upgrades/unhold_fur_upgrade"));
		}

	}

	function isValid()	// Deactives this vanilla recipe as it was replaced by a legends recipe
	{
		return false;
	}

});

