this.drum_item <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.barbarian_drum";
		this.m.Name = "Barbarian Drum";
		this.m.Description = "";
		this.m.WeaponType = this.Const.Items.WeaponType.Musical | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Misc;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.IsDoubleGrippable = false;
		this.m.IsDroppedAsLoot = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_wildmen_10";
		this.m.RangeMin = 1;
		this.m.RangeMax = 1;
		this.m.RangeIdeal = 1;
		this.m.Value = 200;
		this.m.Condition = 100;
		this.m.ConditionMax = 100;
		this.m.StaminaModifier = 0;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 20;
		this.m.ArmorDamageMult = 0.0;
		this.m.DirectDamageMult = 0.0;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/drum_bash"));
		local s = this.new("scripts/skills/actives/knock_out");
		this.addSkill(s);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}


});

