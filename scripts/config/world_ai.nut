local gt = this.getroottable();
gt.Const.World.AI <- {
	VerboseMode = false,
	BenchmarkMode = false,
	PathfindingDebugMode = false,
	VisionDebugMode = false,
	VisualizeNameOfLocations = true,
	VisualizeNameOfUnits = true,
	VisualizeOrders = false,
	VisualizeStrength = true,
	AllottedTimePerEvaluationRun = 0.004,
	RefreshTime = 1.0,
	Controller = {
		OpponentPartyTTL = 14000,
		OpponentLocationTTL = 5 * 1000 * this.World.getTime().SecondsPerDay,
		GuessOpponentNewPositionMaxDistance = 100.0,
		GuessAllyNewPositionMaxDistance = 300.0,
		LuckyGuessPositionMaxDistance = 150.0
	},
	Behavior = {
		ID = {
			Idle = 0,
			Attack = 1,
			Flee = 2,
			Move = 3,
			Guard = 4,
			Wait = 5,
			Ambush = 6,
			Despawn = 7,
			Roam = 8,
			Swim = 9,
			Unload = 10,
			Intercept = 11,
			Raid = 12,
			Destroy = 13,
			Conquer = 14,
			Convert = 15,
			Mercenary = 16,
			AttackZone = 17,
			Patrol = 18,
			Occupy = 19,
			Sleep = 20,
			Dock = 21,
			COUNT = 22
		},
		Name = [
			"Idle",
			"Attack",
			"Flee",
			"Move",
			"Guard",
			"Wait",
			"Ambush",
			"Despawn",
			"Roam",
			"Swim",
			"Unload",
			"Intercept",
			"Raid",
			"Destroy",
			"Conquer",
			"Convert",
			"Mercenary",
			"AttackZone",
			"Patrol",
<<<<<<< HEAD
			"Sleep",
			"Dock"
=======
			"Occupy",
			"Sleep"
>>>>>>> master
		],
		Score = {
			Zero = 0,
			Idle = 10,
			Order = 100,
			Attack = 500,
			Flee = 9000
		},
		EnemyNearDist = 500.0,
		AmbushMinDistToSettlements = 6,
		AmbushMaxSpots = 20,
		AmbushWaitTime = this.World.getTime().SecondsPerDay * 3.0,
		RoamMaxAttempts = 8,
		AttackDirectMovementDistance = 250.0,
		AttackDistanceMult = 0.5,
		AttackMaxRange = 700.0,
		AttackVisibleTargetMult = 1.5,
		AttackChaseMaxTime = 30.0,
		FleeMinTime = 4.0,
		FleeMinScore = 0.6,
		FleeMaxAttempts = 4,
		FleeMaxAttemptsPerDirection = 2,
		FleeFromVisibleTargetMult = 1.25,
		FleeMaxTime = 50.0
	}
};

