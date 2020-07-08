this.legend_named_sickle <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_sickle";
		this.m.Name = "Sickle";
		this.m.NameList = this.Const.Strings.SwordNames;
		this.m.Description = "A ritualisticly engraved tool usually for gathering plants, made of the highest quality druidic metals";
		this.m.Categories = "Sword, One-Handed";
		this.m.IconLarge = "weapons/melee/legend_sickle_02.png";
		this.m.Icon = "weapons/melee/legend_sickle_02_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_sickle_01";
		this.m.Value = 4500;
		this.m.Condition = 75.0;
		this.m.ConditionMax = 75.0;
		this.m.StaminaModifier = -9;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
		this.randomizeValues();
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/slash"));
		this.addSkill(this.new("scripts/skills/actives/hook"));
		if (this.m.Container.getActor().getSkills().hasSkill("perk.legend_specialist_sickle_skill"))
		{
			this.addSkill(this.new("scripts/skills/actives/legend_harvest_bush"));
		}
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

