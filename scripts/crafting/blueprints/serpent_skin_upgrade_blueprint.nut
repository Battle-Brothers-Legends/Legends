this.serpent_skin_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.serpent_skin_upgrade";
		this.m.Type = this.Const.Items.ItemType.Armor;
		this.m.PreviewCraftable = this.new("scripts/items/legend_armor/armor_upgrades/legend_serpent_skin_upgrade");
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
		_stash.add(this.new("scripts/items/legend_armor/armor_upgrades/legend_serpent_skin_upgrade"));
	}

	function isValid()	// Deactives this vanilla recipe as it was replaced by a legends recipe
	{
		return false;
	}

});

