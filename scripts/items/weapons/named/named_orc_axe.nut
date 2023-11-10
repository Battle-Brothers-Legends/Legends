this.named_orc_axe <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); }
		],
		DamageRegularLowerBound = 15,
		DamageRegularHigherBound = 25
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2,3]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];

		this.updateVariant();
		this.m.ID = "weapon.named_orc_axe";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.UseRandomName = false;
		this.m.Description = "A heavy piece of metal with a sharp head. Not made for human hands.";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2400;
		this.m.ShieldDamage = 16;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -22;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.3;
		this.m.FatigueOnSkillUse = 5;
		this.randomizeValues();
	}

	function getTooltip()
	{
		local result = this.named_weapon.getTooltip();
		if (this.m.SpecialEffect == 0)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "Deals an additional [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.DamageRegularLowerBound + " - " + this.m.DamageRegularHigherBound + " %[/color] damage when striking the targets head"
			});
		}
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/orc_axe_named_0" + this.m.Variant + "_140x70.png";
		this.m.Icon = "weapons/melee/orc_axe_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_orc_weapon_02_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/chop");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
		skill.setApplyAxeMastery(true);
		this.addSkill(skill);
		//this.addSkill(this.new("scripts/skills/actives/legend_harvest_tree"));
	}

	function onBeforeTargetHit( _skill, _target, _hitInfo )
	{
		this.named_weapon.onBeforeTargetHit(_skill, _target, _hitInfo);
		if (_hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			local bonus = ::Math.rand(this.m.DamageRegularLowerBound, this.m.DamageRegularHigherBound);
			_hitInfo.DamageRegular *= 1.0 + (bonus * 0.01);
			// this.Tactical.EventLog.log("The strike received an additional damage multiplier of: " + bonus);
		}
	}

});

