this.legend_named_parrying_dagger <- this.inherit("scripts/items/shields/named/named_shield", {
	m = {
		Variants = []
	},
	function create()
	{
		this.named_shield.create();
		this.m.ID = "shield.legend_named_parrying_dagger";
		this.m.NameList = this.Const.Strings.DaggerNames;
		this.m.Description = "An exquisite offhand dagger for actively parrying an opponent, reducing their defenses by 10. Parry is also applied passively when an opponent misses you. Provides 20 melee defense vs a single opponents, and 15 defense while surrounded by more than one. Split Shield only does 20% damage against this dagger";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.Value = 5000;
		this.m.MeleeDefense = 15;
		this.m.RangedDefense = 0;
		this.m.StaminaModifier = -3;
		this.m.Condition = 50;
		this.m.ConditionMax = 50;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.Sprite = "icon_legend_parrying_dagger_0" + this.m.Variant;
		this.m.SpriteDamaged = "icon_legend_parrying_dagger_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "icon_legend_parrying_dagger_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_parrying_dagger_0" + this.m.Variant + "_70x70.png";
	}

	function onEquip()
	{
		this.named_shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_en_garde"));
		this.addSkill(this.new("scripts/skills/actives/puncture_parry_dagger"));
		this.addSkill(this.new("scripts/skills/effects/legend_parrying_dagger_effect"));
	}



});

