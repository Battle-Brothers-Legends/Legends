this.legend_armor_orc_loincloth <- this.inherit("scripts/items/legend_armor/legend_armor", {
	m = {},
	function create()
	{
		this.legend_armor.create();
		this.m.ID = "legend_armor.body.orc_loincloth";
		this.m.Name = "Orcish loincloth";
		this.m.Description = "A grotty loincloth.";
		this.m.Variants = [
			1
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ArmorLeatherImpact;
		this.m.Value = 1;
		this.m.Condition = 1;
		this.m.ConditionMax = 1;
		this.m.StaminaModifier = -4;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = true;
		this.m.ItemType = this.m.ItemType;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "bust_orc_loincloth" + "_" + variant;
		this.m.SpriteDamaged = "bust_orc_loincloth" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "bust_orc_loincloth" + "_" + variant + "_dead";
		this.m.Icon = "legend_armor/icon_orc_loincloth" + "_" + variant + ".png";
		this.m.IconLarge = "legend_armor/inventory_orc_loincloth" + "_" + variant + ".png";
	}

});
