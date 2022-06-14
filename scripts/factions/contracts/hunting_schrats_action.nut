this.hunting_schrats_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "hunting_schrats_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (this.Math.rand(1, 100) > 20)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (!this.isKindOf(village, "small_lumber_village") && !this.isKindOf(village, "medium_lumber_village") && !this.isKindOf(village, "large_lumber_village"))
		{
			return;
		}

		local mapSize = this.World.getMapSize();
		local villageTile = village.getTile();
		local x = this.Math.max(3, villageTile.SquareCoords.X - 11);
		local x_max = this.Math.min(mapSize.X - 3, villageTile.SquareCoords.X + 11);
		local y = this.Math.max(3, villageTile.SquareCoords.Y - 11);
		local y_max = this.Math.min(mapSize.Y - 3, villageTile.SquareCoords.Y + 11);
		local numWoods = 0;

		while (x <= x_max)
		{
			while (y <= y_max)
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Forest || tile.Type == this.Const.World.TerrainType.LeaveForest || tile.Type == this.Const.World.TerrainType.AutumnForest)
				{
					numWoods = ++numWoods;
				}

				y = ++y;
			}

			x = ++x;
		}

		if (numWoods == 0)
		{
			return;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/hunting_schrats_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

