this.cultist <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Cultist;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Cultist.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Cultist);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_flail"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_lacerate"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_ninetails_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_ninetails_damage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_cult_armor"));
		 if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r >= 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			local cloths = [
				[3, "armor/legend_armor_robes_cultist"],
				[1, "cloth/legend_robes"],
			];
			local armor = this.Const.World.Common.pickLegendArmor(cloths)

			this.m.Items.equip(armor);
		}
		else
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/cultist_leather_robe"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/monk_robe"));
			}
		}

		local item = this.Const.World.Common.pickHelmet([
			[1, "cultist_hood"],
			[1, "cultist_leather_hood"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

