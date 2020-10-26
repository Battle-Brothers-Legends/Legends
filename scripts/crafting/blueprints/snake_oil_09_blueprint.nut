this.snake_oil_09_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.snake_oil_09";
		this.m.Type = this.Const.Items.ItemType.Usable
		this.m.PreviewCraftable = this.new("scripts/items/misc/snake_oil_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/misc/petrified_scream_item",
				Num = 2
			},
			{
				Script = "scripts/items/misc/adrenaline_gland_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function isCraftable()
	{
		if (!this.World.Retinue.hasFollower("follower.alchemist"))
		{
			return false;
		}

		return this.blueprint.isCraftable();
	}

	function isQualified()
	{
		if (this.World.LegendsMod.Configs().LegendAllBlueprintsEnabled())
		{
			return true;
		}

		if (!this.World.Retinue.hasFollower("follower.alchemist"))
		{
			return false;
		}

		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/snake_oil_item"));
	}

});

