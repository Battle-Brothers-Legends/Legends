this.legend_armor_white_wolf_pelt_upgrade <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.legend_white_wolf_pelt";
		this.m.Type = this.Const.Items.ArmorUpgrades.Attachment;
		this.m.Name = "White Wolf Pelt Mantle";
		this.m.Description = "A pelt taken from a white wolf, cured and sewn together to be worn as a beast hunter\'s trophy around the neck. Donning the skin of a beast like this can turn one into an imposing figure.";
		this.m.ArmorDescription = "A mantle of the white wolf has been attached to this armor, which transforms the wearer into an imposing figure.";
		this.m.Icon = "armor_upgrades/upgrade_white_wolf.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_01.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_white_wolf.png";
		this.m.SpriteFront = "upgrade_white_wolf_front";
		this.m.SpriteBack = "upgrade_white_wolf_back";
		this.m.SpriteDamagedFront = "upgrade_white_wolf_front_damaged";
		this.m.SpriteDamagedBack = "upgrade_white_wolf_back";
		this.m.SpriteCorpseFront = "upgrade_white_wolf_front_dead";
		this.m.SpriteCorpseBack = "upgrade_white_wolf_back_dead";
		this.m.Value = 6000;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
		this.m.ConditionModifier = 20;
		this.m.StaminaModifier = -1;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Reduces the Resolve of any opponent engaged in melee by [color=" + this.Const.UI.Color.NegativeValue + "]-20[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
		_properties.Threat += 10;
	}

});

