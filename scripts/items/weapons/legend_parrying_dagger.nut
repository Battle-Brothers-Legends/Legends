this.legend_parrying_dagger <- this.inherit("scripts/items/shields/shield", {
	m = {
		Variants = []
	},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.legend_parrying_dagger";
		this.m.Name = "Parrying dagger";
		this.m.Description = "An offhand dagger for actively parrying an opponent.\n\n When parried or if an opponent misses you, their defences will be lowered.\n\n The \'Split Shield\' skill only does 20% damage against this dagger";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variants = [1]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.m.ItemType = this.Const.Items.ItemType.Defensive | this.Const.Items.ItemType.Weapon;
		this.updateVariant();
		this.m.Value = 500;
		this.m.MeleeDefense = 5;
		this.m.RangedDefense = 0;
		this.m.StaminaModifier = -2;
		this.m.Condition = 36;
		this.m.ConditionMax = 36;
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
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_en_garde"));
		this.addSkill(this.new("scripts/skills/actives/puncture_parry_dagger"));
		this.addSkill(this.new("scripts/skills/effects/legend_parrying_dagger_effect"));
	}

	function getAmmoMax()
	{
		return 0;
	}



});

