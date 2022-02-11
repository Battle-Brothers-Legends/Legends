::mods_registerMod("mod_legends", 15, "Legends Mod");
::mods_queue(null, "mod_MSU", function()
{
	::mods_registerJS("legends_assets.js");
	this.Const.LegendMod.addLegendItemTypes();
	this.Const.LegendMod.hookActor();
	this.Const.LegendMod.hookAISkills();
	this.Const.LegendMod.hookAIAgent();
	this.Const.LegendMod.hookAISplitShield();
	this.Const.LegendMod.hookAlpRacial();
	this.Const.LegendMod.hookBehavior();
	this.Const.LegendMod.hookCharacterBackground();
	this.Const.LegendMod.hookCombatManager();
	this.Const.LegendMod.hookContract();
	this.Const.LegendMod.hookFactionAction();
	this.Const.LegendMod.hookGhoul();
	this.Const.LegendMod.hookItemContainer();
	this.Const.LegendMod.hookStrategy();
	this.Const.LegendMod.hookTacticalEntityManager();
	this.Const.LegendMod.hookTacticalState();
	this.Const.LegendMod.hookWorldmapGenerator();	

	this.Const.LegendMod.hookMSU();

	this.Const.LegendMod.loadBuyback();
	this.Const.LegendMod.loadTacticalTooltip();

	if (!this.Const.DLC.Lindwurm)
	{
		this.logError("Legends Error - DLC Missing: Lindwurm");
	}

	if (!this.Const.DLC.Unhold)
	{
		this.logError("Legends Error - DLC Missing: Beasts and Exploration");
	}

	if (!this.Const.DLC.Wildmen)
	{
		this.logError("Legends Error - DLC Missing: Warriors of the North");
	}

	if (!this.Const.DLC.Desert)
	{
		this.logError("Legends Error - DLC Missing: Blazing Deserts");
	}
});