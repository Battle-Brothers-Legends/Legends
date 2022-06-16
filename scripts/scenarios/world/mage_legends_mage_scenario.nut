this.mage_legends_mage_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
	}

	function isValid()
	{
		return false;
	}
    // An empty file doesn't cut it for origins. It will break the game. That's why I put some basic function in here until we deleted this file
});