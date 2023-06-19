this.snow2 <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"tundra_grass_01",
			"tundra_grass_02",
			"tundra_grass_03",
			"tundra_grass_04",
			"tundra_grass_05"
		],
		DetailsSnow = [
			"snow_detail_01",
			"snow_detail_02",
			"snow_detail_03",
			"snow_detail_04",
			"snow_detail_05"
		],
		ChanceToSpawnDetails = 15,
		LimitOfSpawnedDetails = 4,
		Objects = [
			"entity/tactical/objects/tree_needle1_snow",
			"entity/tactical/objects/tree_needle2_snow",
			"entity/tactical/objects/snow_boulder1",
			"entity/tactical/objects/tree_needle1_snow",
			"entity/tactical/objects/tree_needle2_snow",
			"entity/tactical/objects/snow_boulder1",
			"entity/tactical/objects/snow_tree_trunk"
		],
		ChanceToSpawnObject = 4
	},
	function init()
	{
		this.m.Name = "tactical.tile.snow2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setBlendIntoSockets(false);
		t.setBrush(this.Const.Direction.N, "transition_snow_02_N");
		t.setBrush(this.Const.Direction.NE, "transition_snow_02_NE");
		t.setBrush(this.Const.Direction.SE, "transition_snow_02_SE");
		t.setBrush(this.Const.Direction.S, "transition_snow_02_S");
		t.setBrush(this.Const.Direction.SW, "transition_snow_02_SW");
		t.setBrush(this.Const.Direction.NW, "transition_snow_02_NW");
		t.setSocket("socket_snow");
		this.Tactical.setTransitions("tile_snow_02", t);
	}

	function onFirstPass( _rect, _objectSpawnChanceMult = 1.0 )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		local isSpawningObjects = !("SpawnObjects" in _rect) || _rect.SpawnObjects;
		tile.Type = this.Const.Tactical.TerrainType.RoughGround;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.Snow;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Snow2;
		tile.IsBadTerrain = false;
		tile.setBrush("tile_snow_02");
		local n = 0;

		if (isSpawningObjects && this.Math.rand(0, 100) < this.m.ChanceToSpawnObject * _objectSpawnChanceMult)
		{
			if (_objectSpawnChanceMult != 1.0 || !tile.hasNextTile(this.Const.Direction.S) || tile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (this.Math.rand(1, 100) <= this.m.ChanceToSpawnDetails)
		{
			if (this.Math.rand(1, 100) <= 90)
			{
				tile.spawnDetail(this.m.DetailsSnow[this.Math.rand(0, this.m.DetailsSnow.len() - 1)]);
			}
			else
			{
				tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
			}
		}
	}

});

