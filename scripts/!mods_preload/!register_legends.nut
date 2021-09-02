::mods_registerMod("mod_legends", 15, "Legends Mod");
::mods_queue(null, "mod_MSU", function()
{
	::mods_registerJS("legends_assets.js");
	this.Const.LegendMod.hookActor();
	this.Const.LegendMod.hookAISkills();
	this.Const.LegendMod.hookAIAgent();
	this.Const.LegendMod.hookAISplitShield();
	this.Const.LegendMod.hookAlpRacial();
	this.Const.LegendMod.hookBehavior();
	this.Const.LegendMod.hookCombatManager();
	this.Const.LegendMod.hookContract();
	this.Const.LegendMod.hookFactionAction();
	this.Const.LegendMod.hookItemContainer();
	this.Const.LegendMod.hookStrategy();
	this.Const.LegendMod.hookTacticalEntityManager();
	this.Const.LegendMod.hookTacticalState();
	this.Const.LegendMod.hookWorldmapGenerator();
	this.Const.LegendMod.hookGhoul();

	this.Const.LegendMod.hookMSU();

	this.Const.LegendMod.loadBuyback();
	this.Const.LegendMod.loadTacticalTooltip();
});