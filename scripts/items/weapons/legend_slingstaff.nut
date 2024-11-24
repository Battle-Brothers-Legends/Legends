this.legend_slingstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_slingstaff";
		this.m.Name = "Northern Sling";
		this.m.Description = "A sling adapted by the nothern houses for warfare. It features a bigger pouch for heavier rocks, but trades off precision for damage and range. With rocks being everywhere it will never run out of ammunition.";
		this.m.IconLarge = "weapons/ranged/sling_01.png";
		this.m.Icon = "weapons/ranged/sling_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sling | this.Const.Items.WeaponType.Staff;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_sling_01";
		this.m.Value = 1000;
		this.m.RangeMin = 2;
		this.m.RangeMax = 9;
		this.m.RangeIdeal = 9;
		this.m.StaminaModifier = -12;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.75;
		//this.m.DirectDamageAdd = 0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_sling_heavy_stone_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_slingstaff_bash_skill"));
	}

});

