this.hyena_fur_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.hyena_fur_upgrade";
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/hyena_fur_upgrade");
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
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_hyena_fur_upgrade"));
		}
		else
		{
			_stash.add(this.new("scripts/items/armor_upgrades/hyena_fur_upgrade"));
		}

	}

});

