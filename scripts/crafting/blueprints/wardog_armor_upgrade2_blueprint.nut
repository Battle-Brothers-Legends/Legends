this.wardog_armor_upgrade2_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.wardog_armor_upgrade2";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/misc/wardog_armor_upgrade_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/hyena_fur_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/wardog_armor_upgrade_item"));
	}

});

