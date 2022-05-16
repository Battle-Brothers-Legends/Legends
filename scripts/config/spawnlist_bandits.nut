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
	MinR = 56,
	MaxR = 220,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					// MaxR = 0.25 * 420,
					MaxR = 150,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MinR = 180,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					//MinR = 200,
					MinR = 125,					
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					//MinR = 400,					
					MinR = 320,
					Cost = 18
				},
				{
					//MinR = 800,
					MinR = 480,					
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
					MaxR = 45,
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
	MinR = 61, // TEST
	MaxR = 340,
	Fixed = [],
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 150,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MinR = 115,					
					Cost = 8
				},
				{
					//MinR = 200,
					MinR = 160,
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
			MinR = 170,
			//MinR = 340,
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
	MinR = 63, // TEST
	MaxR = 600
	Troops =
	[
		{
			Weight = 54,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					// MaxR = 0.15 * 400,
					//MaxR = 60, Luft change
					MaxR = 150,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					//MinR = 80,
					MinR = 115,
					Cost = 8
				},
				{
					//MinR = 200,					
					MinR = 160,
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					//MinR = 400,					
					MinR = 320,
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
					MaxR = 90,
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
				}
				// {
				// 	MinR = 600,
				// 	Type = this.Const.World.Spawn.Troops.BanditWarlord,
				// 	Cost = 125,
				// 	Roll = true
				// }
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
	MinR = 45, // TEST
	MaxR = 600
	Troops =
	[
		{
			Weight = 59,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 150,
					Cost = 6
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					MinR = 115,					
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					//MinR = 400,					
					MinR = 320,
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
			Weight = 18,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					MaxR = 110,
					Cost = 14
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
			Weight = 4,
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
					Cost = 100,
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
					//MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
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

gt.Const.World.Spawn.BanditArmy <- //legend_bandit_army_contract only!!
{
	Name = "BanditArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MaxR = 1,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditWarlord,
			Weight = 100, //100 Weight guarentees this will be added
			Cost = 1, //dictates cost taken from minR
			Roll = true
		}
	],
	MaxR = 12,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader, //no. 1
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader, //no. 2
			Weight = 100, 
			Cost = 1, 
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk, //stops morale shenanigans
			Weight = 75, 
			Cost = 2, 
			//Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditVeteran,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditMarksman,
			Weight = 45,
			Cost = 2,
			//Roll = true
		}
	],
	MinR = 145,
	MaxR = 600,
	Troops =
	[
		{
			Weight = 65,
			Types = [
				// {
				// 	Type = this.Const.World.Spawn.Troops.BanditThug,
				// 	Cost = 8
				// },
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					//MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
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
				// {
				// 	Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
				// 	Cost = 8
				// },
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
			Weight = 3,
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
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
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
	Name = "BanditsDisguisedAsDireWolves", //furry convention
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	MinR = 75, // TEST
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

gt.Const.World.Spawn.BanditVermes <- //unused
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
