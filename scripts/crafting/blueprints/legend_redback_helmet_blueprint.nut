this.legend_redback_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_redback_helmet";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/helmets/legendary/legend_redback_helmet");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_redback_poison_gland_item",
				Num = 1
			},
			{
				Script = "scripts/items/helmets/barbute_helmet",
				Num = 1
			},
			{
				Script = "scripts/items/helmets/hood",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		if (!this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			return false;
		}

		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/helmets/legendary/legend_redback_helmet");
		item.m.Name = "";
		_stash.add(item);
	}

});

