this.worldmap_generator <- this.inherit("scripts/mapgen/map_template", {
	m = {
		Tiles = []
	},
	function init()
	{
		this.m.Name = "world.worldmap_generator";
		this.m.MinX = this.Const.World.Settings.SizeX;
		this.m.MinY = this.Const.World.Settings.SizeY;
	}

	function fill( _rect, _properties, _pass = 1 )
	{
		this.Const.World.Buildings.reset();
		this.m.Tiles = [];
		this.m.Tiles.resize(this.Const.World.TerrainType.COUNT);

		for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = ++i )
		{
			if (this.Const.World.TerrainScript[i].len() != 0)
			{
				this.m.Tiles[i] = this.MapGen.get(this.Const.World.TerrainScript[i]);
			}
		}

		this.__ping();

		while (true)
		{
			this.buildLandAndSea(_rect);
			this.__ping();

			if (!this.isWorldAcceptable(_rect))
			{
				this.logInfo("World rejected. Creating new one...");
				this.clearWorld(_rect);
				continue;
			}

			this.__ping();
			this.buildElevation(_rect);
			this.__ping();
			this.__ping();
			this.defragmentTerrain(_rect);
			this.__ping();

			if (this.Const.DLC.Desert && !this.isDesertAcceptable(_rect))
			{
				this.logInfo("World rejected. Creating new one...");
				this.clearWorld(_rect);
				continue;
			}

			this.logInfo("World accepted.");
			break;
		}

		this.__ping();
		this.removeStraits(_rect);
		this.__ping();
		this.refineTerrain(_rect, _properties);
		this.__ping();
		this.buildSettlements(_rect);
		this.__ping();
		this.buildRoads(_rect, _properties);
		this.__ping();
		this.refineSettlements(_rect);
		this.__ping();
		this.guaranteeAllBuildingsInSettlements();
		this.__ping();
		this.buildAdditionalRoads(_rect, _properties);
		this.__ping();
		this.buildRoadSprites(_rect, _properties);
		this.__ping();
		this.buildLabels(_rect);
		this.__ping();

		if (this.Const.DLC.Desert)
		{
			this.buildAbandonedFortresses(_rect);
		}

		this.__ping();
	}

	function isWorldAcceptable( _rect )
	{
		local ocean = 0;
		local nonOcean = 0;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
					ocean = ++ocean;
				}
				else
				{
					nonOcean = ++nonOcean;
				}
			}
		}

		return nonOcean * 1.0 / (ocean * 1.0) >= this.Const.World.Settings.MinLandToWaterRatio;
	}

	function isDesertAcceptable( _rect )
	{
		local desert = 0;

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Desert || tile.Type == this.Const.World.TerrainType.Oasis || tile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
				{
					desert = ++desert;
				}
			}
		}

		this.logInfo("desert tiles: " + desert);
		return desert >= this.Const.World.Settings.MinDesertTiles;
	}

	function clearWorld( _rect )
	{
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);
				tile.Type = 0;
				tile.Subregion = 0;
			}
		}
	}

	function buildLandAndSea( _rect )
	{
		this.logInfo("Building land and sea...");
		local l = false;
		local r = false;
		local t = false;
		local b = false;

		do
		{
			l = this.Math.rand(0, 1) == 1;
			r = this.Math.rand(0, 1) == 1;
			t = this.Math.rand(0, 1) == 1;
			b = this.Math.rand(0, 1) == 1;
		}
		while (!l && !r && !t && !b);

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);
				local landChance = x < _rect.W * 0.5 ? x : _rect.W - x;
				landChance = landChance + (y < _rect.H * 0.5 ? y : _rect.H - y);

				if (l)
				{
					landChance = landChance + (x < _rect.W * 0.5 ? x * 0.65 : 0);
				}

				if (r)
				{
					landChance = landChance + (x > _rect.W * 0.5 ? (x - _rect.W * 0.5) * 0.65 : 0);
				}

				if (b)
				{
					landChance = landChance + (y < _rect.H * 0.5 ? y * 0.65 : 0);
				}

				if (t)
				{
					landChance = landChance + (y > _rect.H * 0.5 ? (y - _rect.H * 0.5) * 0.65 : 0);
				}

				landChance = landChance * this.Const.World.Settings.LandMassMult;

				if (this.Math.rand(1, 100) <= landChance)
				{
					this.m.Tiles[this.Const.World.TerrainType.Plains].fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = true
					}, null);
					tile.Type = this.Const.World.TerrainType.Land;
				}
				else
				{
					this.m.Tiles[this.Const.World.TerrainType.Ocean].fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = true
					}, null);
					tile.Type = this.Const.World.TerrainType.Ocean;
				}
			}
		}

		if (this.Math.rand(0, 1) == 0)
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local n = 0;

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Ocean)
							{
								n = ++n;
							}
						}

						if (this.Math.rand(1, 100) <= n * this.Const.World.Settings.WaterConnectivity)
						{
							tile.Type = 0;
							this.m.Tiles[this.Const.World.TerrainType.Ocean].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}
		else
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local n = 0;

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Ocean)
							{
								n = ++n;
							}
						}

						if (this.Math.rand(1, 100) <= n * this.Const.World.Settings.WaterConnectivity)
						{
							tile.Type = 0;
							this.m.Tiles[this.Const.World.TerrainType.Ocean].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}

		for( local idle = false; !idle;  )
		{
			idle = true;

			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local n = 0;

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type != this.Const.World.TerrainType.Ocean)
							{
								n = ++n;
							}
						}

						if (n <= 1)
						{
							tile.Type = 0;
							this.m.Tiles[this.Const.World.TerrainType.Ocean].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}
	}

	function buildElevation( _rect )
	{
		this.logInfo("Building elevation...");

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
				}
				else if (this.Const.DLC.Desert && y <= _rect.H * 0.17)
				{
				}
				else
				{
					local chance = 9;

					if (this.Math.rand(1, 1000) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Mountains].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		if (this.Math.rand(0, 1) == 0)
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
					{
					}
					else
					{
						local n = 0;

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Mountains)
							{
								n = ++n;
							}
						}

						if (this.Math.rand(1, 100) <= n * 30)
						{
							tile.Type = 0;
							this.m.Tiles[this.Const.World.TerrainType.Mountains].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}
		else
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Mountains)
					{
					}
					else
					{
						local n = 0;

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Mountains)
							{
								n = ++n;
							}
						}

						if (this.Math.rand(1, 100) <= n * 30)
						{
							tile.Type = 0;
							this.m.Tiles[this.Const.World.TerrainType.Mountains].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local n = 0;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Mountains)
						{
							n = ++n;
						}
					}

					if (this.Math.rand(1, 100) <= n * 25)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Hills].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local n = 0;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (tile.hasNextTile(i) && tile.getNextTile(i).Type == this.Const.World.TerrainType.Hills)
						{
							n = ++n;
						}
					}

					if (this.Math.rand(1, 100) <= n * 30)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Hills].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}
	}

	function buildTerrainDLC( _rect )
	{
		this.logInfo("Building terrain...");
		local isAutumnLeft = this.Math.rand(0, 1) == 1;

		for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.2; y = ++y )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = 50;
					chance = chance + y * -0.8;

					if (y > _rect.Y + _rect.H * 0.19)
					{
						chance = chance * 0.25;
					}

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = 0;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Desert)
							{
								chance = chance + 50;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = chance + 25;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Desert].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local y = _rect.Y + _rect.H * 0.15; y < _rect.Y + _rect.H * 0.6; y = ++y )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = 16;
					chance = chance + y * -0.4;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = 0;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = chance + 50;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Desert)
							{
								chance = chance + 25;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance + 5;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Steppe].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.3; y < _rect.Y + _rect.H * 0.8; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y < _rect.H * 0.5 ? y : _rect.H - y;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = 0;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance + 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Swamp].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X + (isAutumnLeft ? _rect.W * 0.5 : 0); x < _rect.X + _rect.W * (isAutumnLeft ? 1.0 : 0.5); x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.2; y < _rect.Y + _rect.H * 0.7; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = !isAutumnLeft ? _rect.W - x : x;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.LeaveForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.LeaveForest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X + (isAutumnLeft ? 0 : _rect.W * 0.5); x < _rect.X + _rect.W * (isAutumnLeft ? 0.5 : 1.0); x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.2; y < _rect.Y + _rect.H * 0.75; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = isAutumnLeft ? _rect.W - x : x;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = -100;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.AutumnForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.AutumnForest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.43; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y < _rect.H * 0.75 ? y : _rect.H - y;
					chance = chance * 0.07;

					if (y > _rect.H * this.Const.World.Settings.Snowline)
					{
						chance = chance * 5.0;
					}

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = -100;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Forest || nextTile.Type == this.Const.World.TerrainType.SnowyForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 20;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Forest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.H * this.Const.World.Settings.Snowline - 5; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local n = 0;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Snow)
							{
								n = ++n;
							}
						}
					}

					if (n >= 4 || y >= _rect.H * this.Const.World.Settings.Snowline - this.Math.rand(0, 5))
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Snow].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.H * 0.7; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y;
					chance = chance * 0.2;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = chance + -200;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Tundra)
							{
								chance = chance + 100;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Tundra].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.65; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Desert)
				{
				}
				else
				{
					local chance = -1;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Desert)
							{
								chance = chance + 1;

								if (nextTile.Subregion == 99)
								{
									chance = chance + 17;
								}
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Subregion = 99;
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.65; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Steppe)
				{
				}
				else
				{
					local chance = -1;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = chance + 1;

								if (nextTile.Subregion == 99)
								{
									chance = chance + 17;
								}
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Subregion = 99;
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.15; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Plains)
				{
				}
				else
				{
					tile.Type = 0;
					this.m.Tiles[this.Const.World.TerrainType.Oasis].fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = true
					}, null);
				}
			}
		}
	}

	function buildTerrain( _rect )
	{
		this.logInfo("Building terrain...");
		local isAutumnLeft = this.Math.rand(0, 1) == 1;

		for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.65; y = ++y )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = 12;
					chance = chance + y * -0.5;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = 0;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = chance + 50;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance + 5;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Steppe].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.2; y < _rect.Y + _rect.H * 0.8; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y < _rect.H * 0.5 ? y : _rect.H - y;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = 0;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance + 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Swamp].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X + (isAutumnLeft ? _rect.W * 0.5 : 0); x < _rect.X + _rect.W * (isAutumnLeft ? 1.0 : 0.5); x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.7; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = !isAutumnLeft ? _rect.W - x : x;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.LeaveForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.LeaveForest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X + (isAutumnLeft ? 0 : _rect.W * 0.5); x < _rect.X + _rect.W * (isAutumnLeft ? 0.5 : 1.0); x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.75; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = isAutumnLeft ? _rect.W - x : x;
					chance = chance * 0.025;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = -100;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.AutumnForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 10;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.AutumnForest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y + _rect.H * 0.4; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y < _rect.H * 0.75 ? y : _rect.H - y;
					chance = chance * 0.07;

					if (y > _rect.H * this.Const.World.Settings.Snowline)
					{
						chance = chance * 5.0;
					}

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = -100;
								break;
							}

							if (nextTile.Type == this.Const.World.TerrainType.Forest || nextTile.Type == this.Const.World.TerrainType.SnowyForest)
							{
								chance = chance + 30;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Ocean)
							{
								chance = chance - 20;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Forest].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.H * this.Const.World.Settings.Snowline - 5; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local n = 0;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Snow)
							{
								n = ++n;
							}
						}
					}

					if (n >= 4 || y >= _rect.H * this.Const.World.Settings.Snowline - this.Math.rand(0, 5))
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Snow].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.H * 0.7; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Land)
				{
				}
				else
				{
					local chance = y;
					chance = chance * 0.2;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Swamp)
							{
								chance = chance + -200;
							}
							else if (nextTile.Type == this.Const.World.TerrainType.Tundra)
							{
								chance = chance + 100;
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Type = 0;
						this.m.Tiles[this.Const.World.TerrainType.Tundra].fill({
							X = x,
							Y = y,
							W = 1,
							H = 1,
							IsEmpty = true
						}, null);
					}
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H * 0.65; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Steppe)
				{
				}
				else
				{
					local chance = -1;

					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if (nextTile.Type == this.Const.World.TerrainType.Steppe)
							{
								chance = chance + 1;

								if (nextTile.Subregion == 99)
								{
									chance = chance + 17;
								}
							}
						}
					}

					if (this.Math.rand(1, 100) <= chance)
					{
						tile.Subregion = 99;
					}
				}
			}
		}
	}

	function defragmentTerrain( _rect )
	{
		this.logInfo("Defragmenting terrain...");

		for( local j = 0; j < 2; j = ++j )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type != this.Const.World.TerrainType.Land && tile.Type != this.Const.World.TerrainType.Steppe)
					{
					}
					else
					{
						local totalOcean = 0;
						local terrain = [];
						terrain.resize(this.Const.World.TerrainType.COUNT, 0);

						for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local nextTile = tile.getNextTile(i);
								++terrain[nextTile.Type];

								if (nextTile.Type == this.Const.World.TerrainType.Ocean)
								{
									totalOcean = ++totalOcean;
								}
							}
						}

						local max = 0;
						local maxTerrainType;
						local totalDifferent = 0;

						foreach( i, t in terrain )
						{
							if (i <= this.Const.World.TerrainType.Land)
							{
								continue;
							}

							totalDifferent = totalDifferent + t;

							if (t > max)
							{
								max = t;
								maxTerrainType = i;
							}
						}

						if (maxTerrainType != null && totalDifferent >= 4 - totalOcean)
						{
							tile.Type = 0;
							this.m.Tiles[maxTerrainType].fill({
								X = x,
								Y = y,
								W = 1,
								H = 1,
								IsEmpty = true
							}, null);
						}
					}
				}
			}
		}
	}

	function removeStraits( _rect )
	{
		this.logInfo("Spacing terrain...");

		for( local r = 0; r < 8; r = ++r )
		{
			for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
			{
				for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type != this.Const.World.TerrainType.Ocean)
					{
					}
					else
					{
						local best = 0;
						local bestKeep = 0;
						local bestCut = 0;

						for( local i = 0; i != 6; i = ++i )
						{
							local num = 0;
							local cut = 6;
							local stop = false;

							for( local j = 0; j != 6; j = ++j )
							{
								local n = i + j;

								if (n > 5)
								{
									n = n - 6;
								}

								if (!tile.hasNextTile(n))
								{
									num = 6;
									cut = 0;
									break;
								}

								local nextTile = tile.getNextTile(n);

								if (num != 0 && nextTile.Type == this.Const.World.TerrainType.Ocean)
								{
									cut = --cut;
									stop = true;
								}
								else if (!stop && nextTile.Type != this.Const.World.TerrainType.Ocean)
								{
									num = ++num;
									cut = --cut;
								}
							}

							if (num > bestKeep)
							{
								bestKeep = num;
								bestCut = cut;
								best = i;
							}
						}

						if (bestKeep > 0 && bestCut > 0)
						{
							local num = 0;

							for( local j = 0; j != 6; j = ++j )
							{
								local n = best + j;

								if (n > 5)
								{
									n = n - 6;
								}

								if (!tile.hasNextTile(n))
								{
								}
								else
								{
									local nextTile = tile.getNextTile(n);

									if (nextTile.Type != this.Const.World.TerrainType.Ocean)
									{
										num = ++num;

										if (num > bestKeep || bestKeep >= 5)
										{
											if (bestCut <= 3 && bestKeep < 5)
											{
												nextTile.Type = 0;
												this.m.Tiles[this.Const.World.TerrainType.Ocean].fill({
													X = nextTile.SquareCoords.X,
													Y = nextTile.SquareCoords.Y,
													W = 1,
													H = 1,
													IsEmpty = true
												}, null);
											}
											else
											{
												local terrain = [];
												terrain.resize(this.Const.World.TerrainType.COUNT, 0);

												for( local i = 0; i < 6; i = ++i )
												{
													if (!tile.hasNextTile(i))
													{
													}
													else
													{
														local wat = tile.getNextTile(i);

														if (wat.Type == this.Const.World.TerrainType.Ocean)
														{
														}
														else
														{
															++terrain[wat.Type];
														}
													}
												}

												local bestTerrain = 0;
												local bestCount = 0;

												foreach( i, t in terrain )
												{
													if (t > bestCount)
													{
														bestTerrain = i;
														bestCount = t;
													}
												}

												if (bestTerrain == 0)
												{
													bestTerrain = this.Const.World.TerrainType.Plains;
												}

												tile.Type = 0;
												this.m.Tiles[bestTerrain].fill({
													X = tile.SquareCoords.X,
													Y = tile.SquareCoords.Y,
													W = 1,
													H = 1,
													IsEmpty = true
												}, null);
												break;
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	function refineTerrain( _rect, _properties )
	{
		this.logInfo("Refining Terrain...");

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (this.m.Tiles[tile.Type] != null)
				{
					this.m.Tiles[tile.Type].fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = false
					}, _properties, 2);
				}
			}
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (this.m.Tiles[tile.Type] != null)
				{
					this.m.Tiles[tile.Type].fill({
						X = x,
						Y = y,
						W = 1,
						H = 1,
						IsEmpty = false
					}, _properties, 3);
				}
			}
		}

		local straitBrushes = [
			"world_coast_detail_08",
			"world_coast_detail_09",
			"world_coast_detail_29",
			"world_coast_detail_30",
			"world_coast_detail_31"
		];

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type != this.Const.World.TerrainType.Shore)
				{
				}
				else
				{
					local straitDir = -1;

					for( local i = 0; i != 3; i = ++i )
					{
						if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local tile1 = tile.getNextTile(i);

							if (tile1.Type == this.Const.World.TerrainType.Ocean || tile1.Type == this.Const.World.TerrainType.Shore)
							{
							}
							else
							{
								local j = i + 3 <= 5 ? i + 3 : i + 3 - 6;

								if (tile.hasNextTile(j) && tile.getNextTile(j).Type == this.Const.World.TerrainType.Shore && tile.getNextTile(j).hasNextTile(j))
								{
									local tile2 = tile.getNextTile(j).getNextTile(j);

									if (tile2.Type != this.Const.World.TerrainType.Ocean && tile2.Type != this.Const.World.TerrainType.Shore)
									{
										local j_right = j - 1 >= 0 ? j - 1 : 5;

										if (tile.hasNextTile(j_right) && tile.getNextTile(j_right).Type != this.Const.World.TerrainType.Ocean && tile.getNextTile(j_right).Type != this.Const.World.TerrainType.Shore)
										{
										}
										else
										{
											local j_left = j + 1 <= 5 ? j + 1 : 0;

											if (tile.hasNextTile(j_left) && tile.getNextTile(j_left).Type != this.Const.World.TerrainType.Ocean && tile.getNextTile(j_left).Type != this.Const.World.TerrainType.Shore)
											{
											}
											else
											{
												straitDir = j;
												tile.getNextTile(j).clearAllBut(this.Const.World.DetailType.Shore);
												break;
											}
										}
									}
								}
							}
						}
					}

					if (straitDir == -1)
					{
					}
					else
					{
						tile.clearAllBut(this.Const.World.DetailType.Shore);
						local offset;

						if (straitDir == 3)
						{
							offset = this.createVec(0, -100);
						}
						else if (straitDir == 4)
						{
							offset = this.createVec(-75, -70);
						}
						else if (straitDir == 5)
						{
							offset = this.createVec(-75, -10);
						}
						else
						{
							offset = this.createVec(0, 0);
						}

						tile.spawnDetail(straitBrushes[this.Math.rand(0, straitBrushes.len() - 1)], this.Const.World.ZLevel.Terrain, 0, this.Math.rand(0, 1) == 1, false, offset);
					}
				}
			}
		}
	}

	function buildLabels( _rect )
	{
		this.logInfo("Building regions...");
		local regions = [];

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean)
				{
				}
				else
				{
					local regionID = this.World.findNextRegion(tile, 3, tile.Type);

					if (regionID != 0 && regionID < regions.len())
					{
						tile.Region = regionID;
						regions[regionID].Tiles.push(tile);
					}
					else
					{
						regionID = regions.len();
						tile.Region = regionID;
						local region = {
							ID = regionID,
							Type = tile.Type,
							Tiles = [
								tile
							]
						};
						regions.push(region);
					}
				}
			}
		}

		this.logInfo("Found " + regions.len() + " separate regions.");

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);
				tile.Region = 0;
			}
		}

		local usedNames = [];
		local finalRegions = [];

		foreach( region in regions )
		{
			if (region.Tiles.len() < 80)
			{
				continue;
			}

			if (this.Const.Strings.TerrainRegionNames[region.Type].len() == 0)
			{
				continue;
			}

			local x = 0.0;
			local y = 0.0;

			foreach( t in region.Tiles )
			{
				x = x + t.Pos.X;
				y = y + t.Pos.Y;
			}

			x = x / region.Tiles.len();
			y = y / region.Tiles.len();
			local tile = this.World.getTile(this.World.worldToTile(this.createVec(x, y)));
			local result = {};

			if (this.World.findNextTileOfType(tile, 9, region.Type, result))
			{
				tile = result.Result;
			}
			else
			{
				this.logInfo("Failed to find decent spot for region label.");
				continue;
			}

			local leftY = 0.0;
			local leftX = 0.0;
			local rightY = 0.0;
			local rightX = 0.0;
			local left = 0;
			local right = 0;

			foreach( t in region.Tiles )
			{
				if (t.Pos.X <= x)
				{
					leftX = leftX + t.Pos.X;
					leftY = leftY + t.Pos.Y;
					left = ++left;
				}
				else
				{
					rightX = rightX + t.Pos.X;
					rightY = rightY + t.Pos.Y;
					right = ++right;
				}
			}

			leftX = leftX / left;
			leftY = leftY / left;
			rightX = rightX / right;
			rightY = rightY / right;
			local rotation = this.Math.getAngleTo(this.createVec(leftX, leftY), this.createVec(rightX, rightY)) + 90.0;
			local name = "";
			local tries = 0;

			do
			{
				name = this.Const.Strings.TerrainRegionNames[region.Type][this.Math.rand(0, this.Const.Strings.TerrainRegionNames[region.Type].len() - 1)];
				tries = ++tries;
			}
			while (usedNames.find(name) != null && tries <= 1000);

			if (tries > 1000)
			{
				continue;
			}

			usedNames.push(name);
			local scale = 1.0;

			if (region.Tiles.len() <= 130)
			{
				scale = 0.5;
			}
			else if (region.Tiles.len() <= 170)
			{
				scale = 0.75;
			}

			this.World.spawnRegionText(name, scale, rotation, tile.Pos);
			finalRegions.push({
				Name = name,
				Type = region.Type,
				Size = region.Tiles.len(),
				Center = tile,
				Discovered = 0.0,
				Tiles = region.Tiles
			});

			foreach( t in region.Tiles )
			{
				t.Region = finalRegions.len();
			}
		}

		this.logInfo("Creating final " + finalRegions.len() + " regions...");

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Region != 0 || tile.Type == this.Const.World.TerrainType.Ocean)
				{
				}
				else
				{
					tile.Region = this.World.findNextRegion(tile, 16, 0);
				}
			}
		}

		this.World.State.m.Regions = finalRegions;
	}

	function buildSettlements( _rect )
	{
		this.logInfo("Building settlements...");
		local isLeft = this.Math.rand(0, 1);
		local settlementTiles = [];

		foreach( list in this.Const.World.Settlements.Master )
		{
			local num = list.Amount;
			local tries = 0;
			local used = [];
			local ignoreSide = ("IgnoreSide" in list) && list.IgnoreSide;

			while (num > 0 && tries++ < 3000)
			{
				local x;
				local y;

				if (!ignoreSide)
				{
					if (isLeft)
					{
						x = this.Math.rand(5, _rect.W * 0.6);
					}
					else
					{
						x = this.Math.rand(_rect.W * 0.4, _rect.W - 6);
					}
				}
				else
				{
					x = this.Math.rand(5, _rect.W - 6);
				}

				y = this.Math.rand(5, _rect.H * 0.95);
				local tile = this.World.getTileSquare(x, y);

				if (used.find(tile.ID) != null)
				{
					continue;
				}

				used.push(tile.ID);
				local next = false;

				foreach( settlement in settlementTiles )
				{
					if (tile.getDistanceTo(settlement) < 12 + ("AdditionalSpace" in list ? list.AdditionalSpace : 0))
					{
						next = true;
						break;
					}
				}

				if (next)
				{
					continue;
				}

				local terrain = this.getTerrainInRegion(tile);

				if (terrain.Adjacent[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Adjacent[this.Const.World.TerrainType.Shore] >= 3)
				{
					continue;
				}

				local candidates = [];

				foreach( settlement in list.List )
				{
					if (settlement.isSuitable(terrain))
					{
						candidates.push(settlement);
					}
				}

				if (candidates.len() == 0)
				{
					continue;
				}

				local type = candidates[this.Math.rand(0, candidates.len() - 1)];

				if ((terrain.Region[this.Const.World.TerrainType.Ocean] >= 3 || terrain.Region[this.Const.World.TerrainType.Shore] >= 3) && !("IsCoastal" in type) && !("IsFlexible" in type))
				{
					continue;
				}

				if (!("IsCoastal" in type))
				{
					local skip = settlementTiles.len() != 0;
					local navSettings = this.World.getNavigator().createSettings();

					for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
					{
						local settlement = settlementTiles[i];
						navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
						local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

						if (!path.isEmpty())
						{
							skip = false;
							break;
						}
					}

					if (skip)
					{
						continue;
					}
				}
				else if (settlementTiles.len() >= 1 && tries < 500)
				{
					local hasConnection = false;

					for( local i = settlementTiles.len() - 1; i >= 0; i = --i )
					{
						local settlement = settlementTiles[i];
						local navSettings = this.World.getNavigator().createSettings();
						navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
						local path = this.World.getNavigator().findPath(tile, settlement, navSettings, 0);

						if (!path.isEmpty())
						{
							hasConnection = true;
							break;
						}
					}

					if (!hasConnection)
					{
						continue;
					}
				}

				tile.clear();
				local entity = this.World.spawnLocation(type.Script, tile.Coords);
				settlementTiles.push(tile);
				tries = 0;
				num = --num;
			}
		}

		this.logInfo("Created " + settlementTiles.len() + " settlements.");
	}

	function guaranteeAllBuildingsInSettlements()
	{
		local settlements = this.World.EntityManager.getSettlements();

		if (this.Const.World.Buildings.Fletchers < 2)
		{
			local candidates = [];

			foreach( s in settlements )
			{
				if (s.getSize() >= 2 && s.hasFreeBuildingSlot() && !s.hasBuilding("building.fletcher"))
				{
					candidates.push(s);
				}
			}

			for( local i = this.Const.World.Buildings.Fletchers; i <= 2; i = ++i )
			{
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/fletcher_building"));

				if (candidates.len() == 0)
				{
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Temples < 2)
		{
			local candidates = [];

			foreach( s in settlements )
			{
				if (s.getSize() >= 2 && s.hasFreeBuildingSlot() && !s.hasBuilding("building.temple"))
				{
					candidates.push(s);
				}
			}

			for( local i = this.Const.World.Buildings.Temples; i <= 2; i = ++i )
			{
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/temple_building"));

				if (candidates.len() == 0)
				{
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Barbers < 2)
		{
			local candidates = [];

			foreach( s in settlements )
			{
				if (s.getSize() >= 2 && !s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.barber"))
				{
					candidates.push(s);
				}
			}

			for( local i = this.Const.World.Buildings.Barbers; i <= 2; i = ++i )
			{
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/barber_building"));

				if (candidates.len() == 0)
				{
					break;
				}
			}
		}

		if (this.Const.World.Buildings.Kennels < 2)
		{
			local candidates = [];

			foreach( s in settlements )
			{
				if (s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.kennel"))
				{
					candidates.push(s);
				}
			}

			for( local i = this.Const.World.Buildings.Kennels; i <= 2; i = ++i )
			{
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/kennel_building"));

				if (candidates.len() == 0)
				{
					break;
				}
			}
		}

		if (this.Const.DLC.Unhold && this.Const.World.Buildings.Taxidermists < 2)
		{
			local candidates = [];

			foreach( s in settlements )
			{
				if (!s.isMilitary() && s.hasFreeBuildingSlot() && !s.hasBuilding("building.taxidermist"))
				{
					candidates.push(s);
				}
			}

			for( local i = this.Const.World.Buildings.Taxidermists; i <= 2; i = ++i )
			{
				local r = this.Math.rand(0, candidates.len() - 1);
				local s = candidates[r];
				candidates.remove(r);
				s.addBuilding(this.new("scripts/entity/world/settlements/buildings/taxidermist_building"));

				if (candidates.len() == 0)
				{
					break;
				}
			}
		}
	}

	function refineSettlements( _rect )
	{
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			s.updateProperties();
			s.build();
		}

		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				foreach( s in settlements )
				{
					local d = s.getTile().getDistanceTo(tile);

					if (d > 6)
					{
						continue;
					}

					tile.HeatFromSettlements = tile.HeatFromSettlements + (6 - d);
				}
			}
		}
	}

	function buildRoads( _rect, _properties )
	{
		this.logInfo("Building roads...");
		local settlements = this.World.EntityManager.getSettlements();
		local roadConnections = [];
		roadConnections.resize(settlements.len());

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			roadConnections[i] = [];
			roadConnections[i].resize(settlements.len(), false);
		}

		local roadCost = [
			0,
			0,
			10,
			50,
			60,
			40,
			40,
			40,
			40,
			0,
			1,
			50,
			30,
			30,
			10,
			10,
			0,
			10,
			10
		];
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = roadCost;
		navSettings.RoadMult = 0.15;
		navSettings.StopAtRoad = false;

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			local numConnections = 0;
			local tries = 0;
			tries = ++tries;

			while (numConnections < 2 && tries < 50)
			{
				local closest;
				local closestDist = 9000;
				local closestJ = i;

				for( local j = 0; j != settlements.len(); j = ++j )
				{
					if (i == j)
					{
					}
					else if (roadConnections[i][j] == true)
					{
					}
					else
					{
						local dist = settlements[i].getTile().getDistanceTo(settlements[j].getTile());

						if (dist < closestDist)
						{
							closest = settlements[j].getTile();
							closestDist = dist;
							closestJ = j;
						}
					}
				}

				if (closest != null)
				{
					local path = this.World.getNavigator().findPath(settlements[i].getTile(), closest, navSettings, 0);
					roadConnections[i][closestJ] = true;
					roadConnections[closestJ][i] = true;

					if (!path.isEmpty())
					{
						numConnections = ++numConnections;
					}

					local roadTiles = [];
					roadTiles.push(settlements[i].getTile());

					while (path.getSize() >= 1)
					{
						local tile = this.World.getTile(path.getCurrent());
						roadTiles.push(tile);
						path.pop();
					}

					local prevTile;

					foreach( i, tile in roadTiles )
					{
						local dirA = prevTile != null ? tile.getDirectionTo(prevTile) : 0;
						local dirB = i < roadTiles.len() - 1 ? tile.getDirectionTo(roadTiles[i + 1]) : 0;

						if ((tile.RoadDirections & this.Const.DirectionBit[dirA]) == 0 || (tile.RoadDirections & this.Const.DirectionBit[dirB]) == 0)
						{
							tile.RoadDirections = tile.RoadDirections | this.Const.DirectionBit[dirA] | this.Const.DirectionBit[dirB];
						}

						prevTile = tile;
					}
				}
			}
		}

		this.removeAutobahnkreuze(_rect, _properties);
	}

	function buildAdditionalRoads( _rect, _properties )
	{
		this.logInfo("Building additional roads...");
		local settlements = this.World.EntityManager.getSettlements();
		local roadCost = [
			0,
			0,
			10,
			50,
			80,
			40,
			40,
			40,
			40,
			0,
			1,
			50,
			30,
			30,
			10,
			10,
			0,
			10
		];
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = roadCost;
		navSettings.RoadMult = 0.25;
		navSettings.StopAtRoad = false;

		for( local i = 0; i != settlements.len(); i = ++i )
		{
			local targets = [];
			local settlementTile = settlements[i].getTile();

			foreach( a in settlements[i].getAttachedLocations() )
			{
				if (!a.isConnected())
				{
					continue;
				}

				local tile = a.getTile();

				if (!tile.HasRoad)
				{
					targets.push(tile);
				}
			}

			foreach( locTile in targets )
			{
				local path = this.World.getNavigator().findPath(settlementTile, locTile, navSettings, 0);
				local roadTiles = [];
				roadTiles.push(settlementTile);

				while (path.getSize() >= 1)
				{
					local tile = this.World.getTile(path.getCurrent());
					roadTiles.push(tile);
					path.pop();
				}

				local prevTile;
				local abort = false;

				foreach( i, tile in roadTiles )
				{
					if (tile.Type == this.Const.World.TerrainType.Hills)
					{
						abort = true;
						break;
					}

					local dirA = prevTile != null ? tile.getDirectionTo(prevTile) : 0;
					local dirB = i < roadTiles.len() - 1 ? tile.getDirectionTo(roadTiles[i + 1]) : 0;

					if ((tile.RoadDirections & this.Const.DirectionBit[dirA]) == 0 || (tile.RoadDirections & this.Const.DirectionBit[dirB]) == 0)
					{
						local dir = tile.RoadDirections | this.Const.DirectionBit[dirA] | this.Const.DirectionBit[dirB];

						if (!this.Const.World.RoadBrushes.has(dir))
						{
							abort = true;
							break;
						}
					}

					prevTile = tile;
				}

				if (abort)
				{
					continue;
				}

				prevTile = null;

				foreach( i, tile in roadTiles )
				{
					local dirA = prevTile != null ? tile.getDirectionTo(prevTile) : 0;
					local dirB = i < roadTiles.len() - 1 ? tile.getDirectionTo(roadTiles[i + 1]) : 0;

					if ((tile.RoadDirections & this.Const.DirectionBit[dirA]) == 0 || (tile.RoadDirections & this.Const.DirectionBit[dirB]) == 0)
					{
						tile.RoadDirections = tile.RoadDirections | this.Const.DirectionBit[dirA] | this.Const.DirectionBit[dirB];
					}

					prevTile = tile;
				}
			}
		}
	}

	function removeAutobahnkreuze( _rect, _properties )
	{
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (!tile.HasRoad)
				{
				}
				else
				{
					for( local i = 0; i < 6; i = ++i )
					{
						if ((tile.RoadDirections & this.Const.DirectionBit[i]) == 0)
						{
						}
						else if (!tile.hasNextTile(i))
						{
						}
						else
						{
							local nextTile = tile.getNextTile(i);

							if ((nextTile.RoadDirections & this.Const.DirectionBit[nextTile.getDirectionTo(tile)]) == 0)
							{
							}
							else
							{
								local leftDir = i - 1 >= 0 ? i - 1 : 5;
								local rightDir = i + 1 <= 5 ? i + 1 : 0;
								local dir = [
									leftDir,
									rightDir
								];

								for( local j = 0; j < dir.len(); j = ++j )
								{
									if ((tile.RoadDirections & this.Const.DirectionBit[dir[j]]) == 0)
									{
									}
									else if (!tile.hasNextTile(dir[j]))
									{
									}
									else
									{
										local extraTile = tile.getNextTile(dir[j]);

										if ((extraTile.RoadDirections & this.Const.DirectionBit[extraTile.getDirectionTo(nextTile)]) == 0 || (nextTile.RoadDirections & this.Const.DirectionBit[nextTile.getDirectionTo(extraTile)]) == 0)
										{
										}
										else
										{
											nextTile.RoadDirections = nextTile.RoadDirections & ~this.Const.DirectionBit[nextTile.getDirectionTo(extraTile)];
											extraTile.RoadDirections = extraTile.RoadDirections & ~this.Const.DirectionBit[extraTile.getDirectionTo(nextTile)];
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}

	function buildRoadSprites( _rect, _properties )
	{
		for( local x = _rect.X; x < _rect.X + _rect.W; x = ++x )
		{
			for( local y = _rect.Y; y < _rect.Y + _rect.H; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (!tile.HasRoad)
				{
				}
				else
				{
					if (tile.Type == this.Const.World.TerrainType.Hills && !tile.IsOccupied)
					{
						local terrain = [];
						terrain.resize(this.Const.World.TerrainType.COUNT, 0);

						for( local i = 0; i < 6; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local nextTile = tile.getNextTile(i);

								if (nextTile.Type == this.Const.World.TerrainType.Ocean || nextTile.Type == this.Const.World.TerrainType.Shore || nextTile.Type == this.Const.World.TerrainType.Hills || nextTile.Type == this.Const.World.TerrainType.Mountains)
								{
								}
								else
								{
									++terrain[nextTile.Type];
								}
							}
						}

						local best = 0;
						local bestNum = 0;

						foreach( i, t in terrain )
						{
							if (t > bestNum)
							{
								best = i;
								bestNum = t;
							}
						}

						if (best == 0)
						{
							best = this.Const.World.TerrainType.Plains;
						}

						tile.Type = 0;
						tile.clearAllBut(this.Const.World.DetailType.Houses);
						this.m.Tiles[best].fill({
							X = tile.SquareCoords.X,
							Y = tile.SquareCoords.Y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties, 1);
						this.m.Tiles[best].fill({
							X = tile.SquareCoords.X,
							Y = tile.SquareCoords.Y,
							W = 1,
							H = 1,
							IsEmpty = false
						}, _properties, 2);
					}

					tile.clear(this.Const.World.DetailType.Road | this.Const.World.DetailType.Swamp | this.Const.World.DetailType.NotCompatibleWithRoad);

					if ("onRoadPass" in this.m.Tiles[tile.Type])
					{
						this.m.Tiles[tile.Type].onRoadPass({
							X = tile.SquareCoords.X,
							Y = tile.SquareCoords.Y,
							W = 1,
							H = 1,
							IsEmpty = false
						});
					}

					tile.spawnDetail(this.Const.World.RoadBrushes.get(tile.RoadDirections), this.Const.World.ZLevel.Road, this.Const.World.DetailType.Road, false);
				}
			}
		}
	}

	function buildAbandonedFortresses( _rect )
	{
		this.logInfo("Placing abandoned fortresses...");
		local settlements = this.World.EntityManager.getSettlements();
		local candidates = [];

		for( local x = 5; x < _rect.X + _rect.W - 5; x = ++x )
		{
			for( local y = 28; y <= 38; y = ++y )
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Desert && tile.Type != this.Const.World.TerrainType.Steppe && tile.Type != this.Const.World.TerrainType.Hills)
				{
				}
				else if (tile.HasRoad)
				{
				}
				else
				{
					local tooFar = true;
					local tooClose = false;

					foreach( s in settlements )
					{
						local d = s.getTile().getDistanceTo(tile);

						if (d < 8)
						{
							tooClose = true;
							  // [084]  OP_JMP            0      7    0    0
						}
						else if (d <= 20)
						{
							tooFar = false;
						}
					}

					if (tooFar || tooClose)
					{
					}
					else
					{
						local score = 1;

						for( local i = 0; i < 6; i = ++i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local nextTile = tile.getNextTile(i);

								if (nextTile.HasRoad)
								{
									score = score + 15;
								}

								if (tile.Type == this.Const.World.TerrainType.Mountains)
								{
									score = score + 20;
								}
								else if (tile.Type == this.Const.World.TerrainType.Hills)
								{
									score = score + 5;
								}
							}
						}

						candidates.push({
							Tile = tile,
							Score = score
						});
					}
				}
			}
		}

		candidates.sort(function ( _a, _b )
		{
			if (_a.Score > _b.Score)
			{
				return -1;
			}
			else if (_a.Score < _b.Score)
			{
				return 1;
			}

			return 0;
		});
		local tilesUsed = [];
		local idx = 0;

		for( local i = 0; i < 2; i = ++i )
		{
			for( local j = idx; j < candidates.len(); j = ++j )
			{
				idx = j;
				local next = false;

				foreach( t in tilesUsed )
				{
					if (t.getDistanceTo(candidates[idx].Tile) <= 12)
					{
						next = true;
						break;
					}
				}

				if (next)
				{
				}
				else
				{
					next = true;

					foreach( s in settlements )
					{
						if (s.isIsolated() || s.getTile().SquareCoords.Y > this.World.getMapSize().Y * 0.5)
						{
							continue;
						}

						local navSettings = this.World.getNavigator().createSettings();
						navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
						local path = this.World.getNavigator().findPath(candidates[idx].Tile, s.getTile(), navSettings, 0);

						if (!path.isEmpty())
						{
							next = false;
							break;
						}
					}

					if (!next)
					{
						break;
					}
				}
			}

			if (idx >= candidates.len())
			{
				break;
			}

			local camp = this.World.spawnLocation("scripts/entity/world/locations/abandoned_fortress_location", candidates[idx].Tile.Coords);
			tilesUsed.push(candidates[idx].Tile);
			camp.onSpawned();
		}
	}

	function getRect( _rect, _x, _y, _width, _height )
	{
		return {
			X = _rect.W * _x,
			Y = _rect.H * _y,
			W = _rect.W * (_width - _x),
			H = _rect.H * (_height - _y)
		};
	}

	function fillWithTile( _x, _y, _type, _template, _baseChance, _vicinityChance, _xChance = 0.0, _yChance = 0.0, _inVicinityOnly = false )
	{
		local tile = this.World.getTileSquare(_x, _y);
		local n = 0;

		for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
		{
			if (tile.hasNextTile(i) && tile.getNextTile(i).Type == _type)
			{
				n = ++n;
			}
		}

		if (_inVicinityOnly && n == 0)
		{
			return;
		}

		if (this.Math.rand(0, 100) > _baseChance - n * _vicinityChance - _xChance * _x - _yChance * _y)
		{
			tile.Type = 0;
			_template.fill({
				X = _x,
				Y = _y,
				W = 1,
				H = 1,
				IsEmpty = true
			}, null);
		}
	}

	function onTileInRegionQueried( _tile, _region )
	{
		++_region[_tile.Type];
	}

	function getTerrainInRegion( _tile )
	{
		local terrain = {
			Local = _tile.Type,
			Adjacent = [],
			Region = []
		};
		terrain.Adjacent.resize(this.Const.World.TerrainType.COUNT, 0);
		terrain.Region.resize(this.Const.World.TerrainType.COUNT, 0);

		for( local i = 0; i < 6; i = ++i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else
			{
				++terrain.Adjacent[_tile.getNextTile(i).Type];
			}
		}

		this.World.queryTilesInRange(_tile, 1, 4, this.onTileInRegionQueried.bindenv(this), terrain.Region);
		return terrain;
	}

});
