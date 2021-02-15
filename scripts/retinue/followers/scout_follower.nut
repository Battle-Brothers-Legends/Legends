this.scout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scout";
		this.m.Name = "The Guide";
		this.m.Description = "The Guide is an expert in finding mountain passes, navigating through treacherous swamps, and guiding anyone safely through the darkest of forests."
		this.m.Image = "ui/campfire/scout_01";
		this.m.Cost = 1250;
		this.m.Effects = [
			"Reduces the movement penalty of difficult terrain by 15%",
			"Prevents sickness and accidents due to terrain"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have at least one of the following backgrounds: Wildman/Wildwoman, Hunter, Lumberjack, Ranger"
			}
		];
	}

	function onUpdate()
	{
		for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = ++i )
		{
			if (this.Const.World.TerrainTypeSpeedMult[i] <= 0.65 && this.Const.World.TerrainTypeSpeedMult[i] > 0.0)
			{
				this.World.Assets.m.TerrainTypeSpeedMult[i] *= (this.Const.World.TerrainTypeSpeedMult[i] + 0.15) / this.Const.World.TerrainTypeSpeedMult[i];
			}
		}
	}

	function onEvaluate()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		local availableBGs = [
			"background.wildman",
			"background.wildwoman",
			"background.hunter",
			"background.lumberjack",
			"background.legend_ranger",
			"background.legend_commander_ranger"
		];

		foreach( bro in brothers )
		{
			local id = bro.getBackground().getID();

			if (availableBGs.find(id) != null)
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}
	}

});

