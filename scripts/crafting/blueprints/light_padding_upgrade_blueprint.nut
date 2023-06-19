this.light_padding_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.light_padding_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade");
		this.m.Cost = 450;
		local ingredients = [
			{
				Script = "scripts/items/misc/spider_silk_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/glowing_resin_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_padding_replacement_upgrade"));
	}

});

