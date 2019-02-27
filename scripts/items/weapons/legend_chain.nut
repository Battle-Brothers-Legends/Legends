this.legend_chain <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_chain";
		this.m.Name = "Chain";
		this.m.Description = "A length of intertwined metal links. As an improvised weapon it's weak and rather unpredictable but useful to strike around shield cover and pull in enemies.";
		this.m.Categories = "Flail, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_chain_01.png";
		this.m.Icon = "weapons/melee/legend_chain_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_chain_01";
		this.m.Value = 50;
		this.m.ShieldDamage = 0;
		this.m.Condition = 22.0;
		this.m.ConditionMax = 322.0;
		this.m.StaminaModifier = -6;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 5;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.3;
		this.m.DirectDamageMult = 0.2;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local flail = this.new("scripts/skills/actives/flail_skill");
		flail.m.Icon = "skills/active_62.png";
		flail.m.IconDisabled = "skills/active_62_sw.png";
		flail.m.Overlay = "active_62";
		this.addSkill(flail);
		local lash = this.new("scripts/skills/actives/lash_skill");
		lash.m.Icon = "skills/active_94.png";
		lash.m.IconDisabled = "skills/active_94_sw.png";
		lash.m.Overlay = "active_94";
		this.addSkill(lash);
		local lash = this.new("scripts/skills/actives/hook");
		lash.m.Icon = "skills/active_31.png";
		lash.m.IconDisabled = "skills/active_31_sw.png";
		lash.m.Overlay = "active_31";
		this.addSkill(lash);
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});
