this.legend_stollwurm_scales_upgrade <- this.inherit("scripts/items/armor_upgrades/armor_upgrade", {
	m = {},
	function create()
	{
		this.armor_upgrade.create();
		this.m.ID = "armor_upgrade.legend_stollwurm_scales";
		this.m.Name = "Stollwurm Scale Cloak";
		this.m.Description = "A cloak made out of the scales of a Stollwurm. Not only is it a rare and impressive trophy, it also offers additional protection";
		this.m.ArmorDescription = "A cloak made out of Stollwurm scales is worn over this armor for additional protection.";
		this.m.Icon = "armor_upgrades/upgrade_04.png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "armor_upgrades/icon_upgrade_04.png";
		this.m.OverlayIconLarge = "armor_upgrades/inventory_upgrade_04.png";
		this.m.SpriteFront = null;
		this.m.SpriteBack = "upgrade_stollwurm_back";
		this.m.SpriteDamagedFront = null;
		this.m.SpriteDamagedBack = "upgrade_stollwurm_back_damaged";
		this.m.SpriteCorpseFront = null;
		this.m.SpriteCorpseBack = "upgrade_stollwurm_back_dead";
		this.m.Value = 3200;
		this.m.ConditionModifier = 80;
		this.m.StaminaModifier = -4;
	}

	function getTooltip()
	{
		local result = this.armor_upgrade.getTooltip();
		result.push({
			id = 13,
			type = "text",
			icon = "ui/icons/armor_body.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+80[/color] Durability"
		});
		result.push({
			id = 14,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]+4[/color] Maximum Fatigue"
		});
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		_result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Immune to stun"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.IsImmuneToStun = true;
	}

});

