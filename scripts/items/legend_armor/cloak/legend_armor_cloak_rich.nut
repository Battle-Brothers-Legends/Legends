this.legend_armor_cloak_rich <- this.inherit("scripts/items/legend_armor/legend_named_armor_upgrade", {
	m = {
		BraveryMult = 1.03
	},
	function create()
	{
		this.legend_named_armor_upgrade.create();
		this.m.Type = this.Const.Items.ArmorUpgrades.Cloak
		this.m.ID = "legend_armor.cloak_rich";
		this.m.Name = "";
		this.m.NameList = [
			"Kingly",
			"Splendor",
			"Pageantry",
			"Swank",
			"Noble",
			"Undead"
		];
		this.m.Description = "A silk embroidered cloak made with the finest clothes. Those who wear it feel as if a king";
		this.m.ArmorDescription = "Has a flowing embroidered cloak";
		this.m.Variants = [1,2,3,4,5];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 25000;
		this.m.Condition = 25;
		this.m.ConditionMax = 25;
		this.m.StaminaModifier = -3;
		this.randomizeValues()
	}

	function randomizeValues()
	{
		this.m.Condition = this.Math.floor(this.m.Condition * this.Math.rand(25, 40) * 0.01) * 1.0;
		this.m.ConditionMax = this.m.Condition;
		this.m.BraveryMult = this.Math.rand(103, 108) * 0.01;
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.SpriteBack = "cloak_rich_" + variant + "";
		this.m.SpriteDamagedBack = "cloak_rich_" + variant + "_damaged";
		this.m.SpriteCorpseBack = "cloak_rich_" + variant + "_dead";
		this.m.Icon = "legend_armor/cloak/cloak_rich_" + variant + ".png";
		this.m.IconLarge = this.m.Icon;
		this.m.OverlayIcon = "legend_armor/cloak/icon_cloak_rich_" + variant + ".png";
		this.m.OverlayIconLarge = "legend_armor/cloak/inventory_cloak_rich_"  + variant + ".png";
	}

	function getTooltip()
	{
		local result = this.legend_named_armor_upgrade.getTooltip();
		local val = this.Math.floor(this.m.BraveryMult * 100.0 - 100);
		result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase the Resolve of the wearer by [color=" + this.Const.UI.Color.PositiveValue + "]+" + val + "%[/color]"
		});
		return result;
	}

	function onArmorTooltip( _result )
	{
		local val = this.Math.floor(this.m.BraveryMult * 100.0 - 100);
		_result.push({
			id = 15,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Increase the Resolve of the wearer by [color=" + this.Const.UI.Color.PositiveValue + "]+" + val +"%[/color]"
		});
	}

	function onUpdateProperties( _properties )
	{
		_properties.BraveryMult *= this.m.BraveryMult;
	}

	function onSerialize( _out )
	{
		_out.writeF32(this.m.BraveryMult);
		this.legend_named_armor_upgrade.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.m.BraveryMult = _in.readF32();
		this.legend_named_armor_upgrade.onDeserialize(_in);
	}

});

