this.legend_restored_ancient_helm <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.legend_restored_ancient_helm";
		this.m.Type = this.Const.Items.ItemType.Helmet;
		this.m.PreviewCraftable = this.new("scripts/items/helmets/ancient/legend_ancient_legionary_helmet_restored");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/helmets/ancient/ancient_legionary_helmet",
				Num = 3,
				LegendsArmor = false
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_dome_tailed",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_face_plate",
				Num = 1,
				LegendsArmor = true
			},
			{
				Script = "scripts/items/legend_helmets/helm/legend_helmet_ancient_legionaire",
				Num = 1,
				LegendsArmor = true
			}
		];
		this.init(ingredients);
	}

	function isQualified()
	{
		return this.blueprint.isQualified();
	}

	function onCraft( _stash )
	{
		local item = this.Const.World.Common.pickHelmet([
			[1, "ancient/legend_ancient_legionary_helmet_restored"]
		])

		item.m.Name = "";
		_stash.add(item);
	}

});

