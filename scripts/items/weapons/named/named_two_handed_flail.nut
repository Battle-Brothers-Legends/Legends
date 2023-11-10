this.named_two_handed_flail <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); }
		]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2,3]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.named_two_handed_flail";
		this.m.NameList = this.Const.Strings.TwoHandedFlailNames;
		this.m.Description = "This impressive two-handed flail has little left in common with the farming tool it originates from. It appears to have been designed by an experienced fighter and built by an extraordinarily skilled craftsman.";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 2800;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -16;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
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
				text = "Dazes the target when striking the head."
			});
		}
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/flail_two_handed_02_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/flail_two_handed_02_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_flail_two_handed_02_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		skill.m.Icon = "skills/active_129.png";
		skill.m.IconDisabled = "skills/active_129_sw.png";
		skill.m.Overlay = "active_129";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
		skill.m.Icon = "skills/active_130.png";
		skill.m.IconDisabled = "skills/active_130_sw.png";
		skill.m.Overlay = "active_130";
		this.addSkill(skill);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.named_weapon.onDamageDealt( _target, _skill, _hitInfo );
		if (this.m.SpecialEffect == 0)
		{
			if (_target != null && _target.isAlive() && !_target.isDying() && !_target.getCurrentProperties().IsImmuneToDaze)
			{
				if (_hitInfo.BodyPart == this.Const.BodyPart.Head)
				{
					_target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_target) + " is dazed by: " + this.getName());
				}
			}
		}
	}

});

