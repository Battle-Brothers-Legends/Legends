this.mage_legend_mage_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.legend_seer_scenario_intro";
		this.m.IsSpecial = true;
	}

	function onUpdateScore()
	{
		return;
	}

	function onClear()
	{
	}
    // An empty file doesn't cut it for events. It will break the game. That's why I put some basic function in here until we deleted this file
});