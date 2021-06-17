this.bandit_marksman <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditMarksman;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditMarksman.XP;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		if (this.Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);

		if (!this.m.IsLow)
		{
			b.IsSpecializedInBows = true;
			b.IsSpecializedInCrossbows = true;
			b.IsSpecializedInSlings = true;
			b.Vision = 8;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.RangedDefense += 5;
		}

		this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		}

		if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_ballistics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_close_combat_archer"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged())
		{
			this.updateAchievement("TasteYourOwnMedicine", 1, 1);
		}

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
	}

});

