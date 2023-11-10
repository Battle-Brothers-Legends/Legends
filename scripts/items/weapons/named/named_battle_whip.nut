this.named_battle_whip <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 1); if (_i.m.SpecialEffect == 0) { _i.m.ExtraBleedChance = ::Math.rand(_i.m.ExtraBleedLowerBound, _i.m.ExtraBleedHigherBound); }}
		],
		ExtraBleedLowerBound = 30,
		ExtraBleedHigherBound = 55,
		ExtraBleedChance = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_battle_whip";
		this.m.NameList = this.Const.Strings.WhipNames;
		this.m.Description = "A whip is quite the peculiar weapon, but this piece has been crafted by a true master. It is more durable and balanced than any other you\'ve seen.";
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Whip;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.RangeMin = 1;
		this.m.RangeMax = 3;
		this.m.RangeIdeal = 3;
		this.m.Value = 2200;
		this.m.Condition = 40;
		this.m.ConditionMax = 40;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 30;
		this.m.ArmorDamageMult = 0.25;
		this.m.DirectDamageMult = 0.1;
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
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ExtraBleedChance + "%[/color] chance to apply a bleed stack when striking a target"
			});
		}
		else if (this.m.SpecialEffect == 1)
		{
			result.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Applies Feint when striking a target"
			});
		}
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/whip_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/whip_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_whip_01_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill = this.new("scripts/skills/actives/whip_skill");
		skill.m.Icon = "skills/active_171.png";
		skill.m.IconDisabled = "skills/active_171_sw.png";
		skill.m.Overlay = "active_171";
		this.addSkill(skill);
		local skill = this.new("scripts/skills/actives/disarm_skill");
		this.addSkill(skill);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.named_weapon.onDamageDealt( _target, _skill, _hitInfo );
		if (this.m.SpecialEffect == 0)
		{
			if (_target != null && _target.isAlive() && !_target.isDying() && !_target.getCurrentProperties().IsImmuneToBleeding && ::Math.rand(0, 100) <= this.m.ExtraBleedChance)
			{
				_target.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " obtained a stack of bleeding from: " + this.getName());
			}
		}
		else if (this.m.SpecialEffect == 1)
		{
			if (_target != null && _target.isAlive() && !_target.isDying() && !_target.getSkills().hasSkill("effects.legend_parried"))
			{
				_target.getSkills().add(this.new("scripts/skills/effects/legend_parried_effect"));
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " was feinted by " + this.getName() + " leaving them exposed!");
			}
		}
	}

	function onSerialize(_out) 
	{
		this.named_weapon.onSerialize(_out);
		_out.writeI8(this.m.ExtraBleedChance);
	}
	function onDeserialize(_in) 
	{
		this.named_weapon.onDeserialize(_in);
		this.m.ExtraBleedChance = ::Const.Serialization.Version >= 74 ? _in.readI18() : 0;
	}

});

