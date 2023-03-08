this.legend_skullbreaker <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.legend_skullbreaker";
		this.m.Name = "Skull Breaker";
		this.m.Description = "A massive crude hammer with a head fashioned from a chunk of solid iron. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/legend_skullbreaker_01.png";
		this.m.Icon = "weapons/melee/legend_skullbreaker_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Hammer;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_skullbreaker_01";
		this.m.Value = 1600;
		this.m.ShieldDamage = 32;
		this.m.Condition = 68.0;
		this.m.ConditionMax = 68.0;
		this.m.StaminaModifier = -32;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 2.1;
		this.m.DirectDamageMult = 0.5;
		this.m.ChanceToHitHead = 0;
		this.m.FatigueOnSkillUse = 5;
	}

	// function getTooltip()
	// {
	// 	local ret = this.weapon.getTooltip();
	// 	ret.push({
	// 		id = 18,
	// 		type = "text",
	// 		icon = "ui/icons/fatigue.png",
	// 		text = "Builds up additional [color=" + this.Const.UI.Color.NegativeValue + "]5[/color] Fatigue with every skill use"
	// 	});
	// 	return ret;
	// }

	function onEquip()
	{
		this.weapon.onEquip();
		local skillToAdd = this.new("scripts/skills/actives/smite_skill");
		this.addSkill(skillToAdd);

		skillToAdd = this.new("scripts/skills/actives/shatter_skill");
		this.addSkill(skillToAdd);
		
		skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setFatigueCost(skillToAdd.getFatigueCostRaw() + 10); // 10 because 2h weapons should get +5 on split shield (see 2h mace), and then +5 because of being orc weapon.
		this.addSkill(skillToAdd);
	}

});
