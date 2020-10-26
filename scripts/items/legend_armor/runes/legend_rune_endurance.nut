this.legend_rune_endurance <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.ID = "legend_armor_upgrade.legend_rune_endurance";
		this.m.Type = this.Const.Items.ArmorUpgrades.Rune;
		this.m.Name = "Armor Rune Sigil: Endurance";
		this.m.Description = "An inscribed rock that can be attached to a character\'s armor.";
		this.m.ArmorDescription = "Includes An inscribed rock that grants additional endurance bonuses.";
		this.m.Icon = "rune_sigils/rune_stone_3.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "";
		this.m.OverlayIconLarge = "";
		this.m.SpriteFront = "bust_legend_runed";
		this.m.SpriteBack = "bust_legend_runed";
		this.m.SpriteDamagedFront = "";
		this.m.SpriteDamagedBack = "";
		this.m.SpriteCorpseFront = "";
		this.m.SpriteCorpseBack = "";
		this.m.Value = 1200;
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Fatigue recovery per turn.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Fatigue cost and effects multiplier."
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "This item has the power of the rune sigil of Endurance:\n[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RuneBonus1 + "[/color] Fatigue recovery per turn.\n[color=" + this.Const.UI.Color.PositiveValue + "]-" + this.m.RuneBonus2 + "%[/color] Fatigue cost and effects multiplier."
		});
	}

    function onDamageReceived( _damage, _fatalityType, _attacker )
	{
        return _damage;
	}

	function onUpdateProperties( _properties )
	{
		this.legend_armor_upgrade.onUpdateProperties(_properties);
        _properties.FatigueRecoveryRate += this.m.RuneBonus1;
		_properties.FatigueEffectMult *= (1.0 - ((this.m.RuneBonus2) * 1.0) / 100.0);
	}

});

