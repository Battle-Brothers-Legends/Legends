// Initialize the FU (Functional Utilities) namespace
::FU <- {
    Version = "1.2.7",
    ID = "mod_fu",
    Name = "Functional Utilities (FU)",
    VanillaID = "vanilla",
    Class = {},
    BBClass = {
        Empty = "scripts/mods/FU/empty_bb_class"
    }
};

// Function to include the load file for a mod
::FU.includeLoad <- function( _prefix, _folder )
{
	::include(_prefix + _folder + "/load.nut");
}
// Function to include a specific file for a mod
::FU.includeFile <- function( _prefix, _file )
{
	::include(_prefix + _file);
}
// Function to include a set of files
::FU.includeFiles <- function( _files, _includeLoad = false )
{
	foreach (file in _files)
	{
		if (_includeLoad || split(file, "/").pop() != "load.nut")
		{
			::include(file);
		}
	}
}
// 
// This is to help Enduriel's mods
::includeLoad <- function( _prefix, _folder )
{
	::FU.includeLoad(_prefix, _folder);
}
::includeFile <- function( _prefix, _file )
{
	::FU.includeFile(_prefix, _file);	
}
::includeFiles <- function( _files, _includeLoad = false )
{
	::FU.includeFiles(_files, _includeLoad);	
}


// Helper function to include all files in a directory
::FU.includeAllInDir <- function(_dir)
{
    local files = ::IO.enumerateFiles(_dir);
    foreach (file in files)
    {
        ::include(file);
         this.logInfo("Included file: " + file);
    }
}
::FU.includeFiles(::IO.enumerateFiles("scripts/tools"));
::FU.includeFiles(::IO.enumerateFiles("scripts/tools/settings"));
// Include all utility files
//::FU.includeAllInDir("scripts/tools");


// Include necessary files explicitly
//::include("scripts/tools/!system_template");
//::include("scripts/tools/functional_utilities");
//::include("scripts/tools/semantic_versioning");
//::include("scripts/tools/mod_settings"); 
//::include("scripts/tools/setting_sorter");
//::include("scripts/tools/math_utilities");
//::include("scripts/tools/data_utilities");
//::include("scripts/tools/readwrite_utilities");
//::include("scripts/tools/log_utilities");


this.logInfo("FU namespace initialized");
this.logInfo("FU.Class contents: " + ::FU.Class);

// Include all UI utility files
//::FU.includeAllInDir("ui/utilities");

// Create and register the FU mod
if ("Mod" in ::FU.Class) {
    this.logInfo("FU.Class.Mod contents before FU mod registration:");
    foreach (key, value in ::FU.Class.Mod)
    {
        this.logInfo("  " + key + ": " + value);
    } 
    
    this.logInfo("Creating FU Mod instance...");
    ::FU.Mod <- ::FU.Class.Mod(::FU.ID, ::FU.Version, ::FU.Name);
    this.logInfo("FU.Mod contents:");
	this.logInfo("FU.Mod ID: " + ::FU.Mod.getID());
	this.logInfo("FU.Mod Version: " + ::FU.Mod.getVersionString());
	this.logInfo("FU.Mod Name: " + ::FU.Mod.getName());


    // Register the FU mod
    this.logInfo("Registering FU Mod...");
    ::mods_registerMod(::FU.Mod.getID(), ::FU.Mod.getVersionString(), ::FU.Mod.getName());
    
    this.logInfo("FU.Class.Mod contents after FU mod registration:");
    foreach (key, value in ::FU.Class.Mod)
    {
        this.logInfo("  " + key + ": " + value);
    } 
} else {
    this.logError("FU.Class.Mod not found. Cannot create FU Mod instance.");
}

this.logInfo("FU.Class.Mod is a class: " + (typeof ::FU.Class.Mod == "class"));
this.logInfo("FU.Mod is an instance: " + (typeof ::FU.Mod == "instance"));


// Register the vanilla game as a "mod"
//::mods_registerMod(::FU.VanillaID, ::FU.Class.SemVer.formatVanillaVersion(::GameInfo.getVersionNumber()), "Vanilla");
//this.logInfo("Registering vanilla Mod...");

// Queue the FU mod for loading
//::mods_queue(::FU.Class.Mod.getID(), "vanilla(>=1.5.0-13)", function()
//{
//    ::FU.Class.DataManager.registerMod(::FU.Class.Mod);
//    ::FU.includeAllInDir("FU");
//});

// Hook into the main menu module
//::mods_hookExactClass("ui/screens/menu/modules/main_menu_module", function(o)
//{
//    local create = o.create;
//    o.create <- function()
//    {
//        create();
//        ::FU.Class.Popup.quitGame = o.onQuitButtonPressed.bindenv(this);
//    }
//    o.connectBackend <- function()
//    {
//        ::FU.Popup.connect();
//       if ("UI" in ::FU)
//        {
//            ::FU.UI.connect();
//        }
//    }
//});

// Include mod hooks
//::include("FU/squirrel_hooks/mod_hooks");


// Register DLCs as mods if they are present
if (::Const.DLC.Lindwurm) ::mods_registerMod("dlc_lindwurm", 1, "Lindwurm");
if (::Const.DLC.Unhold) ::mods_registerMod("dlc_unhold", 1, "Beasts & Exploration");
if (::Const.DLC.Wildmen) ::mods_registerMod("dlc_wildmen", 1, "Warriors of the North");
if (::Const.DLC.Desert) ::mods_registerMod("dlc_desert", 1, "Blazing Deserts");
if (::Const.DLC.Paladins) ::mods_registerMod("dlc_paladins", 1, "Of Flesh and Faith");


// Empty BB class for compatibility
this.empty_bb_class <- { m = {} }


this.logInfo("FU Mod registered");

