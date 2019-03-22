this.legend_limb_lopper <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_limb_lopper";
		this.m.Name = "Limb Lopper";
		this.m.Description = "A colossal cleaving weapon made of several overlapping crude blades wedged into a tree limb. Too heavy to be used effectively by the average human.";
		this.m.Categories = "Cleaver, Two-Handed";
		this.m.IconLarge = "weapons/melee/legend_limb_lopper_01.png";
		this.m.Icon = "weapons/melee/legend_limb_lopper_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_limb_lopper_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 32.0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -26;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.25;
	}

	function getTooltip()
	{
		local ret = this.weapon.getTooltip();
		ret.push({
			id = 18,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "Builds up additional [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Fatigue with every skill use"
		});
		return ret;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cleave");
		skill.setFatigueCost(this.Math.round(skill.getFatigueCostRaw() + 5));
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/decapitate");
		skill.setFatigueCost(this.Math.round(skill.getFatigueCostRaw() + 5));
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		skill.setFatigueCost(this.Math.round(skill.getFatigueCostRaw() + 5));
		this.addSkill(skill);
	}

});
