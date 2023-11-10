this.named_flail <- this.inherit("scripts/items/weapons/named/named_weapon", {
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
		this.m.ID = "weapon.named_flail";
		this.m.NameList = this.Const.Strings.FlailNames;
		this.m.Description = "A separate striking head attached to a handle by a chain. A rather unpredictable weapon, but useful to strike over or around shield cover. This particular flail seems even more terrifying due to its unique characteristics.";
		this.m.WeaponType = this.Const.Items.WeaponType.Flail;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Cultist;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3400;
		this.m.ShieldDamage = 0;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -8;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
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
		this.m.IconLarge = "weapons/melee/flail_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/flail_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_named_flail_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/flail_skill"));
		this.addSkill(this.new("scripts/skills/actives/lash_skill"));
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

