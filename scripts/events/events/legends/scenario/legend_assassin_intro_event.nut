this.legend_assassin_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_assassin_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
	   		Text = "[img]gfx/ui/events/event_51.png[/img]Focus. Focus on the task. You are a sharpened blade, honed to perfection for a single task. Ending lives. Years of training, years of practice. Your previous life has been wiped from reality, broken down and rebuilt as an efficient tool. The rules are clear, be invisible, be silent, be quick, leave no trace.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Onwards!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.logInfo("Unlocking training");
				this.World.Flags.set("HasLegendCampTraining", true);
				this.logInfo("Unlocking scouting");
				this.World.Flags.set("HasLegendCampScouting", true);
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Legendary Assassin";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});