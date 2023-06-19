local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

if (!("Actor" in gt.Const.Tactical))
{
	gt.Const.Tactical.Actor <- {};
}

gt.Const.Tactical.Actor.OrcYoung <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 125,
	Bravery = 65,
	Stamina = 150,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.15
};
gt.Const.Tactical.Actor.OrcBerserker <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 250,
	Bravery = 90,
	Stamina = 200,
	MeleeSkill = 70,
	RangedSkill = 30,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 35,
	DamageTotalMult = 1.2
};
gt.Const.Tactical.Actor.OrcWarrior <- {
	XP = 400,
	ActionPoints = 8,
	Hitpoints = 200,
	Bravery = 75,
	Stamina = 300,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = -10,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30,
	DamageTotalMult = 1.25
};
gt.Const.Tactical.Actor.LegendOrcElite <- {
	XP = 800,
	ActionPoints = 8,
	Hitpoints = 300,
	Bravery = 90,
	Stamina = 400,
	MeleeSkill = 80,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 40,
	DamageTotalMult = 1.25
};
gt.Const.Tactical.Actor.LegendOrcBehemoth <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 800,
	Bravery = 55,
	Stamina = 500,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30,
	DamageTotalMult = 1.5
};
gt.Const.Tactical.Actor.OrcWarlord <- {
	XP = 600,
	ActionPoints = 8,
	Hitpoints = 300,
	Bravery = 90,
	Stamina = 450,
	MeleeSkill = 80,
	RangedSkill = 40,
	MeleeDefense = -10,
	RangedDefense = -10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30,
	DamageTotalMult = 1.35
};
gt.Const.Tactical.Actor.GoblinAmbusher <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 75,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GoblinFighter <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 65,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.GoblinWolfrider <- {
	XP = 150,
	ActionPoints = 13,
	Hitpoints = 60,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 75,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Wolf <- {
	XP = 100,
	ActionPoints = 12,
	Hitpoints = 40,
	Bravery = 40,
	Stamina = 150,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.GoblinLeader <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 95,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 80,
	MeleeDefense = 15,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GoblinShaman <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 95,
	Stamina = 90,
	MeleeSkill = 60,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.GreenskinCatapult <- {
	XP = 100,
	ActionPoints = 1,
	Hitpoints = 250,
	Bravery = 100,
	Stamina = 200,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -30,
	RangedDefense = -20,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30
};
gt.Const.Tactical.Actor.KoboldFighter <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.KoboldWolfrider <- {
	XP = 150,
	ActionPoints = 13,
	Hitpoints = 40,
	Bravery = 55,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};