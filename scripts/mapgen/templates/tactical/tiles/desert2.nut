this.desert2 <- this.inherit("scripts/mapgen/tactical_template", {
	m = {
		Details = [
			"desert_bones_01",
			"desert_bones_02",
			"desert_bones_03",
			"desert_bones_04",
			"desert_stone_detail_01",
			"desert_stone_detail_02",
			"desert_stone_detail_03",
			"desert_stone_detail_04",
			"desert_stone_detail_05",
			"desert_stone_detail_06",
			"desert_stone_detail_07",
			"desert_stone_detail_08",
			"desert_stone_detail_09",
			"desert_stone_detail_10",
			"desert_stone_detail_01",
			"desert_stone_detail_02",
			"desert_stone_detail_03",
			"desert_stone_detail_04",
			"desert_stone_detail_05",
			"desert_stone_detail_06",
			"desert_stone_detail_07",
			"desert_stone_detail_08",
			"desert_stone_detail_09",
			"desert_stone_detail_10",
			"desert_stone_detail_01",
			"desert_stone_detail_02",
			"desert_stone_detail_03",
			"desert_stone_detail_04",
			"desert_stone_detail_05",
			"desert_stone_detail_06",
			"desert_stone_detail_07",
			"desert_stone_detail_08",
			"desert_stone_detail_09",
			"desert_stone_detail_10"
		],
		HidingExtras = [
			"desert_grass_details_01",
			"desert_grass_details_02",
			"desert_grass_details_03",
			"desert_grass_details_04",
			"desert_grass_details_05"
		],
		ChanceToSpawnDetails = 5,
		LimitOfSpawnedDetails = 1,
		Objects = [
			"entity/tactical/objects/desert_boulder1",
			"entity/tactical/objects/desert_boulder2",
			"entity/tactical/objects/desert_boulder3",
			"entity/tactical/objects/desert_boulder1",
			"entity/tactical/objects/desert_boulder2",
			"entity/tactical/objects/desert_boulder3",
			"entity/tactical/objects/desert_boulder1",
			"entity/tactical/objects/desert_boulder2",
			"entity/tactical/objects/desert_boulder3",
			"entity/tactical/objects/desert_boulder1",
			"entity/tactical/objects/desert_boulder2",
			"entity/tactical/objects/desert_boulder3",
			"entity/tactical/objects/desert_ruin1",
			"entity/tactical/objects/desert_ruin2",
			"entity/tactical/objects/desert_ruin3",
			"entity/tactical/objects/tree_desert_large",
			"entity/tactical/objects/tree_desert_large",
			"entity/tactical/objects/tree_desert_large",
			"entity/tactical/objects/tree_desert_large",
			"entity/tactical/objects/desert_cactus1",
			"entity/tactical/objects/desert_cactus1",
			"entity/tactical/objects/desert_cactus1",
			"entity/tactical/objects/desert_cactus1",
			"entity/tactical/objects/desert_cactus1"
		],
		ChanceToSpawnObject = 1
	},
	function init()
	{
		this.m.Name = "tactical.tile.desert2";
		this.m.MinX = 1;
		this.m.MinY = 1;
		local t = this.createTileTransition();
		t.setSocket("socket_desert");
		this.Tactical.setTransitions("tile_desert_02", t);
		this.Tactical.setTransitions("tile_legend_desert_05", t);
		this.Tactical.setTransitions("tile_legend_desert_06", t);
		this.Tactical.setTransitions("tile_legend_desert_07", t);
		this.Tactical.setTransitions("tile_legend_desert_08", t);
	}

	function onFirstPass( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);

		if (tile.Type != 0)
		{
			return;
		}

		tile.Type = this.Const.Tactical.TerrainType.Sand;
		tile.Subtype = this.Const.Tactical.TerrainSubtype.Desert;
		tile.BlendPriority = this.Const.Tactical.TileBlendPriority.Desert2;
		tile.IsBadTerrain = false;
		 local random = this.Math.rand(1, 100);
		if (random <= 20)
		{
		tile.setBrush("tile_desert_02");
		}
		else if (random >= 21 && random <=40)
		{
		tile.setBrush("tile_legend_desert_05");
		}
		else if (random >= 41 && random <=60)
		{
		tile.setBrush("tile_legend_desert_06");
		}		
		else if (random >= 61 && random <=80)
		{
		tile.setBrush("tile_legend_desert_07");
		}
		else 
		{
		tile.setBrush("tile_legend_desert_08");
		}

		if (_rect.IsEmpty)
		{
			return;
		}

		if (this.Math.rand(0, 100) < this.m.ChanceToSpawnObject)
		{
			if (!tile.hasNextTile(this.Const.Direction.S) || tile.getNextTile(this.Const.Direction.S).IsEmpty)
			{
				tile.spawnObject(this.m.Objects[this.Math.rand(0, this.m.Objects.len() - 1)]);
			}
		}
		else if (this.Math.rand(0, 100) < this.m.ChanceToSpawnDetails)
		{
			tile.spawnDetail(this.m.Details[this.Math.rand(0, this.m.Details.len() - 1)]);
		}
	}

	function onSecondPass( _rect )
	{
		local tile = this.Tactical.getTileSquare(_rect.X, _rect.Y);
		local h = 0;

		if (tile.IsHidingEntity)
		{
			return;
		}

		if (tile.hasNextTile(this.Const.Direction.SW) && tile.getNextTile(this.Const.Direction.SW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.NE) && tile.getNextTile(this.Const.Direction.NE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.NW) && tile.getNextTile(this.Const.Direction.NW).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.SE) && tile.getNextTile(this.Const.Direction.SE).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.N) && tile.getNextTile(this.Const.Direction.N).IsHidingEntity)
		{
			h = ++h;
		}

		if (tile.hasNextTile(this.Const.Direction.S) && tile.getNextTile(this.Const.Direction.S).IsHidingEntity)
		{
			h = ++h;
		}

		if (h != 0)
		{
			tile.clear();
			local n = this.Math.rand(2, this.Math.min(this.Math.max(2, h), 4));

			for( local hi = 0; hi < n; hi = ++hi )
			{
				tile.spawnDetail(this.m.HidingExtras[this.Math.rand(0, this.m.HidingExtras.len() - 1)]);
			}
		}
	}

});

