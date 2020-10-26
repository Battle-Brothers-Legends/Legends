local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

if (!("Actor" in gt.Const.Tactical))
{
	gt.Const.Tactical.Actor <- {};
}
gt.Const.Tactical.Actor.LegendCat <- {
	XP = 50,
	ActionPoints = 12,
	Hitpoints = 30,
	Bravery = 40,
	Stamina = 130,
	MeleeSkill = 50,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 25,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Peasant <- {
	XP = 50,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 35,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Militia <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 35,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaRanged <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 50,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaVeteran <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 50,
	Stamina = 110,
	MeleeSkill = 55,
	RangedSkill = 40,
	MeleeDefense = 5,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.MilitiaCaptain <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 70,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.CaravanHand <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 40,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.CaravanGuard <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 60,
	Stamina = 130,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Donkey <- {
	XP = 50,
	ActionPoints = 1,
	Hitpoints = 180,
	Bravery = 100,
	Stamina = 200,
	MeleeSkill = 1,
	RangedSkill = 1,
	MeleeDefense = -30,
	RangedDefense = -10,
	Initiative = 50,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 30
};
gt.Const.Tactical.Actor.BountyHunter <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 65,
	Stamina = 125,
	MeleeSkill = 75,
	RangedSkill = 60,
	MeleeDefense = 15,
	RangedDefense = 8,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
gt.Const.Tactical.Actor.BountyHunterRanged <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 65,
	Stamina = 115,
	MeleeSkill = 50,
	RangedSkill = 70,
	MeleeDefense = 10,
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
gt.Const.Tactical.Actor.Mercenary <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 70,
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
gt.Const.Tactical.Actor.MercenaryRanged <- {
	XP = 300,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 65,
	RangedSkill = 75,
	MeleeDefense = 10,
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
gt.Const.Tactical.Actor.Swordmaster <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 90,
	Stamina = 115,
	MeleeSkill = 100,
	RangedSkill = 50,
	MeleeDefense = 80,
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
gt.Const.Tactical.Actor.HedgeKnight <- {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 150,
	Bravery = 90,
	Stamina = 160,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
gt.Const.Tactical.Actor.MasterArcher <- {
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
gt.Const.Tactical.Actor.Councilman <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 40,
	Stamina = 120,
	MeleeSkill = 50,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Envoy <- {
	XP = 0,
	ActionPoints = 9,
	Hitpoints = 50,
	Bravery = 40,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 30,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
gt.Const.Tactical.Actor.Cultist <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 80,
	Stamina = 110,
	MeleeSkill = 60,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

gt.Const.Tactical.Actor.LegendPeasantButcher <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 10,
	MeleeDefense = 0,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

gt.Const.Tactical.Actor.LegendPeasantMonk <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 60,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 10,
	MeleeDefense = 30,
	RangedDefense = 30,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

gt.Const.Tactical.Actor.LegendPeasantBlacksmith <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 80,
	Bravery = 60,
	Stamina = 150,
	MeleeSkill = 80,
	RangedSkill = 10,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.LegendPeasantFarmhand <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 60,
	RangedSkill = 30,
	MeleeDefense = 20,
	RangedDefense = 0,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.LegendPeasantMinstrel <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 70,
	Stamina = 100,
	MeleeSkill = 40,
	RangedSkill = 40,
	MeleeDefense = 0,
	RangedDefense = 20,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.LegendPeasantPoacher <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 70,
	Bravery = 35,
	Stamina = 100,
	MeleeSkill = 30,
	RangedSkill = 60,
	MeleeDefense = 0,
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

gt.Const.Tactical.Actor.LegendPeasantWoodsman <- {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 50,
	Stamina = 120,
	MeleeSkill = 65,
	RangedSkill = 20,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.LegendPeasantMiner <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 75,
	Bravery = 50,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 20,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 90,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

gt.Const.Tactical.Actor.LegendPeasantSquire <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 130,
	Bravery = 75,
	Stamina = 120,
	MeleeSkill = 70,
	RangedSkill = 20,
	MeleeDefense = 30,
	RangedDefense = 20,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

gt.Const.Tactical.Actor.LegendPeasantWitchHunter <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 90,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 80,
	MeleeDefense = 20,
	RangedDefense = 30,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};