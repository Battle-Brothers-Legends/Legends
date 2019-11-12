this.horn_plate_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.horn_plate_upgrade";
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/horn_plate_upgrade");
		this.m.Cost = 650;
		local ingredients = [
			{
				Script = "scripts/items/misc/kraken_horn_plate_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		if (this.Const.LegendMod.Configs.LegendArmorsEnabled())
		{
			_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_horn_plate_upgrade"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor_upgrades/horn_plate_upgrade"));
		}

	}

});

