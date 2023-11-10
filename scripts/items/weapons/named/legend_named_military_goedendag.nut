this.legend_named_military_goedendag <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); if (_i.m.SpecialEffect == 0) { _i.m.ExtraStaggerChance = ::Math.rand(_i.m.ExtraStaggerLowerBound, _i.m.ExtraStaggerHigherBound); }}
		],
		ExtraStaggerLowerBound = 15,
		ExtraStaggerHigherBound = 25,
		ExtraStaggerChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_military_goedendag";
		this.m.NameList = this.Const.Strings.MaceNames;
		this.m.Description = "An ornate military grade metal-reinforced club with a spike at the top. Can be used to thrust at the enemy, or pummel them into submission.";
		this.m.Variant = 1;
		this.updateVariant();
		this.m.WeaponType = this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAgainstShields = true;
		this.m.IsAoE = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 5400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 90.0;
		this.m.ConditionMax = 90.0;
		this.m.StaminaModifier = -18;
		this.m.RegularDamage = 80;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.4;
		this.m.ChanceToHitHead = 0;
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
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ExtraStaggerChance + "%[/color] chance to stagger a target on a successful attack"
			});
		}
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/legend_military_goedendag_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/legend_military_goedendag_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_legend_military_goedendag_named_0" + this.m.Variant;
	}


	function onEquip()
	{
		this.named_weapon.onEquip();
		local thrust = this.new("scripts/skills/actives/thrust");
		thrust.m.Icon = "skills/active_128.png";
		thrust.m.IconDisabled = "skills/active_128_sw.png";
		thrust.m.Overlay = "active_128";
		thrust.setFatigueCost(15);
		thrust.m.ActionPointCost = 6;
		this.addSkill(thrust);
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_131.png";
		skill.m.IconDisabled = "skills/active_131_sw.png";
		skill.m.Overlay = "active_131";
		this.addSkill(skill);
		local skill;
		skill = this.new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_132.png";
		skill.m.IconDisabled = "skills/active_132_sw.png";
		skill.m.Overlay = "active_132";
		skill.setFatigueCost(skill.getFatigueCostRaw() + 5);
		this.addSkill(skill);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.named_weapon.onDamageDealt( _target, _skill, _hitInfo );
		if (this.m.SpecialEffect == 0)
		{
			if (_target != null && _target.isAlive() && !_target.isDying() && ::Math.rand(0, 100) <= this.m.ExtraStaggerChance)
			{
				_target.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " has been staggered from: " + this.getName());
			}
		}
	}

	function onSerialize(_out) 
	{
		this.named_weapon.onSerialize(_out);
		_out.writeI8(this.m.ExtraStaggerChance);
	}
	function onDeserialize(_in) 
	{
		this.named_weapon.onDeserialize(_in);
		this.m.ExtraStaggerChance = ::Const.Serialization.Version >= 74 ? _in.readI18() : 0;
	}

});

