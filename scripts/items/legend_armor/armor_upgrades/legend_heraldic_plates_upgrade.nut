this.legend_heraldic_plates_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.heraldic_plates";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "Heraldic Shoulderplates";
		this.m.Description = "Large protective plates to be fixed at the shoulders of an armor.";
		this.m.ArmorDescription = "Large protective plates have been fixed at the shoulders of this armor.";
		this.m.Variant = this.Math.rand(14, 18);
		this.updateVariant();
		this.m.Value = 2700;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
		this.m.ConditionModifier = 30;
		this.m.StaminaModifier = -3;
	}

	function updateVariant()
	{
		local variant = this.m.Variant;

		if (variant < 10)
		{
			variant = "0" + variant;
		}

		this.m.Icon = "armor_upgrades/upgrade_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_" + variant + ".png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_" + variant + ".png";
		this.m.SpriteFront = "upgrade_" + variant + "_front";
		this.m.SpriteBack = "upgrade_" + variant + "_back";
		this.m.SpriteDamagedFront = "upgrade_" + variant + "_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_" + variant + "_back_damaged";
		this.m.SpriteCorpseFront = "upgrade_" + variant + "_front_dead";
		this.m.SpriteCorpseBack = "upgrade_" + variant + "_back_dead";
	}


	function onArmorTooltip( _result )
	{
	}

});

