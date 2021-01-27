local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Settlements" in gt.Const.World))
{
	gt.Const.World.Settlements <- {};
}

gt.Const.World.Culture <- {
	Neutral = 0,
	Northern = 1,
	Southern = 2
};
gt.Const.World.Settlements.Villages <- [];
gt.Const.World.Settlements.Villages_small_coast <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/small_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0 && _terrain.Region[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Villages_small <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/small_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_snow_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_tundra_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_steppe_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_mining_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Hills || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Snow || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_swamp_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Swamp || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Swamp] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_lumber_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Forest || _terrain.Local == this.Const.World.TerrainType.AutumnForest || _terrain.Local == this.Const.World.TerrainType.LeaveForest) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_farming_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Villages_medium_coast <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/medium_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0 && _terrain.Region[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Villages_medium <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/medium_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_snow_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_tundra_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_steppe_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_mining_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Hills || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Snow || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_swamp_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Swamp || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Swamp] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_lumber_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Forest || _terrain.Local == this.Const.World.TerrainType.AutumnForest || _terrain.Local == this.Const.World.TerrainType.LeaveForest) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_farming_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Villages_large_coast <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/large_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0 && _terrain.Region[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Villages_large <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/large_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_snow_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_tundra_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_steppe_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_swamp_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Swamp || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Swamp] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_lumber_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_farming_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Fortifications_small <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/small_coast_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_snow_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_tundra_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_steppe_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_forest_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_mountains_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Hills) && (_terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_swamp_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Swamp) && (_terrain.Adjacent[this.Const.World.TerrainType.Swamp] > 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/small_farm_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0 && _terrain.Region[this.Const.World.TerrainType.Forest] == 0 && _terrain.Region[this.Const.World.TerrainType.AutumnForest] == 0 && _terrain.Region[this.Const.World.TerrainType.LeaveForest] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Fortifications_medium <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/medium_coast_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_snow_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_tundra_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_steppe_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_forest_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_mountains_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Hills) && (_terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_swamp_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Swamp) && (_terrain.Adjacent[this.Const.World.TerrainType.Swamp] > 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/medium_farm_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0 && _terrain.Region[this.Const.World.TerrainType.Forest] == 0 && _terrain.Region[this.Const.World.TerrainType.AutumnForest] == 0 && _terrain.Region[this.Const.World.TerrainType.LeaveForest] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Fortifications_large <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/large_coast_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_snow_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && (_terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_tundra_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && (_terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_steppe_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && (_terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_forest_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_mountains_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Hills) && (_terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/large_farm_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && (_terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0 && _terrain.Region[this.Const.World.TerrainType.Forest] == 0 && _terrain.Region[this.Const.World.TerrainType.AutumnForest] == 0 && _terrain.Region[this.Const.World.TerrainType.LeaveForest] == 0) && _terrain.Adjacent[this.Const.World.TerrainType.Desert] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.CityStates <- [
	{
		IsFlexible = true,
		Script = "scripts/entity/world/settlements/city_state",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Oasis || _terrain.Local == this.Const.World.TerrainType.Desert) && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Plains] == 0 && _terrain.Region[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Region[this.Const.World.TerrainType.Plains] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Master <- [
	{
		Amount = 3,
		List = this.Const.World.Settlements.Villages_small_coast
	},
	{
		Amount = 2,
		List = this.Const.World.Settlements.Villages_medium_coast
	},
	{
		Amount = 1,
		List = this.Const.World.Settlements.Villages_large_coast
	},
	{
		Amount = 6,
		List = this.Const.World.Settlements.Villages_small
	},
	{
		Amount = 4,
		List = this.Const.World.Settlements.Villages_medium
	},
	{
		Amount = 2,
		List = this.Const.World.Settlements.Villages_large
	},
	{
		Amount = 4,
		List = this.Const.World.Settlements.Fortifications_small
	},
	{
		Amount = 3,
		List = this.Const.World.Settlements.Fortifications_medium
	},
	{
		Amount = 2,
		List = this.Const.World.Settlements.Fortifications_large
	}
];

gt.Const.World.Settlements.Legends_villages_coast <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_fishing_village",
		function isSuitable( _terrain)
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
	}
];


gt.Const.World.Settlements.Legends_undead_forts <- [
	{
		Script = "scripts/entity/world/settlements/legends_undead_fort",
		function isSuitable( _terrain)
		{
			return true;
		}
	}
];

gt.Const.World.Settlements.Legends_villages <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_fishing_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_snow_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && _terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}

		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_tundra_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && _terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_steppe_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_mining_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Hills || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Snow || _terrain.Local == this.Const.World.TerrainType.Steppe) && _terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_swamp_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Swamp || _terrain.Local == this.Const.World.TerrainType.Tundra) && _terrain.Adjacent[this.Const.World.TerrainType.Swamp] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_lumber_village",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Forest || _terrain.Local == this.Const.World.TerrainType.AutumnForest || _terrain.Local == this.Const.World.TerrainType.LeaveForest) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_farming_village",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && _terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];
gt.Const.World.Settlements.Legends_fortifications <- [
	{
		IsCoastal = true,
		Script = "scripts/entity/world/settlements/legends_coast_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe) && (_terrain.Adjacent[this.Const.World.TerrainType.Ocean] > 0 || _terrain.Adjacent[this.Const.World.TerrainType.Shore] > 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_snow_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Snow && _terrain.Adjacent[this.Const.World.TerrainType.Snow] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_tundra_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Tundra && _terrain.Adjacent[this.Const.World.TerrainType.Tundra] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_steppe_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Steppe && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] >= 4 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_forest_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra) && (_terrain.Adjacent[this.Const.World.TerrainType.Forest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.LeaveForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.SnowyForest] >= 2 || _terrain.Adjacent[this.Const.World.TerrainType.AutumnForest] >= 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0))
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_mountains_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Hills) && _terrain.Adjacent[this.Const.World.TerrainType.Hills] >= 2 && _terrain.Region[this.Const.World.TerrainType.Mountains] >= 1 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_swamp_fort",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Plains || _terrain.Local == this.Const.World.TerrainType.Tundra || _terrain.Local == this.Const.World.TerrainType.Steppe || _terrain.Local == this.Const.World.TerrainType.Swamp) && _terrain.Adjacent[this.Const.World.TerrainType.Swamp] > 2 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	},
	{
		Script = "scripts/entity/world/settlements/legends_farm_fort",
		function isSuitable( _terrain )
		{
			if (_terrain.Local == this.Const.World.TerrainType.Plains && _terrain.Adjacent[this.Const.World.TerrainType.Plains] >= 4 && _terrain.Region[this.Const.World.TerrainType.Mountains] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Ocean] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Shore] == 0 && _terrain.Region[this.Const.World.TerrainType.Forest] == 0 && _terrain.Region[this.Const.World.TerrainType.AutumnForest] == 0 && _terrain.Region[this.Const.World.TerrainType.LeaveForest] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];

gt.Const.World.Settlements.Legends_citystates <- [
	{
		IsFlexible = true,
		Script = "scripts/entity/world/settlements/city_state",
		function isSuitable( _terrain )
		{
			if ((_terrain.Local == this.Const.World.TerrainType.Oasis || _terrain.Local == this.Const.World.TerrainType.Desert) && _terrain.Adjacent[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Adjacent[this.Const.World.TerrainType.Plains] == 0 && _terrain.Region[this.Const.World.TerrainType.Steppe] == 0 && _terrain.Region[this.Const.World.TerrainType.Plains] == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}

	}
];