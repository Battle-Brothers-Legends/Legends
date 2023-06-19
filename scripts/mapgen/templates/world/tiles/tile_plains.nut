this.tile_plains <- this.inherit("scripts/mapgen/map_template", {
	m = {
		DetailsTerrain = [
			"world_detail_earth_patch_01",
			"world_detail_earth_patch_02",
			"world_grass_lake_01",
			"world_grass_lake_02",
			"world_grass_lake_03"
		],
		DetailsObject = [
			"world_detail_treetrunk_01",
			"world_detail_stones_01",
			"world_detail_flowers_01",
			"world_detail_flowers_02",
			"world_detail_flowers_03",
			"world_detail_flowers_04",
			"world_detail_flowers_05",
			"world_detail_flowers_06"
		],
		DetailsGrass = [
			"world_grass_01",
			"world_grass_02",
			"world_grass_03",
			"world_grass_04",
			"world_grass_05",
			"world_grass_06"
		],
		DetailsLake = [
			"world_grass_lake_01",
			"world_grass_lake_02",
			"world_grass_lake_03",
			"world_grass_01",
			"world_grass_02",
			"world_grass_03",
			"world_grass_04",
			"world_grass_05"
		],
		DetailsMore = [
			"world_detail_flowers_01",
			"world_detail_flowers_02",
			"world_detail_flowers_03",
			"world_detail_flowers_04",
			"world_detail_flowers_05",
			"world_detail_flowers_06"
		],
		DetailsUrban = [
			"world_detail_treestump_01",
			"world_detail_treestump_02",
			"world_detail_flowers_01",
			"world_detail_flowers_02",
			"world_detail_flowers_03",
			"world_detail_flowers_04",
			"world_detail_flowers_05",
			"world_detail_flowers_06"
		]
	},
	function init()
	{
		this.m.Name = "world.tile.plains";
		this.m.MinX = 1;
		this.m.MinY = 1;
	}

	function onFirstPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.World.TerrainType.Plains;
		tile.TacticalType = this.Const.World.TerrainTacticalType.Plains;
		tile.setBrush("world_grassland_0" + this.Math.rand(1, 4));
	}

	function onSecondPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local forest = 0;
		local forest_leave = 0;
		local forest_autumn = 0;
		local mountain = 0;
		local hills = 0;
		local plains = 0;
		local swamp = 0;
		local urban = 0;
		local highlands = 0;
		local steppe = 0;
		local desert = 0;
		local oasis = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = tile.getNextTile(i);
				local type = nextTile.Type;

				if (type == this.Const.World.TerrainType.Forest)
				{
					forest = ++forest;
				}
				else if (type == this.Const.World.TerrainType.LeaveForest)
				{
					forest_leave = ++forest_leave;
				}
				else if (type == this.Const.World.TerrainType.Mountains)
				{
					mountain = ++mountain;
				}
				else if (type == this.Const.World.TerrainType.Hills)
				{
					hills = ++hills;
				}
				else if (type == this.Const.World.TerrainType.Plains)
				{
					plains = ++plains;
				}
				else if (type == this.Const.World.TerrainType.Swamp)
				{
					swamp = ++swamp;
				}
				else if (type == this.Const.World.TerrainType.Urban)
				{
					urban = ++urban;
				}
				else if (type == this.Const.World.TerrainType.Tundra)
				{
					highlands = ++highlands;
				}
				else if (type == this.Const.World.TerrainType.Steppe)
				{
					steppe = ++steppe;
				}
				else if (type == this.Const.World.TerrainType.Desert)
				{
					desert = ++desert;
				}
				else if (type == this.Const.World.TerrainType.Oasis)
				{
					oasis = ++oasis;
				}
				else if (type == this.Const.World.TerrainType.AutumnForest)
				{
					forest_autumn = ++forest_autumn;
				}
			}
		}

		if (forest > 0 && forest > forest_leave && forest > forest_autumn)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				tile.spawnDetail("world_detail_forest_light_0" + this.Math.rand(1, 5), this.Const.World.ZLevel.Object, 0);
			}
		}
		else if (forest_leave > 0 && forest_leave > forest && forest_leave > forest_autumn)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				tile.spawnDetail("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5), this.Const.World.ZLevel.Object, 0);
			}
		}
		else if (forest_autumn > 0 && forest_autumn > forest && forest_autumn > forest_leave)
		{
			if (this.Math.rand(1, 100) <= 50 + forest_autumn * 10)
			{
				local r = this.Math.rand(1, 10);
				tile.spawnDetail("world_detail_autumn_light_" + (r < 10 ? "0" + r : r), this.Const.World.ZLevel.Object, 0);
			}
		}
		else if (mountain != 0 || hills >= 2)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				tile.spawnDetail("world_detail_plains_stony_0" + this.Math.rand(1, 5), this.Const.World.ZLevel.Object, 0);
			}
		}
		else if (swamp != 0)
		{
			if (this.Math.rand(1, 100) <= 50 + swamp * 4)
			{
				tile.spawnDetail("world_detail_swamp_light_0" + this.Math.rand(0, 9), this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp);
			}
		}
		else if (oasis != 0)
		{
			if (this.Math.rand(1, 100) <= 33)
			{
				tile.spawnDetail("world_oasis_transition_0" + this.Math.rand(1, 6), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				local r = this.Math.rand(9, 13);

				if (r < 10)
				{
					r = "0" + r;
				}

				tile.spawnDetail("world_detail_desert_oasis_" + r, this.Const.World.ZLevel.Object, 0);
			}
		}
		else if (steppe != 0)
		{
			if (this.Math.rand(1, 100) <= 50 + steppe * 2)
			{
				local d = tile.spawnDetail("world_steppe_transition_0" + this.Math.rand(1, 4), this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
				d.setBrightness(0.95);
			}
			else if (this.Math.rand(1, 100) <= 10)
			{
				local d = tile.spawnDetail("world_steppe_brush_0" + this.Math.rand(1, 6), this.Const.World.ZLevel.Object, 0);
				d.Saturation = 0.8;
			}
		}
		else if (urban != 0 && this.Math.rand(1, 100) <= 25)
		{
			tile.spawnDetail(this.m.DetailsUrban[this.Math.rand(0, this.m.DetailsUrban.len() - 1)], this.Const.World.ZLevel.Object, 0);
		}
		else if (this.Math.rand(1, 1000) <= 25)
		{
			tile.spawnDetail(this.m.DetailsTerrain[this.Math.rand(0, this.m.DetailsTerrain.len() - 1)], this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
		}
		else if (this.Math.rand(1, 1000) <= 100)
		{
			if (this.Math.rand(0, 1) == 1)
			{
				tile.spawnDetail(this.m.DetailsObject[this.Math.rand(0, this.m.DetailsObject.len() - 1)], this.Const.World.ZLevel.Object, 0);
			}
			else
			{
				tile.spawnDetail(this.m.DetailsGrass[this.Math.rand(0, this.m.DetailsGrass.len() - 1)], this.Const.World.ZLevel.Terrain, this.Const.World.DetailType.NotCompatibleWithRoad);
			}
		}
		else if (this.Math.rand(1, 1000) <= 50)
		{
			tile.spawnDetail(this.m.DetailsMore[this.Math.rand(0, this.m.DetailsMore.len() - 1)], this.Const.World.ZLevel.Object, 0);
		}
		else if (this.Math.rand(1, 1000) <= 10)
		{
			if (_rect.Y < this.Const.World.Settings.SizeY * 0.5)
			{
				tile.spawnDetail("world_detail_forest_leaves_light_0" + this.Math.rand(1, 5), this.Const.World.ZLevel.Object, 0);
			}
			else
			{
				tile.spawnDetail("world_detail_forest_light_0" + this.Math.rand(1, 5), this.Const.World.ZLevel.Object, 0);
			}
		}
	}

});

