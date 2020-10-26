this.jesters_hat <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.jesters_hat";
		this.m.Name = "Jester\'s Hat";
		this.m.Description = "The colorful and iconic headpiece of jesters, entertainers and other traveling folk.";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = false;
		this.m.ReplaceSprite = true;
		this.m.Variants = [1,2,3,4,5,6,7,8,9,10,11];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.JesterImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 70;
		this.m.Condition = 35;
		this.m.ConditionMax = 35;
		this.m.StaminaModifier = 0;
	}


	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the wearer a +10% chance to hit the head"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{

		this.helmet.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
		

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