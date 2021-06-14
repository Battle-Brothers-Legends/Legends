this.legend_mummy_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_mummy_shield";
		this.m.Name = "Ancient Southern Shield";
		this.m.Description = "An shield made of wood and reinforced with bronze. Time has taken its toll and the wood has become brittle.";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [
			1,
			2,
			3,
			4,
			5
		];
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() - 1)];
		this.updateVariant();
		this.m.Value = 200;
		this.m.MeleeDefense = 10;
		this.m.RangedDefense = 12;
		this.m.StaminaModifier = -6;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
	}

	function updateVariant()
	{
		this.m.Sprite = "mummy_shield_0" + this.m.Variant;
		this.m.SpriteDamaged = "mummy_shield_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "mummy_shield_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_mummy_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_mummy_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

