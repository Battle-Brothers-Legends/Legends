this.legend_redback_helmet_layered_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_redback_helmet_layered";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/legend_helmets/vanity/legend_helmet_redback_helm");
		this.m.Cost = 2500;
		local ingredients = [
			{
				Script = "scripts/items/misc/legend_redback_poison_gland_item",
				Num = 3
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_barbute",
				Num = 1
			},
			{
				Script = "scripts/items/legend_helmets/hood/legend_helmet_simple_hood",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return !::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() && this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local item = this.new("scripts/items/legend_helmets/vanity/legend_helmet_redback_helm");
		_stash.add(item);
	}

});

