this.legend_restored_ancient_chest <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_restored_ancient_chest";
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest_restored");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest",
				Num = 3
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return true;
	}

	function onCraft( _stash )
	{

		item = this.new("scripts/items/legend_armor/plate/legend_armor_plate_ancient_chest_restored");


		item.m.Name = "";
		_stash.add(item);
	}

});

