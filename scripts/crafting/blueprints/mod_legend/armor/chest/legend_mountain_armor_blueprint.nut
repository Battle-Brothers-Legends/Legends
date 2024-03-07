this.legend_mountain_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_mountain_armor";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/legendary/legend_armor_mountain");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_rock_unhold_bones_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/legend_rock_unhold_hide_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/unhold_hide_item",
				Num = 4
			}
		];
		ingredients.push({
			Script = "scripts/items/legend_armor/cloth/legend_padded_surcoat",
			Num = 1,
			LegendsArmor = true
		});
		ingredients.push({
			Script = "scripts/items/legend_armor/plate/legend_armor_plate_chest",
			Num = 1,
			LegendsArmor = true
		});
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/legend_armor/legendary/legend_armor_mountain"));
	}

});

