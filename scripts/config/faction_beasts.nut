local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

if (!("Actor" in gt.Const.Tactical))
{
	gt.Const.Tactical.Actor <- {};
}

gt.Const.Tactical.Actor.Ghoul <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 50,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 15,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Direwolf <- {
	XP = 200,
	ActionPoints = 12,
	Hitpoints = 130,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};
gt.Const.Tactical.Actor.FrenziedDirewolf <- {
	XP = 250,
	ActionPoints = 12,
	Hitpoints = 150,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		30,
		30
	]
};
gt.Const.Tactical.Actor.Spider <- {
	XP = 100,
	ActionPoints = 11,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 130,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
gt.Const.Tactical.Actor.SpiderEggs <- {
	XP = 0,
	ActionPoints = 0,
	Hitpoints = 20,
	Bravery = 0,
	Stamina = 0,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = -50,
	RangedDefense = 0,
	Initiative = 0,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Lindwurm <- {
	XP = 750,
	ActionPoints = 7,
	Hitpoints = 1100,
	Bravery = 180,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = -10,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		400,
		200
	]
};
gt.Const.Tactical.Actor.Unhold <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.UnholdFrost <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 600,
	Bravery = 150,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 85,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		90,
		90
	]
};
gt.Const.Tactical.Actor.UnholdBog <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 500,
	Bravery = 130,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Alp <- {
	XP = 350,
	ActionPoints = 6,
	Hitpoints = 75,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 999,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 7,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.AlpShadow <- {
	XP = 0,
	ActionPoints = 9,
	Hitpoints = 5,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 100,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	FatigueRecoveryRate = 15,
	Vision = 3,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.Hexe <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 160,
	Stamina = 80,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 8,
	Armor = [
		25,
		0
	]
};
gt.Const.Tactical.Actor.Schrat <- {
	XP = 500,
	ActionPoints = 7,
	Hitpoints = 600,
	Bravery = 200,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.SchratSmall <- {
	XP = 50,
	ActionPoints = 7,
	Hitpoints = 75,
	Bravery = 150,
	Stamina = 400,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.TricksterGod <- {
	XP = 1500,
	ActionPoints = 9,
	Hitpoints = 2000,
	Bravery = 999,
	Stamina = 400,
	MeleeSkill = 90,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		100,
		100
	]
};
gt.Const.Tactical.Actor.Kraken <- {
	XP = 2500,
	ActionPoints = 9,
	Hitpoints = 4400,
	Bravery = 999,
	Stamina = 999,
	MeleeSkill = 999,
	RangedSkill = 0,
	MeleeDefense = -15,
	RangedDefense = -15,
	Initiative = -300,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		1600,
		1600
	]
};
gt.Const.Tactical.Actor.KrakenTentacle <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 300,
	Bravery = 999,
	Stamina = 999,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};

