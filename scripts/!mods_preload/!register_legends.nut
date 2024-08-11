
::Legends <- {
    ID = "mod_legends",
    Version = "18.2.7",
    Name = "Legends Mod",
    BuildName = "Chickens & Demons"
};

this.logInfo("Starting register_legends.nut");

this.logInfo("FU namespace type: " + typeof ::FU);
this.logInfo("FU.Class type: " + typeof ::FU.Class);
this.logInfo("FU.Mod exists: " + ("Mod" in ::FU));

this.logInfo("including mod_settings in register_legends");
::include("scripts/tools/mod_settings"); 

this.logInfo("FU namespace type: " + typeof ::FU);
this.logInfo("FU.Class type: " + typeof ::FU.Class);
this.logInfo("FU.Mod exists: " + ("Mod" in ::FU));



 ::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);

::mods_queue(::Legends.ID, "mod_fu(>=1.0.0), vanilla(>=1.5.0-13), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function()
{


 this.logInfo("Starting mods_queue for Legends");

    if (!("FU" in getroottable()))
    {
        this.logError("FU not found in root table. Make sure FU is loaded before Legends.");
        return;
    }
    else
    {
    this.logInfo("FU found in root table");
    this.logInfo("FU contents: " + ::FU);
    }
    if (!("Class" in ::FU))
    {
        this.logError("FU.Class not found. Make sure FU is properly initialized.");
    
    }
    else
    {
    this.logInfo("FU.Class found");
    this.logInfo("FU.Class contents:");
	    foreach (key, value in ::FU.Class)
	    {
		this.logInfo("  " + key + ": " + value);
	    } 
    }

   // this.logInfo("FU.Mod is an instance: " + (typeof ::FU.Mod == "instance"));
   //  returns the index Mod does not exist 

    if (!("Mod" in ::FU.Class))
    {
       this.logError("FU.Class.Mod not found. Make sure FU is properly initialized.");
        return;
    }
    else
    {
        this.logInfo("FU.Class.Mod is a class, creating Legends.Mod instance");
        ::Legends.Mod <- ::FU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);
        this.logInfo("Legends.Mod created: " + (::Legends.Mod != null));
    }

	this.logInfo("FU.Class.Mod is a class: " + (typeof ::FU.Class.Mod == "class"));
	this.logInfo("FU.Mod is an instance: " + (typeof ::FU.Mod == "instance"));

    // TODO maybe these are just in z_world config?
    // Merge LegendsMod and configs directly to Legends.Mod
    //::Legends.Mod.Configs <- {
    //   function LegendMagicEnabled()
    //    {
    //        return false;
    //    },
    //    function LegendTherianthropyEnabled()
    //    {
    //        return false;
    //    }
    //};

    ::Legends.Mod.ModSettings = ::FU.Class.ModSettings(::Legends.Mod);
    
    // Register JS and CSS files
    ::mods_registerJS("legends_assets.js");
    ::mods_registerJS("legends/hooks/character_screen.js");
    ::mods_registerCSS("legends/hooks/character_screen.css");

    // Setup and initialize mod components
    ::Const.LegendMod.setupDebug();
    ::Const.LegendMod.addSettings();
    // TODO No hooks for you
    // ::Const.LegendMod.hookFU();
    //::Const.LegendMod.addLegendItemTypes();
    //::Const.LegendMod.addStaticFunctions();

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
    
    //TODO make em pretty
    //::Const.LegendMod.addTooltips();

    // Add mod to the DataManager (if using FU)
    if ("FU" in this.getroottable() && "DataManager" in ::FU)
        ::FU.DataManager.registerMod(::Legends.Mod);

  
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

