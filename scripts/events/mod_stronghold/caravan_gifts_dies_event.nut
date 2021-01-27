this.caravan_gifts__dies_event <- this.inherit("scripts/events/event", {
	//not used right now, need way to call it
	m = {
		Destination = null,
		Reputation = 0

	},
	function create()
	{
		this.m.ID = "event.caravan_gifts_dies";
		this.m.Title = "Meanwhile...";
		this.m.Cooldown = 9999 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]Your caravan bearing gifts has been destroyed.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That is terrible.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

