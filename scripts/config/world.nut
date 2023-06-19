local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

gt.Const.World.DetailType <- {
	None = 0,
	Road = 1,
	River = 2,
	Swamp = 4,
	Hills = 8,
	Shore = 16,
	NotCompatibleWithRoad = 32,
	Lighting = 64,
	Houses = 128,
	Footprints = 256
};
gt.Const.World.TerrainType <- {
	Impassable = 0,
	Ocean = 1,
	Land = 2,
	Plains = 2,
	Swamp = 3,
	Hills = 4,
	Forest = 5,
	SnowyForest = 6,
	LeaveForest = 7,
	AutumnForest = 8,
	Mountains = 9,
	Urban = 10,
	Farmland = 11,
	Snow = 12,
	Badlands = 13,
	Tundra = 14,
	Steppe = 15,
	Shore = 16,
	Desert = 17,
	Oasis = 18,
	COUNT = 19
};
gt.Const.World.TerrainScript <- [
	"",
	"world.tile.ocean",
	"world.tile.plains",
	"world.tile.swamp",
	"world.tile.hills",
	"world.tile.forest",
	"world.tile.forest",
	"world.tile.forest_leaves",
	"world.tile.autumn_forest",
	"world.tile.mountains",
	"",
	"world.tile.farmland",
	"world.tile.snow",
	"world.tile.badlands",
	"world.tile.highlands",
	"world.tile.steppe",
	"world.tile.ocean",
	"world.tile.desert",
	"world.tile.oasis"
];
gt.Const.World.TerrainTypeSpeedMult <- [
	0.0,
	0.0,
	1.0,
	0.5,
	0.64,
	0.64,
	0.64,
	0.64,
	0.64,
	0.25,
	0.5,
	1.0,
	0.75,
	0.9,
	0.9,
	1.0,
	0.5,
	0.75,
	0.9
];
gt.Const.World.TerrainTypeVisibilityMult <- [
	1.0,
	1.0,
	1.0,
	0.9,
	0.9,
	0.5,
	0.5,
	0.5,
	0.5,
	0.5,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	0.9
];
gt.Const.World.TerrainTypeVisionRadiusMult <- [
	1.0,
	1.0,
	1.0,
	1.0,
	1.25,
	1.0,
	1.0,
	1.0,
	1.0,
	2.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0,
	1.0
];
gt.Const.World.TerrainFoodConsumption <- [
	0.0,
	1.0,
	1.0,
	1.1,
	1.1,
	1.0,
	1.1,
	1.0,
	1.0,
	2.0,
	1.0,
	1.0,
	1.1,
	1.25,
	1.0,
	1.1,
	1.0,
	1.5,
	1.0
];
gt.Const.World.TerrainTypeLineBattle <- [
	false,
	false,
	true,
	false,
	true,
	false,
	false,
	false,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true,
	true
];
gt.Const.World.TerrainTacticalType <- {
	Impassable = 0,
	Plains = 1,
	Swamp = 2,
	Hills = 3,
	SnowyHills = 4,
	Forest = 5,
	SnowyForest = 6,
	ForestHills = 7,
	LightForest = 8,
	LeaveForest = 9,
	AutumnForest = 10,
	Mountains = 11,
	Urban = 12,
	Farmland = 13,
	Snow = 14,
	Badlands = 15,
	Highlands = 16,
	HighlandsHills = 17,
	Steppe = 18,
	SteppeHills = 19,
	Shore = 20,
	Quarry = 21,
	Desert = 22,
	DesertHills = 23,
	Oasis = 24,
	COUNT = 25
};
gt.Const.World.TerrainTacticalTemplate <- [
	"",
	"tactical.plains",
	"tactical.swamp",
	"tactical.hills",
	"tactical.hills_snow",
	"tactical.forest",
	"tactical.forest_snow",
	"tactical.forest",
	"tactical.plains",
	"tactical.forest_leaves",
	"tactical.autumn",
	"tactical.mountain",
	"tactical.plains",
	"tactical.plains",
	"tactical.snow",
	"tactical.plains",
	"tactical.tundra",
	"tactical.hills_tundra",
	"tactical.steppe",
	"tactical.hills_steppe",
	"tactical.plains",
	"tactical.quarry",
	"tactical.desert",
	"tactical.hills_desert",
	"tactical.oasis"
];
gt.Const.World.TerrainTacticalImage <- [
	"",
	"engage/engage_grass",
	"engage/engage_swamp",
	"engage/engage_grass_hills",
	"engage/engage_snow_hills",
	"engage/engage_needles",
	"engage/engage_forest_snow",
	"engage/engage_needles",
	"engage/engage_grass",
	"engage/engage_forest",
	"engage/engage_autumn",
	"engage/engage_mountains",
	"engage/engage_grass",
	"engage/engage_grass",
	"engage/engage_snow",
	"engage/engage_grass",
	"engage/engage_tundra",
	"engage/engage_tundra_hills",
	"engage/engage_steppe",
	"engage/engage_steppe_hills",
	"engage/engage_grass",
	"engage/engage_quarry",
	"engage/engage_desert",
	"engage/engage_desert_hills",
	"engage/engage_oasis"
];
gt.Const.World.TerrainSettlementImages <- [
	{},
	{
		Foreground = null,
		Background = "ui/settlements/village_bg_07",
		Ramp = null,
		Mood = null
	},
	{
		Foreground = null,
		Background = "ui/settlements/village_bg_01",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_grass"
	},
	{
		Foreground = "ui/settlements/foreground_06",
		Background = "ui/settlements/village_bg_07",
		Ramp = "ui/settlements/ramp_06",
		Mood = "ui/settlements/mood_swamp"
	},
	{
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/village_bg_06",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_dark_mountains"
	},
	{
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/village_bg_05",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_dark_forest"
	},
	{
		Foreground = "ui/settlements/foreground_05",
		Background = "ui/settlements/village_bg_05",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_snow"
	},
	{
		Foreground = "ui/settlements/foreground_02",
		Background = "ui/settlements/village_bg_02",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_forest"
	},
	{
		Foreground = "ui/settlements/foreground_07",
		Background = "ui/settlements/village_bg_03",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_forest"
	},
	{
		Foreground = "ui/settlements/foreground_01",
		Background = "ui/settlements/village_bg_06",
		Ramp = "ui/settlements/ramp_01",
		Mood = "ui/settlements/mood_dark_mountains"
	},
	{},
	{},
	{
		Foreground = "ui/settlements/foreground_03",
		Background = "ui/settlements/village_bg_04",
		Ramp = "ui/settlements/ramp_01_snow",
		Mood = "ui/settlements/mood_snow"
	},
	{},
	{
		Foreground = null,
		Background = "ui/settlements/village_bg_09",
		Ramp = "ui/settlements/ramp_03",
		Mood = "ui/settlements/mood_tundra"
	},
	{
		Foreground = null,
		Background = "ui/settlements/village_bg_08",
		Ramp = "ui/settlements/ramp_04",
		Mood = "ui/settlements/mood_steppe"
	},
	{
		Foreground = null,
		Background = "ui/settlements/village_bg_07",
		Ramp = null,
		Mood = null
	},
	{
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/village_bg_10",
		Ramp = "ui/settlements/ramp_07",
		Mood = null
	},
	{
		Foreground = "ui/settlements/foreground_08",
		Background = "ui/settlements/village_bg_10",
		Ramp = "ui/settlements/ramp_07",
		Mood = null
	}
];
gt.Const.World.ZLevel <- {
	Terrain = 30,
	River = 20,
	Road = 0,
	Object = -10,
	Location = -20,
	Particles = -30
};
gt.Const.World.MovementSettings <- {
	GlobalMult = 0.75,
	NighttimeMult = 0.75,
	NotPlayerMult = 0.95,
	RoadMult = 1.5,
	RiverMult = 0.75,
	Speed = 100.0,
	SlowDownPartyPerTroop = 0.015,
	PlayerDirectMoveRadius = 400.0
};
gt.Const.World.SpeedSettings <- {
	FastMult = 2.5,
	EscortMult = 4,
	CampMult = 2.5
};
gt.Const.World.CombatSettings <- {
	CombatDistance = 100,
	CombatPlayerDistance = 100,
	CombatTickTime = 3.0,
	CombatStrengthMult = 0.4
};
gt.Const.World.GreaterEvilType <- {
	Random = 0,
	CivilWar = 1,
	Greenskins = 2,
	Undead = 3,
	HolyWar = 4,
	None = 255
};
gt.Const.World.GreaterEvilTypeBit <- {
	Random = 0,
	CivilWar = 1,
	Greenskins = 2,
	Undead = 4,
	HolyWar = 8,
	All = 1 | 2 | 4 | 8
};
gt.Const.World.GreaterEvilPhase <- {
	NotSet = 0,
	Warning = 1,
	Live = 2
};
gt.Const.World.FootprintsType <- {
	None = 0,
	Nobles = 1,
	CityState = 2,
	Caravan = 3,
	Peasants = 4,
	Militia = 5,
	Refugees = 6,
	Brigands = 7,
	Undead = 8,
	Orcs = 9,
	Goblins = 10,
	Barbarians = 11,
	Nomads = 12,
	Direwolves = 13,
	Ghouls = 14,
	Hyenas = 15,
	Serpents = 16,
	Spiders = 17,
	Unholds = 18,
	Alps = 19,
	Hexen = 20,
	Schrats = 21,
	Kraken = 22,
	SandGolems = 23,
	Lindwurms = 24,
	Mercenaries = 25,
	COUNT = 26
};
gt.Const.World.Settings <- {
	SizeX = 140,
	SizeY = 140,
	LandMassMult = 1.5,
	WaterConnectivity = 38,
	MinLandToWaterRatio = 1.7,
	MinDesertTiles = 2000,
	Snowline = 0.9,
	Vision = 500.0
};
gt.Const.World.TerrainTypeNavCost <- [
	0
];

for( local i = 1; i < this.Const.World.TerrainTypeSpeedMult.len(); i = ++i )
{
	gt.Const.World.TerrainTypeNavCost.push(10 * (1.0 / this.Const.World.TerrainTypeSpeedMult[i]));
}

gt.Const.World.TerrainTypeNavCost_Sneak <- [
	0
];

for( local i = 1; i < this.Const.World.TerrainTypeSpeedMult.len(); i = ++i )
{
	gt.Const.World.TerrainTypeNavCost_Sneak.push(10 * (1.0 / this.Const.World.TerrainTypeSpeedMult[i]) * this.Const.World.TerrainTypeVisibilityMult[i]);
}

gt.Const.World.TerrainTypeNavCost_Ship <- [
	0
];

for( local i = 1; i < this.Const.World.TerrainTypeSpeedMult.len(); i = ++i )
{
	gt.Const.World.TerrainTypeNavCost_Ship.push(0);
}

gt.Const.World.TerrainTypeNavCost_Ship[this.Const.World.TerrainType.Ocean] = 10;
gt.Const.World.TerrainTypeNavCost_Ship[this.Const.World.TerrainType.Shore] = 100;
gt.Const.World.TerrainTypeNavCost_Flat <- [
	0
];

for( local i = 1; i < this.Const.World.TerrainTypeSpeedMult.len(); i = ++i )
{
	gt.Const.World.TerrainTypeNavCost_Flat.push(10);
}

gt.Const.World.TerrainTypeNavCost_Flat[this.Const.World.TerrainType.Ocean] = 0;
gt.Const.World.RoadBrushes <- {
	function add( _d, _brush )
	{
		if (!("b" + _d in this))
		{
			this.rawset("b" + _d, _brush);
		}
	}

	function has( _d )
	{
		if ("b" + _d in this)
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	function get( _d )
	{
		if ("b" + _d in this)
		{
			return this.rawget("b" + _d);
		}
		else
		{
			this.logWarning("Road Brush undefined (" + _d + ")!");
			return "undefined road brush";
		}
	}

};
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "road_N_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SE, "road_N_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "road_N_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SW, "road_N_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW, "road_N_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N, "road_N_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "road_SE_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.S, "road_S_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SW, "road_SW_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.NW, "road_NE_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "road_N_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE, "road_SE_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "road_S_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.SW, "road_SE_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NW, "road_NW_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.N, "road_N_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE, "road_S_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "road_S_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW, "road_S_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW, "road_S_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.N, "road_N_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "road_SW_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE, "road_SE_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S, "road_S_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW, "road_SW_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "road_N_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "road_NE_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "road_NW_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.S, "road_S_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "road_SW_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "road_NW_SE_N");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE, "road_NW_SE_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "road_SW_NE_N");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "road_SW_NE_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "road_SW_NE_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "road_SW_SE_N");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "road_SW_NE_N_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "road_S_NW_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "road_NW_SE_N_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "road_N_S_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW, "road_N_S_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE, "road_N_S_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW, "road_N_S_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "road_N_S_NW_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.SW, "road_N_S_SE_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "road_NW_SE_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE, "road_SW_NW_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "road_SW_NE_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "road_N_NE_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "road_N_NW_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "road_S_NE_SE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "road_S_NW_SW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "road_SW_SE_N_NE");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW, "road_SW_SE_N_NW");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "road_NW_NE_SE_N");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "road_NW_NE_SE_S");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.N, "road_NW_NE_SW_N");
this.Const.World.RoadBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S, "road_NW_NE_SW_S");
gt.Const.World.TerrainBridgeBrushes <- [
	"crossing_bridge_NE_SW",
	"crossing_bridge_NE_SW",
	"crossing_bridge_NW_SE",
	"crossing_bridge_NE_SW",
	"crossing_bridge_NE_SW",
	"crossing_bridge_NW_SE"
];
gt.Const.World.RiverBrushes <- {
	function add( _d, _brush )
	{
		if (!("b" + _d in this))
		{
			this.rawset("b" + _d, _brush);
		}
	}

	function get( _d )
	{
		if ("b" + _d in this)
		{
			return this.rawget("b" + _d);
		}
		else
		{
			this.logWarning("River Brush undefined!");
			return "undefined river brush";
		}
	}

};
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "river_N_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SE, "river_N_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "river_N_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SW, "river_N_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW, "river_N_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N, "river_N_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_SE_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.S, "river_S_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SW, "river_SW_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.NW, "river_NE_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "river_N_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE, "river_SE_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "river_S_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.SW, "river_SE_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NW, "river_NW_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.N, "river_N_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE, "river_S_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "river_S_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW, "river_S_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW, "river_S_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.N, "river_N_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "river_SW_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE, "river_SE_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S, "river_S_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW, "river_SW_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "river_N_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "river_NE_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "river_NW_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.S, "river_S_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "river_SW_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE, "river_N_S_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW, "river_N_S_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "river_N_S_NW_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "river_N_S_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.SW, "river_N_S_SE_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW, "river_N_S_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "river_NW_SE_N");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "river_NW_SE_N_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE, "river_NW_SE_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "river_NW_SE_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N, "river_SW_NE_N");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "river_SW_NE_N_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.NW, "river_SW_NE_NW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.S, "river_SW_NE_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "river_SW_NW_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.N, "river_SW_SE_N");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_N_S_NE_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "river_N_S_NW_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S, "river_NW_SW_S");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_SW_NE_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "river_S_NW_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "river_N_NW_NE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.SW, "river_S_SE_SW");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_N_NE_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_S_NE_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "river_SW_NW_N");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_S_NW_NE_SE");
this.Const.World.RiverBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "river_S_SW_NE_SE");
gt.Const.World.BridgeBrushes <- {
	function add( _d, _brush )
	{
		if (!("b" + _d in this))
		{
			this.rawset("b" + _d, _brush);
		}
	}

	function get( _d )
	{
		if ("b" + _d in this)
		{
			return this.rawget("b" + _d);
		}
		else
		{
			this.logWarning("Bridge Brush undefined!");
			return "undefined bridge brush";
		}
	}

};
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "crossing_bridge_N_S");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW, "crossing_bridge_N_W");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SE, "crossing_bridge_N_SE");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.SW, "crossing_bridge_N_SW");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.NE, "crossing_bridge_NW_NE");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "crossing_bridge_NW_SE");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SW, "crossing_bridge_NE_SW");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NE, "crossing_bridge_S_NE");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.NW, "crossing_bridge_S_NW");
this.Const.World.BridgeBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.SE, "crossing_bridge_SW_SE");
gt.Const.World.CrossingBrushes <- {
	function add( _d, _brush )
	{
		if (!("b" + _d in this))
		{
			this.rawset("b" + _d, _brush);
		}
	}

	function get( _d )
	{
		if ("b" + _d in this)
		{
			return this.rawget("b" + _d);
		}
		else
		{
			this.logWarning("Crossing Brush undefined!");
			return "undefined crossing brush";
		}
	}

};
this.Const.World.CrossingBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.S, "crossing_W_E");
this.Const.World.CrossingBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NE, "crossing_NW_SE");
this.Const.World.CrossingBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SE, "crossing_NE_SW");
gt.Const.World.ShoreBrushes <- {
	function add( _d, _brush )
	{
		if (!("b" + _d in this))
		{
			this.rawset("b" + _d, _brush);
		}
	}

	function get( _d )
	{
		if ("b" + _d in this)
		{
			return this.rawget("b" + _d);
		}
		else
		{
			this.logWarning("Shore Brush undefined!");
			return "undefined shore brush";
		}
	}

};
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.N, "shore_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "shore_n_ne");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NE, "shore_ne");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE, "shore_ne_se");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S, "shore_ne_se_s");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW, "shore_ne_se_s_sw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NW, "shore_nw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "shore_nw_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "shore_nw_n_ne");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW, "shore_nw_sw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "shore_nw_sw_s_se");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S, "shore_s");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "shore_s_se");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE, "shore_s_se_ne");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N, "shore_s_se_ne_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW, "shore_s_sw_nw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "shore_s_sw_nw_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SE, "shore_se");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N, "shore_se_ne_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SE | this.Const.DirectionAsBit.NE | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NW, "shore_se_ne_n_nw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SW, "shore_sw");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N, "shore_sw_nw_n");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.NW | this.Const.DirectionAsBit.N | this.Const.DirectionAsBit.NE, "shore_sw_nw_n_ne");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S, "shore_sw_s");
this.Const.World.ShoreBrushes.add(this.Const.DirectionAsBit.SW | this.Const.DirectionAsBit.S | this.Const.DirectionAsBit.SE, "shore_sw_s_se");
gt.Const.World.TimeOfDay <- {
	Dawn = 0,
	Morning = 1,
	Midday = 2,
	Afternoon = 3,
	Evening = 4,
	Dusk = 5,
	Night = 6,
	EarlyMorning = 7
};
gt.Const.World.Buildings <- {
	Barbers = 0,
	Kennels = 0,
	Fletchers = 0,
	Temples = 0,
	Taxidermists = 0,
	TaxidermistsOriental = 0,
	Alchemists = 0,
	Arenas = 0,
	ArmorsmithsOriental = 0,
	WeaponsmithsOriental = 0,
	Stables = 0,
	function reset()
	{
		this.Barbers = 0;
		this.Kennels = 0;
		this.Fletchers = 0;
		this.Temples = 0;
		this.Taxidermists = 0;
		this.TaxidermistsOriental = 0;
		this.Alchemists = 0;
		this.Arenas = 0;
		this.ArmorsmithsOriental = 0;
		this.WeaponsmithsOriental = 0;
		this.Stables = 0;
	}

};

