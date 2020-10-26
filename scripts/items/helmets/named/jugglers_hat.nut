this.jugglers_hat <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.jugglers_hat";
		this.m.Name = "Juggler\'s Hat";
		this.m.NameList = [
			"Player\'s Hat",
			"The Play",
			"Folly\'s Friend",
			"Joker\'s Top",
			"Fool\'s crown",
			"Jolly Folly"
		];
		this.m.Description = "The colorful and iconic headpiece of jugglers, even more colourful than a jester cap";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		this.m.Variants = [
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19,
			20,
			21,
			22,
			23,
			24,
			25,
			26,
			27,
			28,
			29,
			30,
			31,
			32,
			33,
			34,
			35,
			36,
			37,
			38,
			39,
			40,
			41,
			42,
			43,
			44,
			45,
			46,
			47,
			48,
			49,
			50,
			51,
			52,
			53,
			54,
			55,
			56,
			57,
			58,
			59,
			60,
			61,
			62,
			63,
			64
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.JesterImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 700;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.m.StaminaModifier = -2;
		this.randomizeValues();
	}


	function getTooltip()
	{
		local result = this.named_helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the wearer a +20% chance to hit the head"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.named_helmet.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 20;
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "jester_hat_" + variant;
		this.m.SpriteDamaged = "jester_hat_" + variant + "_damaged";
		this.m.SpriteCorpse = "jester_hat_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_jester_hat_" + variant + ".png";
	}
});