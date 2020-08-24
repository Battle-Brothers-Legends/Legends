this.paymaster_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.paymaster";
		this.m.Name = "The Paymaster";
		this.m.Description = "The Paymaster takes care of all the day-to-day financial and organizational aspects of running a mercenary company, like paying out wages.";
		this.m.Image = "ui/campfire/paymaster_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Reduces the daily wage of each man by 15%",
			"Reduces the chance of desertion by 50%",
			"Prevents men demanding more pay in events"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function isVisible()
	{
		return this.World.Assets.getBrothersMax() >= 16;
	}

	function onUpdate()
	{
		this.World.Assets.m.DailyWageMult *= 0.85;
	}

	function onEvaluate()
	{
		this.m.Requirements[0].Text = "Have a roster of " + this.Math.min(16, this.World.getPlayerRoster().getSize()) + "/16 men";

		if (this.World.getPlayerRoster().getSize() >= 16)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

});

