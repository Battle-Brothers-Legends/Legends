local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.BanditRoamers <-
{
	Name = "BanditRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	//MinR = 56,
	MaxR = 220,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					// MaxR = 0.25 * 420,
					MaxR = 100,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					MinR = 200,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 400,
					Cost = 20
				},
				{
					MinR = 800,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 18,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					// MaxR = 0.20 * 420,
					MaxR = 70,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 400,
					Cost = 18
				}
			]
		},
		{
			Weight = 15,
			MinR = 0.50 * 385,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
	]
}


gt.Const.World.Spawn.BanditScouts <-
{
	Name = "BanditScouts",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	//MinR = 61,
	MaxR = 340,
	Fixed = [],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 120,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					MinR = 200,
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 340,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 85,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 340,
					Cost = 15
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 10,
			MinR = 340,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
	]
}

gt.Const.World.Spawn.BanditRaiders <-
{
	Name = "BanditRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	//MinR = 63,
	MaxR = 600
	Troops =
	[
		{
			Weight = 54,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					// MaxR = 0.15 * 400,
					MaxR = 60,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					MinR = 200,
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 110,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 11
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			MinR = 250,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
					Roll = true
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditWarlord,
					Cost = 80,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 14,
			MinR = 200,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},
	]
}

gt.Const.World.Spawn.BanditDefenders <-
{
	Name = "BanditDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [],
	//MinR = 45,
	MaxR = 600
	Troops =
	[
		{
			Weight = 59,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 85,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 125,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					MinR = 400,
					Cost = 18
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			MinR = 500,
			Types =
			[
				{

					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditWarlord,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 12,
			MinR = 150,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 20
				}
			]
		},

		{
			Weight = 1,
			MinR = 600,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 80,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 600,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
}

gt.Const.World.Spawn.BanditBoss <-
{
	Name = "BanditBoss",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader,
			Weight = 1,
			Cost = 25,
			Roll = true
		},
		{
			MinR = 600,
			Weight = 1,
			Type = this.Const.World.Spawn.Troops.BanditWarlord,
			Cost = 50,
			Roll = true
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops =
	[
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 8
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditWarlord,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types =
			[
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types =
			[
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
}

gt.Const.World.Spawn.BanditsDisguisedAsDirewolves <-
{
	Name = "BanditsDisguisedAsDireWolves",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	//MinR = 75,
	MaxR = 475,
	Troops =
	[
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderWolf,
					Cost = 25
				}
			]
		}
	]
}

gt.Const.World.Spawn.BanditVermes <-
{
	Name = "BanditsVermes",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	//MinR = 75,
	MaxR = 475,
	Troops =
	[
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditVermes,
					Cost = 7
				}
			]
		}
	]
}