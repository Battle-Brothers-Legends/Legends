this.named_fencing_sword <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); if (_i.m.SpecialEffect == 0) { _i.m.BonusInitiativePct = ::Math.rand(5, 10); }}
		],
		BonusInitiativePct = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.Variants = [1,2]
		this.m.Variant = this.m.Variants[this.Math.rand(0, this.m.Variants.len() -1)];
		this.updateVariant();
		this.m.ID = "weapon.named_fencing_sword";
		this.m.NameList = this.Const.Strings.FencingSwordNames;
		this.m.Description = "Crafting a proper fencing sword, both delicate and flexible, is no less difficult than wielding it. The smith that brought this particular weapon into existence must have been among the best in his trade.";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -4;
		this.m.Value = 4000;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.2;
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
				icon = "ui/icons/initiative.png",
				text = "Gives a [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.BonusInitiativePct + "%[/color] bonus to the holder\'s initiative"
			});
		}
		return result;
	}

	function updateVariant()
	{
		this.m.IconLarge = "weapons/melee/sword_fencing_01_named_0" + this.m.Variant + ".png";
		this.m.Icon = "weapons/melee/sword_fencing_01_named_0" + this.m.Variant + "_70x70.png";
		this.m.ArmamentIcon = "icon_fencing_sword_01_named_0" + this.m.Variant;
	}

	function onEquip()
	{
		this.named_weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/slash"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
		if (this.m.SpecialEffect == 0)
		{
			local s = this.new("scripts/skills/effects/legend_rapier_effect");
			s.setBonus(this.m.BonusInitiativePct);
			this.addSkill(s);
		}
	}

});

