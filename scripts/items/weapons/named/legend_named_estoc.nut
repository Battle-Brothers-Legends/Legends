this.legend_named_estoc <- this.inherit("scripts/items/weapons/named/named_weapon", {
	m = {
		ItemSpecificFunctions = [
			function(_i) { _i.m.SpecialEffect = ::Math.rand(0, 0); if (_i.m.SpecialEffect == 0) { _i.m.BonusMeleeDefense = ::Math.rand(3, 7); }}
		],
		BonusMeleeDefense = 0
	},
	function create()
	{
		this.named_weapon.create();
		this.m.ID = "weapon.legend_named_estoc";
		this.m.NameList = this.Const.Strings.EstocNames;
		this.m.Description = "To craft a wellmade Estoc is difficult, requiring both a stiff blade for the thrust, and an elegant blade suitable for a swift and mobile fencer. Yet, the smith that crafted this did more than craft a wellmade one, he crafted a masterpiece.";
		this.m.IconLarge = "weapons/melee/legend_estoc_01_named_01.png";
		this.m.Icon = "weapons/melee/legend_estoc_01_named_01_70x70.png";
		this.m.WeaponType = this.Const.Items.WeaponType.Sword;
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Named | this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_legend_named_estoc_01";
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -14;
		this.m.Value = 4200;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.60;
		this.m.DirectDamageMult = 0.2;
		this.m.DirectDamageAdd = 0.3;
		this.m.ChanceToHitHead = 5;
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
				icon = "ui/icons/melee_defense.png",
				text = "Gives a [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.BonusMeleeDefense + "[/color] bonus to the holder\'s Melee Defense"
			});
		}
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/legend_great_slash"));
		this.addSkill(this.new("scripts/skills/actives/legend_greatlunge_skill"));
		if (this.m.SpecialEffect == 0)
		{
			local s = this.new("scripts/skills/effects/legend_estoc_effect");
			s.setBonus(this.m.BonusMeleeDefense);
			this.addSkill(s);
		}
	}

});

