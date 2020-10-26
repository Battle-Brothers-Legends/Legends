this.legend_armor_cloak <- this.inherit("scripts/items/legend_armor/legend_armor_upgrade", {
	m = {
		Bravery = 1
	},
	function create()
	{
		this.legend_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak
		this.m.ID = "legend_armor.cloak";
		this.m.Name = "Cloak";
		this.m.Description = "The Cloak. Everyone needs a good cloak. Offers minimal protection and small boost to moral.";
		this.m.ArmorDescription = "Has a flowing cloth cloak";
		this.m.Variant = this.Math.rand(1, 35);
		this.updateVariant();
		this.m.Value = 350;
		this.m.Condition = 3;
		this.m.ConditionMax = 3;
		this.m.StaminaModifier = -1;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "cloak_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_" + variant + "_dead";
		this.m.Icon = "legend_armor/cloak/cloak_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/cloak/icon_cloak_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/cloak/inventory_cloak_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_armor_upgrade.getTooltip();
		this.onArmorTooltip(result)
		return result;
	}

	function onArmorTooltip( _result )
	{
		if (this.m.Bravery > 0)
		{
			_result.push({
				id = 15,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Increase the Resolve of the wearer by [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.Bravery + "[/color]"
			});
		}
	}

	function onUpdateProperties( _properties )
	{
		_properties.Bravery += this.m.Bravery;
	}

});

