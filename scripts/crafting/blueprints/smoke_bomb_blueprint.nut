this.smoke_bomb_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.smoke_bomb";
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/tools/smoke_bomb_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/acidic_saliva_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/ghoul_brain_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/tools/smoke_bomb_item"));
	}

});

