this.legend_armor_patched_mail <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Chain
		this.m.ID = "legend_armor.patched_mail";
		this.m.Name = "Patched Mail";
		this.m.Description = "A long and heavy chainmail that offers good protection but is very fatiguing to wear.";
		this.m.ArmorDescription = "Includes a long and heavy chainmail that offers good protection but is very fatiguing to wear.";
		this.m.Icon = "legend_armor/chain/icon_legend_armor_patched_mail.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/chain/icon_legend_armor_patched_mail.png";
		this.m.OverlayIconLarge = "legend_armor/chain/inventory_legend_armor_patched_mail.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "legend_armor_patched_mail";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "legend_armor_patched_mail_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "legend_armor_patched_mail_dead";
		this.m.Value = 250;
		this.m.Condition = 90;
		this.m.ConditionMax = 90;
		this.m.StaminaModifier = 10;
		this.m.ImpactSound = this.Const.Sound.ArmorChainmailImpact;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+90[/color] Durability"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Maximum Fatigue"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
	}

});

