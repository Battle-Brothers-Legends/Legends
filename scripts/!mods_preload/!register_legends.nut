::Legends <- {
    ID = "mod_legends",
    Version = "18.2.7",
    Name = "Legends Mod",
    BuildName = "Chickens & Demons"
};

// Initialize the necessary global tables
if (!("FU" in getroottable())) ::FU <- {};


// Create the Legends mod instance
local legendsMod = ::FU.Mod("mod_legends", "18.2.7", "Legends Mod");
legendsMod.BuildName = "Chickens & Demons";

// Register the mod with the mods system
::mods_registerMod(legendsMod.getID(), 18, legendsMod.getName());

// Queue the mod for loading
::mods_queue(legendsMod.getID(), "vanilla(>=1.5.0-15), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins", function()
{
    // Register JS and CSS files
    ::mods_registerJS("legends_assets.js");
    ::mods_registerJS("legends/hooks/character_screen.js");
    ::mods_registerCSS("legends/hooks/character_screen.css");

    // Initialize the LegendsMod object
    ::LegendsMod <- {
        m = {
            Configs = null
        },
        function create()
        {
            this.m.Configs = this.new("scripts/mods/legends_configs");
        },
        function Configs() 
        {
            return this.m.Configs;
        },
        function onDevConsole(_command, _args)
        {
            switch(_command)
            {
                case "event":
                    this.doDevConsoleEvent(_args);
                    break;
            }
        },
        function doDevConsoleEvent(_args)
        {
            if (!this.World.Events.canFireEvent())
            {
                this.logInfo("Can not fire event " + _args +" at this time");
                return;
            }
            this.World.Events.fire(_args);
        }
    };

    ::LegendsMod.create();

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
        this.Const.LegendMod[hookFunction]();
    }

    // Register UI, load components, and add tooltips
    ::Const.LegendMod.registerUI();
    this.Const.LegendMod.loadBuyback();
    this.Const.Perks.updatePerkGroupTooltips();
    ::Const.LegendMod.addTooltips();

    // Add mod to the DataManager
    ::FU.DataManager.registerMod(legendsMod);
});

// Ensure backward compatibility
if (!("MSU" in getroottable())) ::MSU <- {};
::MSU.Class <- ::FU.Class;
::MSU.System <- ::FU.System

