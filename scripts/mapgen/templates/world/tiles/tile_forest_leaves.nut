this.tile_forest_leaves <- this.inherit("scripts/mapgen/map_template", {
	m = {},
	function init()
	{
		this.m.Name = "world.tile.forest_leaves";
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

		tile.Type = this.Const.World.TerrainType.LeaveForest;
		tile.TacticalType = this.Const.World.TerrainTacticalType.LeaveForest;
		tile.setBrush("world_forest_0" + this.Math.rand(1, 4));
	}

	function onSecondPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local urban = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Urban);

		if (urban != 0)
		{
			tile.spawnDetail("world_detail_forest_leaves_cut_0" + this.Math.rand(1, 2), this.Const.World.ZLevel.Object, 0);
		}
		else
		{
			tile.spawnDetail("world_detail_forest_leaves_0" + this.Math.rand(2, 4), this.Const.World.ZLevel.Object, 0);
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
			tile.clearAllBut(this.Const.World.DetailType.Road);
			tile.spawnDetail("world_detail_forest_leaves_road_0" + this.Math.rand(1, 1), this.Const.World.ZLevel.Object, 0);
		}
	}

});

