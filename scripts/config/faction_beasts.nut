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
gt.Const.Tactical.Actor.Hyena <- {
	XP = 200,
	ActionPoints = 14,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 180,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};
gt.Const.Tactical.Actor.FrenziedHyena <- {
	XP = 250,
	ActionPoints = 14,
	Hitpoints = 140,
	Bravery = 70,
	Stamina = 180,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 130,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
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
	XP = 800,
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
	XP = 300,
	ActionPoints = 10,
	Hitpoints = 100,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 7,
	Armor = [
		0,
		0
	],
	TeleportTargets = [],
	TeleportFrame = 0
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
	XP = 600,
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
	MeleeDefense = 15,
	RangedDefense = 15,
	Initiative = 95,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		130,
		130
	]
};
gt.Const.Tactical.Actor.Kraken <- {
	XP = 2500,
	ActionPoints = 9,
	Hitpoints = 4400,
	Bravery = 500,
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
	Bravery = 60,
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
gt.Const.Tactical.Actor.Serpent <- {
	XP = 175,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 100,
	Stamina = 110,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 25,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		40,
		40
	]
};
gt.Const.Tactical.Actor.SandGolem <- {
	XP = 150,
	ActionPoints = 8,
	Hitpoints = 110,
	Bravery = 999,
	Stamina = 400,
	MeleeSkill = 65,
	RangedSkill = 60,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		110,
		110
	]
};
gt.Const.Tactical.Actor.LegendSkinGhoul <- {
	XP = 250,
	ActionPoints = 12,
	Hitpoints = 240,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 15,
	Initiative = 135,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.LegendWhiteDirewolf <- {
	XP = 900,
	ActionPoints = 16,
	Hitpoints = 400,
	Bravery = 150,
	Stamina = 240,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 175,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		200,
		200
	]
};
gt.Const.Tactical.Actor.LegendWhiteWarwolf <- {
	XP = 600,
	ActionPoints = 12,
	Hitpoints = 200,
	Bravery = 100,
	Stamina = 200,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		200,
		200
	]
};
gt.Const.Tactical.Actor.LegendRedbackSpider <- {
	XP = 500,
	ActionPoints = 16,
	Hitpoints = 250,
	Bravery = 120,
	Stamina = 180,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 40,
	RangedDefense = 40,
	Initiative = 175,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		240,
		240
	]
};
gt.Const.Tactical.Actor.LegendRockUnhold <- {
	XP = 800,
	ActionPoints = 12,
	Hitpoints = 1000,
	Bravery = 250,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 65,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		1000,
		1000
	]
};
gt.Const.Tactical.Actor.LegendDemonAlp <- {
	XP = 700,
	ActionPoints = 9,
	Hitpoints = 100,
	Bravery = 150,
	Stamina = 150,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 999,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 10,
	Armor = [
		0,
		0
	]
};
gt.Const.Tactical.Actor.LegendStollwurm <- {
	XP = 1500,
	ActionPoints = 15,
	Hitpoints = 2000,
	Bravery = 180,
	Stamina = 400,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 10,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		800,
		400
	]
};
gt.Const.Tactical.Actor.LegendGreenwoodSchrat <- {
	XP = 1000,
	ActionPoints = 10,
	Hitpoints = 900,
	Bravery = 200,
	Stamina = 400,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 80,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};

gt.Const.Tactical.Actor.LegendGreenwoodSchratSmall <- {
	XP = 100,
	ActionPoints = 7,
	Hitpoints = 150,
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
gt.Const.Tactical.Actor.LegendHexeLeader <- {
	XP = 900,
	ActionPoints = 16,
	Hitpoints = 320,
	Bravery = 200,
	Stamina = 150,
	MeleeSkill = 0,
	RangedSkill = 75,
	MeleeDefense = 30,
	RangedDefense = 30,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Vision = 10,
	Armor = [
		100,
		0
	]
};
gt.Const.Tactical.Actor.LegendBear <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 400,
	Bravery = 80,
	Stamina = 300,
	MeleeSkill = 70,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 75,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 30,
	Armor = [
		50,
		50
	]
};
gt.Const.Tactical.Actor.LegendHorse <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 200,
	Bravery = 40,
	Stamina = 150,
	MeleeSkill = 45,
	RangedSkill = 0,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		0,
		0
	]
};


