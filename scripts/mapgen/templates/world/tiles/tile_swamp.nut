this.tile_swamp <- this.inherit("scripts/mapgen/map_template", {
	m = {
		Details = [
			"world_detail_swamp_00",
			"world_detail_swamp_02",
			"world_detail_swamp_03",
			"world_detail_swamp_04",
			"world_detail_swamp_05",
			"world_detail_swamp_06",
			"world_detail_swamp_07",
			"world_detail_swamp_08",
			"world_detail_swamp_09",
			"world_detail_swamp_10",
			"world_detail_swamp_11",
			"world_detail_swamp_12",
			"world_detail_swamp_13",
			"world_detail_swamp_14",
			"world_detail_swamp_00",
			"world_detail_swamp_02",
			"world_detail_swamp_03",
			"world_detail_swamp_04",
			"world_detail_swamp_05",
			"world_detail_swamp_06",
			"world_detail_swamp_08",
			"world_detail_swamp_09",
			"world_detail_swamp_11",
			"world_detail_swamp_12",
			"world_detail_swamp_13",
			"world_detail_swamp_14"
		]
	},
	function init()
	{
		this.m.Name = "world.tile.swamp";
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

		tile.Type = this.Const.World.TerrainType.Swamp;
		tile.TacticalType = this.Const.World.TerrainTacticalType.Swamp;
		tile.setBrush("world_swamp_0" + this.Math.rand(1, 4));
	}

	function onSecondPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local swamp = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Swamp);
		tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)], this.Const.World.ZLevel.Object, this.Const.World.DetailType.Swamp | this.Const.World.DetailType.NotCompatibleWithRoad);

		if (swamp >= 1)
		{
			local fog = tile.spawnDetail("world_swamp_fog_0" + this.Math.rand(1, 4), this.Const.World.ZLevel.Object + 300, 0);
			fog.Alpha = this.Math.min(255, swamp * 40);

			if (swamp >= 3)
			{
				fog = tile.spawnDetail("world_swamp_fog_0" + this.Math.rand(5, 6), this.Const.World.ZLevel.Object + 305, 0);
				fog.Alpha = this.Math.min(255, swamp * 25);
				fog.Torque = this.Math.rand(0, 30) - 15;
			}
		}
	}

	function onRoadPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);

		if (tile.IsOccupied)
		{
			return;
		}

		if (tile.HasRoad)
		{
			tile.clearAllBut(this.Const.World.DetailType.Road | this.Const.World.DetailType.Houses);
			tile.spawnDetail("world_detail_swamp_road_01", this.Const.World.ZLevel.Object, 0);
			local fog = tile.spawnDetail("world_swamp_fog_0" + this.Math.rand(1, 4), this.Const.World.ZLevel.Object + 5, 0);
			fog.Alpha = 150;
		}
	}

});

