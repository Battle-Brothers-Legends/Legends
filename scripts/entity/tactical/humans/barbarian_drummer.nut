this.barbarian_drummer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BarbarianDrummer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BarbarianDrummer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.SoundPitch = 0.95;
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
			this.m.Faces = this.Const.Faces.WildFemale;
		}
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/barbarian_drummer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];
		local tattoo_body = this.actor.getSprite("tattoo_body");
		local body = this.actor.getSprite("body");
		tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
		tattoo_body.Visible = true;
		local tattoo_head = this.actor.getSprite("tattoo_head");
		tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
		tattoo_head.Visible = true;
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BarbarianMarauder);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));

		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_fist"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		{
			this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		}
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/antler_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/claw_club"));
		}

		this.m.Items.equip(this.new("scripts/items/weapons/barbarians/drum_item"));

		local item
		if (this.World.LegendsMod.Configs().LegendArmorsEnabled())
		{
			local cloths = [
				[1, "cloth/legend_sackcloth"]
			];
			local armor = this.Const.World.Common.pickLegendArmor(cloths)

			if (armor != null)
			{
				local plates = [
					[0, ""],
					[1, "plate/legend_animal_hide_armor"],
					[0, "plate/legend_heavy_iron_armor"],
					[0, "plate/legend_hide_and_bone_armor"],
					[1, "plate/legend_reinforced_animal_hide_armor"],
					[0, "plate/legend_rugged_scale_armor"],
					[0, "plate/legend_scrap_metal_armor"],
					[1, "plate/legend_thick_furs_armor"],
					[0, "plate/legend_thick_plated_barbarian_armor"],
				]
				local plate = this.Const.World.Common.pickLegendArmor(plates)
				if (plate != null)
				{
					armor.setUpgrade(plate)
				}

				this.m.Items.equip(armor);
			}
		}
		else
		{
			r = this.Math.rand(1, 3);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/barbarians/animal_hide_armor"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/armor/barbarians/reinforced_animal_hide_armor"));
			}
		}

		local item = this.Const.World.Common.pickHelmet([
			[1, "barbarians/leather_headband"],
			[1, "barbarians/bear_headpiece"]
		])
		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

