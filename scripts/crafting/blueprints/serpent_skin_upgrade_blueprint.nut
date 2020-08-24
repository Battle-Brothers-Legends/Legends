this.serpent_skin_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.serpent_skin_upgrade";
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/serpent_skin_upgrade");
		this.m.Cost = 300;
		local ingredients = [
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/ghoul_horn_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_serpent_skin_upgrade"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor_upgrades/serpent_skin_upgrade"));
		}

	}

});

