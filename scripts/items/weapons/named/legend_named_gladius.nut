this.legend_named_gladius <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_gladius";
		this.m.NameList = this.Const.Strings.SwordNames;
		this.m.Description = "A straight blade of ancient origin. The grip and pomel are ornate and most likely from a nobleman.";
		this.m.Categories = "Sword, One-Handed";
		this.m.IconLarge = "weapons/melee/legend_gladius_named_01.png";
		this.m.Icon = "weapons/melee/legend_gladius_named_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_gladius_named_01";
		this.m.Value = 3200;
		this.m.Condition = 54.0;
		this.m.ConditionMax = 54.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 43;
		this.m.RegularDamageMax = 48;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.2;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/slash"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}

	function onUpdateProperties( _properties )
	{
		this.named_weapon.onUpdateProperties(_properties);
	}

});

