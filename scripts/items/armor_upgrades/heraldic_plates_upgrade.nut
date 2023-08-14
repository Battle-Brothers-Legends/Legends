this.heraldic_plates_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.heraldic_plates";
		this.m.Name = "Heraldic Shoulderplates";
		this.m.Description = "Large protective plates to be fixed at the shoulders of an armor.";
		this.m.ArmorDescription = "Large protective plates have been fixed at the shoulders of this armor.";
		this.m.Icon = "armor_upgrades/icon_heraldic_plates.png";
		this.m.IconLarge = "legend_armor/upgrades/inventory_heraldic_plates.png";
		this.m.OverlayIcon = "armor_upgrades/icon_heraldic_plates.png";
		this.m.OverlayIconLarge = "legend_armor/upgrades/inventory_heraldic_plates.png";
		this.m.SpriteBack = "upgrade_heraldic_plates";
		this.m.SpriteDamagedBack = "upgrade_heraldic_plates_damaged";
		this.m.SpriteCorpseBack = "upgrade_heraldic_plates_dead";
		this.m.Value = 250;
		this.m.ConditionModifier = 40;
		this.m.StaminaModifier = 5;
	}


	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+40[/color] Durability"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-5[/color] Maximum Fatigue"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

