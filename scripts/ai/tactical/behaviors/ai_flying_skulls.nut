this.ai_flying_skulls <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		IsSpent = false,
		Tiles = [],
		Skulls = 0,
		Skill = null,
		PossibleSkills = [
			"actives.flying_skulls"
		],
		WaitUntil = 0.0
	},
	function create()
	{
		this.m.ID = this.Const.AI.Behavior.ID.FlyingSkulls;
		this.m.Order = this.Const.AI.Behavior.Order.FlyingSkulls;
		this.m.IsThreaded = true;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		// Function is a generator.
		this.m.Tiles = [];
		this.m.Skill = null;
		this.m.WaitUntil = 0.0;
		local scoreMult = this.getProperties().BehaviorMult[this.m.ID];
		local time = this.Time.getExactTime();

		if (this.m.IsSpent)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = this.selectSkill(this.m.PossibleSkills);

		if (this.m.Skill == null)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local entities = this.Tactical.Entities.getInstancesOfFaction(_entity.getFaction());
		local phylacteries = 0;
		local skulls = 0;

		foreach( e in entities )
		{
			if (e.getType() == this.Const.EntityType.FlyingSkull)
			{
				skulls = ++skulls;
			}
			else if (e.getType() == this.Const.EntityType.SkeletonPhylactery)
			{
				phylacteries = ++phylacteries;
			}
		}

		phylacteries = this.Math.max(0, phylacteries - this.Time.getRound() / 9);

		if (skulls >= 12 + this.Math.max(0, 9 - phylacteries) * 2)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Skulls = this.Math.min(12, this.Math.min(4 + this.Math.max(0, 9 - phylacteries), 12 + this.Math.max(0, 9 - phylacteries) * 2 - skulls));
		local myTile = _entity.getTile();
		local tiles = [];
		local mapSize = this.Tactical.getMapSize();

		for( local x = 1; x < mapSize.X - 1; x = ++x )
		{
			for( local y = 1; y < mapSize.Y - 1; y = ++y )
			{
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					tiles.push({
						Tile = tile,
						Score = 0.0
					});
				}
			}
		}

		if (tiles.len() == 0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		local opponents = this.getAgent().getKnownOpponents();

		foreach( t in tiles )
		{
			local tile = t.Tile;
			local score = 0.0;

			if (this.isAllottedTimeReached(time))
			{
				yield null;
				time = this.Time.getExactTime();
			}

			local farthest = 9000;

			foreach( target in opponents )
			{
				local targetTile = target.Actor.getTile();
				local d = t.Tile.getDistanceTo(targetTile);

				if (d <= 4)
				{
					score = score - 10.0;
				}

				if (d < farthest)
				{
					farthest = d;
				}
			}

			if (farthest > 6)
			{
				score = score - farthest;
			}

			t.Score = score;
		}

		tiles.sort(this.onSortByScore);

		if (tiles[0].Score <= -10.0)
		{
			return this.Const.AI.Behavior.Score.Zero;
		}

		this.m.Tiles = tiles;
		return this.Const.AI.Behavior.Score.MirrorImage * scoreMult;
	}

	function onTurnStarted()
	{
		this.m.IsSpent = false;
	}

	function onExecute( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			this.getAgent().adjustCameraToDestination(this.m.Tiles[0].Tile);
			this.m.IsFirstExecuted = false;
			this.m.Skill.use(_entity.getTile());
			this.m.WaitUntil = this.Time.getRealTimeF() + 1.5;
			return false;
		}
		else if (this.Time.getRealTimeF() >= this.m.WaitUntil)
		{
			local max_skulls = this.m.Skulls;

			for( local i = 0; i < this.m.Tiles.len(); i = ++i )
			{
				local tile = this.m.Tiles[0].Tile;
				this.m.Tiles.remove(0);
				local skull = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/flying_skull", tile.Coords.X, tile.Coords.Y);
				skull.setFaction(_entity.getFaction());
				skull.spawnEffect();
				max_skulls = --max_skulls;

				if (max_skulls <= 0)
				{
					break;
				}
			}

			this.m.Tiles = [];
			this.m.IsSpent = true;
			this.getAgent().declareEvaluationDelay(1000);
			return true;
		}
	}

	function onSortByScore( _a, _b )
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
	}

});

