this.legend_drum <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		StunChance = 30
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_drum";
		this.m.Name = "Drum";
		this.m.Description = "A musical instrument, can produce inspiring rythms, if you have the skill. The drum sticks make short staves in a pinch.";
		this.m.Categories = "Musical Instrument, Staff, Two-Handed";
		this.m.IconLarge = "weapons/melee/drum_01.png";
		this.m.Icon = "weapons/melee/drum_01_70x70.png";
		this.m.BreakingSound = "sounds/combat/lute_break_01.wav";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_drum";
		this.m.Value = 300;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.2;
		this.m.DirectDamageMult = 0.5;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_staff_bash"));
		local s = this.new("scripts/skills/actives/legend_staff_knock_out");
		s.m.IsFromLute = true;
		this.addSkill(s);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

