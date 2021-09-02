this.legend_double_mail_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.double_mail";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Double Mail";
		this.m.Description = "A thick double mail patch. Heavy, but effective in further adding to an armor\'s protection.";
		this.m.ArmorDescription = "A thick double mail has been added to this armor for further protection.";
		this.m.Icon = "armor_upgrades/upgrade_19.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_19.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_19.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_19_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_19_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_19_back_dead";
		this.m.Value = 225;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.ConditionModifier = 20;
		this.m.StaminaModifier = -3;
	}


	function onArmorTooltip( _result )
	{
	}

});

