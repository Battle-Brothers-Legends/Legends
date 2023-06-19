this.tile_farmland <- this.inherit("scripts/mapgen/map_template", {
	m = {},
	function init()
	{
		this.m.Name = "world.tile.farmland";
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

		tile.Type = this.Const.World.TerrainType.Farmland;
		tile.TacticalType = this.Const.World.TerrainTacticalType.Farmland;
	}

	function onSecondPass( _rect )
	{
		local tile = this.World.getTileSquare(_rect.X, _rect.Y);
		local heath = 0;
		local highlands = 0;

		for( local i = 0; i != 6; i = ++i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = tile.getNextTile(i);
				local type = nextTile.Type;

				if (type == this.Const.World.TerrainType.Heath)
				{
					heath = ++heath;
				}
				else if (type == this.Const.World.TerrainType.Tundra)
				{
					highlands = ++highlands;
				}
			}
		}

		if (heath >= 3)
		{
			tile.setBrush("world_heath_01");
		}
		else if (highlands >= 3)
		{
			tile.setBrush("world_highlands_01");
		}
		else
		{
			tile.setBrush("world_plains_01");
		}

		local flip = this.Math.rand(0, 1) == 1 ? true : false;
		local d = tile.spawnDetail("world_detail_fields", this.Const.World.ZLevel.Terrain, 0, flip);
		local n = this.Math.rand(2, 3);

		for( local i = 1; i <= n; i = ++i )
		{
			if (this.Math.rand(0, 1) == 0)
			{
				tile.spawnDetail("world_detail_fields_wheat_0" + i, this.Const.World.ZLevel.Terrain, 0, flip);
			}
			else
			{
				tile.spawnDetail("world_detail_fields_cabbage_0" + i, this.Const.World.ZLevel.Terrain, 0, flip);
			}
		}
	}

});

