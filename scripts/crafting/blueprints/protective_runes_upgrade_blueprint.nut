this.protective_runes_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.protective_runes_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/armor_upgrades/protective_runes_upgrade");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/misc/vampire_dust_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/parched_skin_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/witch_hair_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_protective_runes_upgrade"));
	}

});

