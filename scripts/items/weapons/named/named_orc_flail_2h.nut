this.named_orc_flail_2h <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); }
		]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.named_orc_flail_2h";
		this.m.Name = "Brutal Chain";
		this.m.Description = "A massive iron chain with a huge hunk of stone at the end. Too heavy to be used effectively by the average human.";
		this.m.IconLarge = "weapons/melee/named_orc_flail_two_handed.png";
		this.m.Icon = "weapons/melee/named_orc_flail_two_handed_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsAoE = true;
		this.m.EquipSound = this.Const.Sound.ArmorLeatherImpact;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_named_orc_weapon_05";
		this.m.Value = 2100;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.StaminaModifier = -30;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 100;
		this.m.ArmorDamageMult = 1.25;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 15;
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
				text = "Dazes the target when striking the head."
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/pound");
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/thresh");
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

