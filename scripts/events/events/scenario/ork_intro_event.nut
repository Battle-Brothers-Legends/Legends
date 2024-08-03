this.ork_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ork_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_94.png[/img]{ Ork smash!! \n\n You haz %ork1%, %ork2%, %ork3% and %ork4% theyz iz runts but they like ta fight \n\n Better get fightin den.%SPEECH_ON%WWWWWAAAAAAAGH!!%SPEECH_OFF%%ork3% Time to bring back a bit of the biff.}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We\'z the best.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "Me and da boyz";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"ork1",
			brothers[0].getName()
		]);
		_vars.push([
			"ork2",
			brothers[1].getName()
		]);
		_vars.push([
			"ork3",
			this.Const.Strings.GobblinNames[this.Math.rand(0, this.Const.Strings.OrkNames.len() - 1)]
		]);
		_vars.push([
			"ork4",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});

