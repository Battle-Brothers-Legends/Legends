this.legend_named_flail <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); }
		]
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_flail";
		this.m.NameList = this.Const.Strings.TwoHandedFlailNames;
		this.m.Description = "A metal weight attached with a short chain to a long pole, the War Flail is a brutal weapon. Deadly enough to fell most men with a good hit to the head, and useful to strike over or around shield cover.";
		this.m.IconLarge = "weapons/melee/legend_flail_ranged_02_named_01.png";
		this.m.Icon = "weapons/melee/legend_flail_ranged_02_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Cultist;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_flail_ranged_02_named_01";
		this.m.Value = 3000;
		this.m.ShieldDamage = 0;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.StaminaModifier = -10;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 1.0;
		this.m.ChanceToHitHead = 10;
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
				text = "Dazes the target when striking the head."
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_ranged_flail_skill"));
		this.addSkill(this.new("scripts/skills/actives/legend_ranged_lash_skill"));
		// local flail = this.new("scripts/skills/actives/legend_ranged_flail_skill");
		// flail.m.Icon = "skills/active_65.png";
		// flail.m.IconDisabled = "skills/active_65_sw.png";
		// flail.m.Overlay = "active_65";
		// this.addSkill(flail);
		// local lash = this.new("scripts/skills/actives/legend_ranged_lash_skill");
		// lash.m.Icon = "skills/active_92.png";
		// lash.m.IconDisabled = "skills/active_92_sw.png";
		// lash.m.Overlay = "active_92";
		// this.addSkill(lash);
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

