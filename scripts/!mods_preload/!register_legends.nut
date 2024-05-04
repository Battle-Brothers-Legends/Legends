::Legends <- {
	ID = "mod_legends",
	Version = "18.2.6",
	Name = "Legends Mod",
	BuildName = "Chickens & Demons"
};
::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);
::mods_queue(null, "mod_msu(>=1.2.6), vanilla(>=1.5.0-15), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function()
{
	::Legends.Mod <- ::MSU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);

	::mods_registerJS("legends_assets.js");
	::LegendsMod <- this.new("scripts/mods/legends_mod")
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-Bugs");
    ::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

    ::Const.LegendMod.setupDebug(); // must be called before ::Const.LegendMod.addSettings();
	::Const.LegendMod.addSettings();
	::Const.LegendMod.hookMSU();
	::Const.LegendMod.addLegendItemTypes();
	::Const.LegendMod.addStaticFunctions();

	this.Const.LegendMod.hookActor();
	this.Const.LegendMod.hookAISkills();
	this.Const.LegendMod.hookAIAgent();
	this.Const.LegendMod.hookAISplitShield();
	this.Const.LegendMod.hookAlpRacial();
	this.Const.LegendMod.hookBehavior();
	this.Const.LegendMod.hookCharacterBackground();
	this.Const.LegendMod.hookCombatManager();
	this.Const.LegendMod.hookContract();
	this.Const.LegendMod.hookContractCategory();
	this.Const.LegendMod.hookFactionAction();
	this.Const.LegendMod.hookGhoul();
	this.Const.LegendMod.hookItemContainer();
	this.Const.LegendMod.hookStrategy();
	this.Const.LegendMod.hookTacticalEntityManager();
	this.Const.LegendMod.hookTacticalState();
	this.Const.LegendMod.hookWorldmapGenerator();

	::Const.LegendMod.registerUI();

	this.Const.LegendMod.loadBuyback();
	this.Const.LegendMod.loadTacticalTooltip();
	this.Const.Perks.updatePerkGroupTooltips();

	::Const.LegendMod.addTooltips();
	
});
