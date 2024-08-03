this.legend_armor_orc_scale <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.legend_armor_orc_scale";
		this.m.Name = "Orcish Scale Armor";
		this.m.Description = "A body vest of solid scaled steel made from multiple armors.";
		this.m.ArmorDescription = "Includes a body vest of scale steel.";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 2000;
		this.m.Condition = 160;
		this.m.ConditionMax = 160;
		this.m.StaminaModifier = -35;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ust_orc_scale" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_orc_scale" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_orc_scale" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_orc_scale" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_orc_scale" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_orc_scale" + "_" + variant + ".png";
	}

});
