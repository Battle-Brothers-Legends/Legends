this.zombie_betrayer <- this.inherit("scripts/entity/tactical/enemies/zombie_knight", {
	m = {},
	function create()
	{
		this.zombie_knight.create();
		this.m.Type = this.Const.EntityType.ZombieBetrayer;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.ZombieBetrayer.XP;
		this.m.Name = this.Const.Strings.EntityName[this.m.Type];
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_betrayer";
	}

	function onInit()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieBetrayer);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.DamageTotalMult = 1.25;
		b.DamageReceivedArmorMult = 0.75;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		if("Assets" in this.World && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			b.MeleeSkill += 5;
			this.m.Hitpoints = b.Hitpoints * 1.5;
		}
		b.FatigueDealtPerHitMult = 2.0;
		this.m.Skills.update();
	}

});

