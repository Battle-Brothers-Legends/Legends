this.lookout_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.lookout";
		this.m.Name = "The Lookout";
		this.m.Description = "Having a quick Lookout with sharp eyes travel in advance of the company can prove invaluable in being aware of dangers and points of interests before others become aware of the company.";
		this.m.Image = "ui/campfire/lookout_01";
		this.m.Cost = 2500;
		this.m.Effects = [
			"Increases your sight radius by 25%",
			"Reveals extended information about footprints"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function onUpdate()
	{
		this.World.Assets.m.VisionRadiusMult = 1.25;
		this.World.Assets.m.IsShowingExtendedFootprints = true;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Discovered " + this.Math.min(10, this.World.Statistics.getFlags().getAsInt("LocationsDiscovered")) + "/10 locations on your own";

		if (this.World.Statistics.getFlags().getAsInt("LocationsDiscovered") >= 10)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

