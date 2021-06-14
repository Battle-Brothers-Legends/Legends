this.legend_mummy_tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_mummy_tower_shield";
		this.m.Name = "Ancient Southern Tower Shield";
		this.m.Description = "A tall and heavy southern tower shield that offers good protection, but is very bulky to handle.";
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
		this.m.Value = 400;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 10;
		this.m.StaminaModifier = -14;
		this.m.Condition = 30;
		this.m.ConditionMax = 30;
	}

	function updateVariant()
	{
		this.m.Sprite = "mummy_towershield_0" + this.m.Variant;
		this.m.SpriteDamaged = "mummy_towershield_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "mummy_towershield_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_mummy_towershield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_mummy_towershield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

