
this.legend_helmet_top_plume <- this.inherit("scripts/items/legend_helmets/legend_helmet_upgrade", {
	m = {},
	function create()
	{
		this.legend_helmet_upgrade.create();
		this.m.Type = this.Const.Items.HelmetUpgrades.Vanity;
		this.m.ID = "armor.head.legend_helmet_top_plume";
		this.m.Name = "Top Plume";
		this.m.Description = "Top Plume";
		this.m.ArmorDescription = this.m.Description;
		this.m.Variants = [1];
        this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
		this.m.Value = 20;
		this.m.Condition = 1;
		this.m.ConditionMax = 1;
		this.m.StaminaModifier = 0;
		this.m.Vision = 0;
		this.m.IsLowerVanity = true;
		this.m.HideHair = false;
		this.m.HideBeard = false;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "legendhelms_top_plume" + "_" + variant;
		this.m.SpriteDamaged = "legendhelms_top_plume" + "_" + variant + "_damaged";
		this.m.SpriteCorpse = "legendhelms_top_plume" + "_" + variant + "_dead";
		this.m.Icon = "legend_helmets/inventory_top_plume" + "_" + variant + ".png";
        this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = this.m.Icon;
		this.m.OverlayIconLarge = this.m.OverlayIcon;
	}
});
