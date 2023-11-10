this.named_two_handed_spiked_mace <- this.inherit("scripts/items/weapons/named/named_weapon", {
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
		this.m.Variant = 1;
		this.updateVariant();
		this.m.ID = "weapon.named_two_handed_spiked_mace";
		this.m.NameList = this.Const.Strings.TwoHandedMaceNames;
		this.m.PrefixList = this.Const.Strings.BarbarianPrefix;
		this.m.SuffixList = this.Const.Strings.BarbarianSuffix;
		this.m.UseRandomName = false;
		this.m.Description = "A heavy spiked mace crafted to resemble a human skull. Despite its crude appearance, this is a well balanced and deadly weapon.";
		this.m.WeaponType = this.Const.Items.WeaponType.Mace;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Value = 3000;
		this.m.ShieldDamage = 20;
		this.m.Condition = 72.0;
		this.m.ConditionMax = 72.0;
		this.m.StaminaModifier = -14;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.15;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = 0.1;
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
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/wildmen_06_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/wildmen_06_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_wildmen_06_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		local skill;
		skill = this.new("scripts/skills/actives/cudgel_skill");
		skill.m.Icon = "skills/active_178.png";
		skill.m.IconDisabled = "skills/active_178_sw.png";
		skill.m.Overlay = "active_178";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/strike_down_skill");
		skill.m.Icon = "skills/active_179.png";
		skill.m.IconDisabled = "skills/active_179_sw.png";
		skill.m.Overlay = "active_179";
		this.addSkill(skill);
		skill = this.new("scripts/skills/actives/split_shield");
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

