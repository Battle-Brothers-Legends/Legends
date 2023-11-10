this.named_orc_cleaver <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.WeaponFatalityChanceMult = ::Math.rand(40, 70) * 0.01; }
		]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2,3]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];

		this.updateVariant();
		this.m.ID = "weapon.named_orc_cleaver";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.UseRandomName = false;
		this.m.Description = "A sharp and crude shard of metal with a wrapped grip resembling a sword but a lot heavier. Not made for human hands.";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.25;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/orc_cleaver_named_0" + this.m.Variant + "_140x70.png";
		this.m.Icon = "weapons/melee/orc_cleaver_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_orc_weapon_04_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cleave");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/decapitate");
		this.addSkill(skill);
	}

});

