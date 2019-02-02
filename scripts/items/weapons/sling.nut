this.wonky_bow <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.sling";
		this.m.Name = "Sling";
		this.m.Description = "An improvised weapon made from a frayed length of cord with a pouch in the center. It takes little skill to throw stones, this just helps you throw them further.";
		this.m.Categories = "Bow, One-Handed";
		this.m.IconLarge = "weapons/ranged/sling_01.png";
		this.m.Icon = "weapons/ranged/sling_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_event_bow_02";
		this.m.Value = 100;
		this.m.RangeMin = 3;
		this.m.RangeMax = 5;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.RegularDamage = 10;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.4;
		this.m.AdditionalAccuracy = -10;
	}

	function getAmmoID()
	{
		return "ammo.arrows";
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local quick_shot = this.new("scripts/skills/actives/quick_shot");
		this.addSkill(quick_shot);
		local aimed_shot = this.new("scripts/skills/actives/aimed_shot");
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
