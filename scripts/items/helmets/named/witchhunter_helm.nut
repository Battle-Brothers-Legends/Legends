this.witchhunter_helm <- this.inherit("scripts/items/helmets/named/named_helmet", {
	m = {},
	function create()
	{
		this.named_helmet.create();
		this.m.ID = "armor.head.witchhunter_helm";
		this.m.Name = "Witchhunter\'s Helm";
		this.m.NameList = [
			"Hunter\'s Mask",
			"Hag Bane",
			"Witch\'s Doom",
			"Hag\'s End",
			"Curse Lifter",
			"Jinx Helm"
		];
		this.m.Description = "A metal helm covered with a distinctive tough leather hat of a witch hunter.";
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
		this.m.ImpactSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.InventorySound = this.Const.Sound.ClothEquip;
		this.m.Value = 2000;
		this.m.Condition = 140;
		this.m.ConditionMax = 140;
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
			text = "Wearer is not affected by night penalties"
		});
		return result;
	}

	function onUpdateProperties( _properties )
	{
		this.named_helmet.onUpdateProperties(_properties);
		_properties.IsAffectedByNight = false;
	}



		function updateVariant()
	{
		local variant = this.m.Variant > 9 ? this.m.Variant : "0" + this.m.Variant;
		this.m.Sprite = "witchhunter_helm_" + variant;
		this.m.SpriteDamaged = "witchhunter_helm_" + variant + "_damaged";
		this.m.SpriteCorpse = "witchhunter_helm_" + variant + "_dead";
		this.m.IconLarge = "helmets/inventory_witchhunter_helm_" + variant + ".png";
		this.m.Icon = "helmets/inventory_witchhunter_helm_" + variant + ".png";
	}

});