this.logInfo("Starting register_legends.nut");
::Legends <- {
    ID = "mod_legends",
    Version = "18.2.7",
    Name = "Legends Mod",
    BuildName = "Chickens & Demons"
};

this.logInfo("Starting register_legends.nut");

// Check if we're using FU and register the mod accordingly
//if (!("FU" in this.getroottable()) || SemVer.compare(SemVer.getTable(::FU.Version), SemVer.getTable("1.3.0")) >= 0 && !("Hooks" in this.getroottable()))
//    ::mods_registerMod(::Legends.ID, 18, ::Legends.Name);
//else
    ::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);

::mods_queue(::Legends.ID, "mod_fu(>=1.0.0), vanilla(>=1.5.0-13), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function()
{


 this.logInfo("Starting mods_queue for Legends");

    if (!("FU" in getroottable()))
    {
        this.logError("FU not found in root table. Make sure FU is loaded before Legends.");
        return;
    }

    this.logInfo("FU found in root table");
    this.logInfo("FU contents: " + ::FU);

    if (!("Class" in ::FU))
    {
        this.logError("FU.Class not found. Make sure FU is properly initialized.");
    
    }

    this.logInfo("FU.Class found");
    this.logInfo("FU.Class contents:");
    foreach (key, value in ::FU.Class)
    {
        this.logInfo("  " + key + ": " + value);
    }

    if (!("Mod" in ::FU.Class))
    {
        this.logError("FU.Class.Mod not found. Make sure FU is properly initialized.");
     
    }

    this.logInfo("FU.Class.Mod found");

    ::Legends.Mod <- ::FU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);
    this.logInfo("Legends.Mod created: " + (::Legends.Mod != null));


    // Register JS and CSS files
    ::mods_registerJS("legends_assets.js");
    ::mods_registerJS("legends/hooks/character_screen.js");
    ::mods_registerCSS("legends/hooks/character_screen.css");

    // Create LegendsMod instance
    ::LegendsMod <- this.new("scripts/!mods_preload/mod_legends");

    // Add Configs directly to Legends.Mod ( may want to move this to legends_mod.nut)
    ::Legends.Mod.Configs <- {
        function LegendMagicEnabled()
        {
            return false;
        },
        function LegendTherianthropyEnabled()
        {
            return false;
        }
    };

    // Setup and initialize mod components
    ::Const.LegendMod.setupDebug();
    ::Const.LegendMod.addSettings();
    ::Const.LegendMod.hookFU();
    ::Const.LegendMod.addLegendItemTypes();
    ::Const.LegendMod.addStaticFunctions();

    // Hook into various game systems
    local hookFunctions = [
        "hookActor", "hookAISkills", "hookAIAgent", "hookAISplitShield",
        "hookAlpRacial", "hookBehavior", "hookCharacterBackground",
        "hookCombatManager", "hookContract", "hookContractCategory",
        "hookFactionAction", "hookGhoul", "hookItemContainer",
        "hookStrategy", "hookTacticalEntityManager", "hookTacticalState",
        "hookWorldmapGenerator"
    ];

    foreach (hookFunction in hookFunctions)
    {
        ::Const.LegendMod[hookFunction]();
    }

    // Register UI, load components, and add tooltips
    ::Const.LegendMod.registerUI();
    ::Const.LegendMod.loadBuyback();
    ::Const.Perks.updatePerkGroupTooltips();
    ::Const.LegendMod.addTooltips();

    // Add mod to the DataManager (if using FU)
    if ("FU" in this.getroottable() && "DataManager" in ::FU)
        ::FU.DataManager.registerMod(::Legends.Mod);

    // Debug log to confirm initialization
    this.logInfo("Legends.Mod initialized: " + (::Legends.Mod != null) + ", Configs available: " + (::Legends.Mod.Configs != null));
});
this.logInfo("Finished mods_queue for Legends");
    if ("Mod" in ::Legends)
    {
        this.logInfo("Legends.Mod exists at end of register_legends: " + (::Legends.Mod != null));
    }
    else
    {
        this.logError("Legends.Mod does not exist at end of register_legends");
    }





this.logInfo("register_legends.nut file processed");

