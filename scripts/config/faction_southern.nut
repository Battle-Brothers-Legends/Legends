local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

if (!("Actor" in gt.Const.Tactical))
{
	gt.Const.Tactical.Actor <- {};
}

gt.Const.Tactical.Actor.Conscript <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Gunner <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 75,
	MeleeDefense = 5,
	RangedDefense = 10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Officer <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 85,
	RangedSkill = 60,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Engineer <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = 0,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Assassin <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 85,
	Stamina = 125,
	MeleeSkill = 80,
	RangedSkill = 70,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Slave <- {
	XP = 50,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 45,
	RangedSkill = 35,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Gladiator <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 90,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Mortar <- {
	XP = 0,
	ActionPoints = 6,
	Hitpoints = 9999,
	Bravery = 999,
	Stamina = 999,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -50,
	RangedDefense = -50,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		9999,
		9999
	],
	FatigueRecoveryRate = 0
};
gt.Const.Tactical.Actor.NomadCutthroat <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 45,
	MeleeDefense = 5,
	RangedDefense = 5,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.NomadSlinger <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 60,
	MeleeDefense = 0,
	RangedDefense = 10,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.NomadArcher <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 55,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 65,
	MeleeDefense = 5,
	RangedDefense = 15,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.NomadOutlaw <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 60,
	Stamina = 125,
	MeleeSkill = 65,
	RangedSkill = 55,
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.NomadLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 75,
	Stamina = 130,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 20,
	RangedDefense = 15,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.DesertDevil <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 90,
	Stamina = 130,
	MeleeSkill = 90,
	RangedSkill = 50,
	MeleeDefense = 50,
	RangedDefense = 30,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.Executioner <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 170,
	Bravery = 90,
	Stamina = 160,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 30,
	RangedDefense = 20,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
gt.Const.Tactical.Actor.DesertStalker <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 85,
	MeleeDefense = 15,
	RangedDefense = 25,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

