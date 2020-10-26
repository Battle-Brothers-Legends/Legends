this.legend_noble_fencer <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.LegendFencer;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.LegendFencer.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_fencer_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendFencer);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
			this.m.Hitpoints = b.Hitpoints * 2;
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			}
	}

	function assignRandomEquipment()
	{
		local r;
		local banner = 3;

		if (!this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}


		r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/fencing_sword"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "padded_surcoat"],
			[1, "mail_shirt"],
			[1, "basic_mail_shirt"],
			[1, "gambeson"]
		]));

		if (this.Math.rand(1, 100) <= 33)
		{
			local helmet;

			if (banner <= 4)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "kettle_hat"],
					[1, "padded_kettle_hat"],
					[1, "kettle_hat_with_mail"],
					[1, "mail_coif"]
				]))
			}
			else if (banner <= 7)
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "flat_top_helmet"],
					[1, "padded_flat_top_helmet"],
					[1, "flat_top_with_mail"],
					[1, "mail_coif"]
				]))
			}
			else
			{
				this.m.Items.equip(this.Const.World.Common.pickHelmet([
					[1, "nasal_helmet"],
					[1, "padded_nasal_helmet"],
					[1, "nasal_helmet_with_mail"],
					[1, "mail_coif"]
				]))
			}

			this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head).setPlainVariant();
			this.m.Items.equip(helmet);
		}
		else
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[2, "aketon_cap"],
				[1, "full_aketon_cap"],
				[1, "headscarf"],
				[1, ""]
			]))
		}
	}

});

