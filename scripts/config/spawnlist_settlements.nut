local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.SettlementDefault <- {
	Name = "SettlementDefault",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_militia_01",
	MaxR = 200,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 5
				}
			]
		}
	]
};


gt.Const.World.Spawn.HumanVillage <- {
	Name = "HumanVillage",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_militia_01",
	MaxR = 350,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					Cost = 12
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				}
			]
		},
		{
			Weight = 9,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 20
				}
			]
		},
		{
			Weight = 1,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 15,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 15,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 15,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 15,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15,
					Roll = true
				}
			]
		}
	]
};

gt.Const.World.Spawn.HumanFort <- {
	Name = "HumanFort",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_noble_01",
	MaxR = 400,
	Fixed = [
		{
			Weight = 100,
			Type = this.Const.World.Spawn.Troops.StandardBearer,
			Cost = 20
		}
	],
	Troops = [
		{
			Weight = 44,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 15
				}
			]
		},
		{
			Weight = 21,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 15
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 30
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 80,
					Roll = true
				}
			]
		},
		{
			Weight = 6,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ArmoredWardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 60
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 60
				}
			]
		},
		{
			Weight = 4,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 60
				}
			]
		}
	]
};

gt.Const.World.Spawn.CityState <-
{
	Name = "CityState",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 500,
	Troops = [
		{
			Weight = 75,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Mercenary,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 15,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}
	]
};