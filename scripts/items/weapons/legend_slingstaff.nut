this.legend_slingstaff <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_slingstaff";
		this.m.Name = "Slingstaff";
		this.m.Description = "A sturdy sling staff, for catapulting rocks at armored foes";
		this.m.Categories = "Bow, Two-Handed";
		this.m.IconLarge = "weapons/ranged/slingstaff_01.png";
		this.m.Icon = "weapons/ranged/slingstaff_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_slingstaff_01";
		this.m.Value = 3000;
		this.m.RangeMin = 2;
		this.m.RangeMax = 8;
		this.m.RangeIdeal = 8;
		this.m.StaminaModifier = -12;
		this.m.Condition = 120.0;
		this.m.ConditionMax = 120.0;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.8;
	}

	function getAmmoID()
	{
		return "ammo.pebbles";
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local quick_shot = this.new("scripts/skills/actives/legend_quick_pebble");
		this.addSkill(quick_shot);
		local aimed_shot = this.new("scripts/skills/actives/legend_aimed_pebble");
		this.addSkill(aimed_shot);
	}

	function onSerialize( _out )
	{
		this.weapon.onSerialize(_out);
		_out.writeString(this.m.Name);
	}

	function onDeserialize( _in )
	{
		this.weapon.onDeserialize(_in);
		this.m.Name = _in.readString();
	}

});
