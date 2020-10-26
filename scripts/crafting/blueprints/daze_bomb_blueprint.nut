this.daze_bomb_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.daze_bomb";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/tools/daze_bomb_item");
		this.m.Cost = 70;
		local ingredients = [
			{
				Script = "scripts/items/misc/glistening_scales_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/petrified_scream_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/daze_bomb_item"));
	}

});

