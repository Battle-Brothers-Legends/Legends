this.legend_redback_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_redback_dagger";
		this.m.Name = "Redback Dagger";
		this.m.Description = "A dagger made from the fang and poison gland of a redback spider, it is can inject redback poison into a target";
		this.m.Categories = "Dagger, One-Handed";
		this.m.IconLarge = "weapons/melee/legend_redback_dagger.png";
		this.m.Icon = "weapons/melee/legend_redback_dagger_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_redback_dagger";
		this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.Value = 3800;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Apples redback poison to target"
		});
		return result;
	}


	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/legend_redback_puncture"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

