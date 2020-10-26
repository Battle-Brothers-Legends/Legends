this.death_jesters_helm <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.death_jesters_helm";
		this.m.Name = "Death Jester\'s Helm";
		this.m.NameList = [
			"Solitaire\'s Hood",
			"The Masque",
			"Harlequin\'s Visage",
			"The Silent Shroud",
			"Reaper\'s Mirth",
			"The Dawning Hope",
			"Shattered Mirage",
			"Cegorach\'s gaze"
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
			6
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.JesterImpact;
		this.m.InventorySound = this.Const.Sound.JesterImpact;
		this.m.Value = 10000;
		this.m.Condition = 300;
		this.m.ConditionMax = 300;
		this.m.StaminaModifier = -20;
		this.m.Vision = -2;
		this.randomizeValues();
	}


	function getTooltip()
	{
		local result = this.named_helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Grants the wearer a +30% chance to hit the head"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{

		this.named_helmet.onUpdateProperties(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 30;
		
	}

	function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "jester_helm_" + variant;
		this.m.SpriteDamaged = "jester_helm_" + variant + "_damaged";
		this.m.SpriteCorpse = "jester_helm_" + variant + "_dead";
		this.m.IconLarge = "";
		this.m.Icon = "helmets/inventory_jester_helm_" + variant + ".png";
	}
});