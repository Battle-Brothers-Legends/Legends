local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.NomadRoamers <-
{
	Name = "NomadRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_03",
	Fixed = [],
	//MinR = 56,
	MaxR = 188,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					MaxR = 110,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					MinR = 200,
					Cost = 14
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 400,
					Cost = 30
				}
			]
		},
		{
			Weight = 18,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 250,
					Cost = 30
				}
			]
		}
	]
};

gt.Const.World.Spawn.NomadRaiders <-
{
	Name = "NomadRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	//MinR = 63,
	MaxR = 600
	Troops =
	[
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					MaxR = 130,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 14
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 100,
					Cost = 27
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 120,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker, //looks like M.Archer
					MinR = 420,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 10,
			MinR = 140,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 4,
			MinR = 140,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			MinR = 310,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 50,
					Roll = true
				}
			]
		}
	]
};

gt.Const.World.Spawn.NomadDefenders <-
{
	Name = "NomadDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	//MinR = 63,
	MaxR = 600
	Troops =
	[
		{
			Weight = 60,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					Cost = 25
				}
			]
		},
		{
			Weight = 21,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 120,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker, //looks like M.Archer
					MinR = 420,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 140,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 30,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 365,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 9,
			MinR = 420,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 50,
					Roll = true
				}
			]
		}
	]
};