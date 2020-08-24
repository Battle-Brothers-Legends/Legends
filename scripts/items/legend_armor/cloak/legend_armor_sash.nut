
this.legend_armor_sash <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak;
		this.m.ID = "legend_armor.body.legend_armor_sash";
		this.m.Name = "Sash";
		this.m.Description = "Sash.";
		this.m.ArmorDescription = "Has a flowing cloth sash";
		this.m.Variants = [1];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 150;
		this.m.Condition = 3;
		this.m.ConditionMax = 3;
		this.m.StaminaModifier = -1;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.SpriteBack = "bust_legend_armor_sash" + "_" + variant;
		this.m.SpriteDamagedBack = "bust_legend_armor_sash" + "_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "bust_legend_armor_sash" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/cloak/legend_armor_sash" + "_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/cloak/icon_legend_armor_sash" + "_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/cloak/inventory_legend_armor_sash" + "_" + variant + ".png";
	}
});
