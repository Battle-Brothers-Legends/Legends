this.legend_named_shovel <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		StunChance = 10,
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
		this.m.ID = "weapon.legend_named_shovel";
		this.m.NameList = this.Const.Strings.CleaverNames;
		this.m.Description = "A ritualisticly engraved tool made for maiming men, not digging holes. A shovel\'s wide blade lends accuracy when aiming for the head, but almost anything else would be better.";
		this.m.IconLarge = "weapons/melee/legend_shovel_02.png";
		this.m.Icon = "weapons/melee/legend_shovel_02_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.IsDoubleGrippable = false;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_shovel_02";
		this.m.Value = 4500;
		this.m.Condition = 50.0;
		this.m.ConditionMax = 50.0;
		this.m.StaminaModifier = -12;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.80;
		this.m.DirectDamageMult = 0.2;
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
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.ExtraStaggerChance + "%[/color] chance to stagger a target on a successful attack"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local b = this.new("scripts/skills/actives/bash");
		b.m.Icon = "skills/shovel_bash.png";
		b.m.IconDisabled = "skills/shovel_bash_bw.png";
		this.addSkill(b);

		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_specialist_shovel_skill"))
		{
			this.addSkill(this.new("scripts/skills/actives/knock_out"));
		}
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

});

