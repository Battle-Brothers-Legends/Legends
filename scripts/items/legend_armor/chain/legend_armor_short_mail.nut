this.legend_armor_short_mail <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain
		this.m.ID = "legend_armor.short_mail";
		this.m.Name = "Light Mail";
		this.m.Description = "A shorter and lighter chainmail that offers good protection and is fatiguing to wear.";
		this.m.ArmorDescription = "Includes a shorter and lighter chainmail that offers good protection but is fatiguing to wear.";
		this.m.Icon = "legend_armor/chain/icon_legend_short_mail.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/chain/icon_legend_short_mail.png";
		this.m.OverlayIconLarge = "legend_armor/chain/inventory_legend_short_mail.png";
		this.m.SpriteBack = "legend_short_mail";
		this.m.SpriteDamagedBack = "legend_short_mail_damaged";
		this.m.SpriteCorpseBack = "legend_short_mail_dead";
		this.m.Value = 450;
		this.m.Condition = 115;
		this.m.ConditionMax = 115;
		this.m.StaminaModifier = 12;
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
		this.m.InventorySound = this.Const.Sound.ArmorChainmailImpact;
	}

});

