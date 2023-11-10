this.named_axe <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); }
		],
		DamageRegularLowerBound = 10,
		DamageRegularHigherBound = 20
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2,3,4,5,6]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.named_axe";
		this.m.NameList = this.Const.Strings.AxeNames;
		this.m.Description = "A well-crafted and rare variant of an axe explicitly designed for fighting armored opponents.";
		this.m.WeaponType = this.Const.Items.WeaponType.Axe;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 4000;
		this.m.ShieldDamage = 16;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.3;
		this.m.DirectDamageMult = 0.3;
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
		this.m.IconLarge = "weapons/melee/axe_03_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/axe_03_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_axe_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/chop"));
		local skillToAdd = this.new("scripts/skills/actives/split_shield");
		skillToAdd.setApplyAxeMastery(true);
		this.addSkill(skillToAdd);
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

