this.fire_bomb_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.fire_bomb";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/tools/fire_bomb_item");
		this.m.Cost = 100;
		local ingredients = [
			{
				Script = "scripts/items/misc/sulfurous_rocks_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/ghoul_teeth_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/fire_bomb_item"));
	}

});

