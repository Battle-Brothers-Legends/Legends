this.legend_armor_orc_loincloth <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Plate;
		this.m.ID = "legend_armor.body.legend_armor_orc_loincloth";
		this.m.Name = "Loincloth";
		this.m.Description = "A filthy loincloth";
		this.m.ArmorDescription = "Includes a loincloth.";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorBoneImpact;
		this.m.InventorySound = this.Const.Sound.ArmorBoneImpact;
		this.m.Value = 1;
		this.m.Condition = 1;
		this.m.ConditionMax = 1;
		this.m.StaminaModifier = 0;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "ust_orc_loincloth" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_orc_loincloth" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_orc_loincloth" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_orc_loincloth" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/icon_orc_loincloth" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/inventory_orc_loincloth" + "_" + variant + ".png";
	}

});
