this.legend_named_butchers_cleaver <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.WeaponFatalityChanceMult = ::Math.rand(40, 70) * 0.01; }
		]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_butchers_cleaver";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.Name = "Butcher\'s Bone Cleaver";
		this.m.Description = "A superbly crafted tool with a thick rectangular blade used for hacking through meat and bone.";
		this.m.IconLarge = "weapons/melee/cleaver_02_named.png";
		this.m.Icon = "weapons/melee/cleaver_02_named_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_cleaver_02_named";
		this.m.ShieldDamage = 0;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -6;
		this.m.Value = 1100;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.25;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local cleave = this.new("scripts/skills/actives/cleave");
		cleave.m.Icon = "skills/active_68.png";
		cleave.m.IconDisabled = "skills/active_68_sw.png";
		cleave.m.Overlay = "active_68";
		this.addSkill(cleave);
		local decapitate = this.new("scripts/skills/actives/decapitate");
		this.addSkill(decapitate);
	}

});

