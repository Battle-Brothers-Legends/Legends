this.jugglers_padded_hat <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.jugglers_padded_hat";
		this.m.Name = "Juggler\'s Padded Hat";
		this.m.NameList = [
			"Player\'s Hat",
			"The Play",
			"Folly\'s Friend",
			"Joker\'s Top",
			"Fool\'s crown",
			"Jolly Folly"
		];
		this.m.Description = "A reinforced version of the iconic fools hat, more durable to survive more tumbles";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5,
			6,
			7
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.JesterImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 1000;
		this.m.Condition = 75;
		this.m.ConditionMax = 75;
		this.m.StaminaModifier = -3;
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
		this.m.Sprite = "jester_padded_" + variant;
		this.m.SpriteDamaged = "jester_padded_" + variant + "_damaged";
		this.m.SpriteCorpse = "jester_padded_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_jester_padded_" + variant + ".png";
	}
});