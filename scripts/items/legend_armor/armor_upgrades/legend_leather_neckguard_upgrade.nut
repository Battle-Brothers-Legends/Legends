this.legend_leather_neckguard_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.leather_neckguard";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Leather Neckguard";
		this.m.Description = "This neckguard of cured leather can be attached to any armor for some additional protection.";
		this.m.ArmorDescription = "A neckguard of cured leather has been attached to this armor for additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_13.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_13.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_13.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_13_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_13_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_13_back_dead";
		this.m.Value = 150;
		this.m.Condition = 8;
		this.m.ConditionMax = 8;
		this.m.ConditionModifier = 8;
		this.m.StaminaModifier = 0;
	}

	function onArmorTooltip( _result )
	{
	}

});

