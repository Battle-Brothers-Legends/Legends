this.tile_autumn_forest <- this.inherit("scripts/mapgen/map_template", {
	m = {
		Stolen = [
			"world_detail_highlands_03",
			"world_detail_highlands_04",
			"world_detail_highlands_06",
			"world_detail_highlands_09",
			"world_detail_highlands_21"
		]
	},
	function init()
	{
		this.m.Name = "world.tile.autumn_forest";
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

		tile.setBrush("world_autumn_0" + this.Math.rand(1, 2));
		tile.Type = this.Const.World.TerrainType.AutumnForest;
		tile.TacticalType = this.Const.World.TerrainTacticalType.AutumnForest;
	}

	function onSecondPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local urban = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.Urban);
		local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(1, 6), this.Const.World.ZLevel.Object, 0);
	}

	function onRoadPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);

		if (tile.IsOccupied)
		{
			return;
		}

		local forest_autumn = tile.getSurroundingTilesOfType(this.Const.World.TerrainType.AutumnForest);

		if (tile.HasRoad || forest_autumn <= 2)
		{
			tile.clearAllBut(this.Const.World.DetailType.Road);
			local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(1, 3), this.Const.World.ZLevel.Object, 0);
		}
		else if (forest_autumn >= 5 && this.Math.rand(1, 100) <= 75)
		{
			tile.clear();
			local d = tile.spawnDetail("world_detail_autumn_0" + this.Math.rand(4, 6), this.Const.World.ZLevel.Object, 0);
		}
	}

});

