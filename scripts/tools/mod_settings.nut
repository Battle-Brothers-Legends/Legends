::FU.Class.System <- class
{
	ID = null;
	constructor( _id, _dependencies = null )
	{
		if (_dependencies == null) _dependencies = [];

		foreach (dependency in _dependencies)
		{
			local found = false;
			foreach (system in ::FU.System)
			{
				if (dependency == system.getID())
				{
					found = true;
					break;
				}
			}
			if (!found)
			{
				throw "Dependencies not yet initialized";
			}
		}
		this.ID = _id;
	}

	function getID()
	{
		return this.ID;
	}

	function registerMod( _mod )
	{
		if (typeof _mod != "instance" || !(_mod instanceof ::FU.Class.Mod))
		{
			throw ::FU.Exception.InvalidType(_mod);
		}
	}
}
/**
 * Mod Class
 * 
 * This class is the core unit representing each mod
 * It encapsulating all the data and functionality specific to a single mod.
 * 
 * Key features:
 * - Stores basic mod information (ID, Name, Version)
 * - Handles semantic versioning (Version, PreRelease, Metadata)
 * - Integrates with various subsystems (Debug, Keybinds, ModSettings, etc.)
 * 
 * Note: This class serves as the bridge between the mod and the FU modding infrastructure.
 * Changes here may require corresponding updates in the JavaScript frontend, 
 * especially for properties that are displayed or manipulated in the UI.
 */

::FU.Class.Mod <- class
{
    ID = null;
    Name = null;
    Version = null;
    PreRelease = null;
    Metadata = null;

    // Systems
    Debug = null;
    Keybinds = null;
    ModSettings = null;
    Registry = null;
    DataManager = null;
    TooltipManager = null;

    /**
     * Constructor for the Mod class.
     * 
     * This method sets up a new mod instance. 
     * 1. It parses the version string into components (Version, PreRelease, Metadata).
     * 2. It registers the mod with multiple subsystems.
     * 
     * The registration process is crucial as it integrates the mod with various
     * parts of the modding system (settings, keybinds, etc.). Each of these
     * registrations may trigger actions in both the backend and frontend.
     * 
     * @param _id Unique identifier for the mod
     * @param _version Version string following semantic versioning
     * @param _name Display name of the mod (defaults to _id if not provided)
     */
    constructor(_id, _version, _name = null) {
        if (_name == null) _name = _id;
      //  requireString(_id, _version, _name);

        this.ID = _id;
        this.Name = _name;

        local versionTable = ::FU.Class.SemVer.getTable(_version);
        this.Version = versionTable.Version;
        this.PreRelease = versionTable.PreRelease;
        this.Metadata = versionTable.Metadata;

        // Register the mod with various systems
        ::FU.Class.RegistrySystem.registerMod(this);
        ::FU.Class.DebugSystem.registerMod(this);
        ::FU.Class.ModSettingsSystem.registerMod(this);
        this.logInfo("About to register mod with KeybindsSystem");
        ::FU.Class.KeybindsSystem.registerMod(this);
         this.logInfo("Mod registered with KeybindsSystem");
        ::FU.Class.DataManager.registerMod(this);
        //::FU.Class.TooltipManager.registerMod(this);

    }

    /**
     * Gets the display name of the mod.
     * @returns {string} - The display name of the mod.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the unique identifier of the mod.
     * @returns {string} - The unique identifier of the mod.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the short version string of the mod.
     * @returns {string} - The short version string of the mod.
     */
    function getShortVersionString() {
        return ::FU.Class.SemVer.getShortVersionString(this);
    }

    /**
     * Gets the full version string of the mod.
     * @returns {string} - The full version string of the mod.
     */
    function getVersionString() {
        return ::FU.Class.SemVer.getVersionString(this);
    }

    /**
     * Converts the mod information to a string.
     * @returns {string} - The string representation of the mod.
     */
    function tostring() {
        return format("Mod %s, Version %s\n", this.getID(), this.getVersionString());
    }

    function _tostring() {
        return this.tostring();
    }
}

//unit test for mod system
function testModClass() {
    local mod = Mod("TestMod", "1.0.0", "Test Mod");

    assert(mod.getID() == "TestMod");
    assert(mod.getName() == "Test Mod");
    assert(mod.getShortVersionString() == "1.0.0");
    assert(mod.getVersionString() == "1.0.0");
    assert(mod.tostring() == "Mod TestMod, Version 1.0.0\n");

    print("Mod class tests passed.");
}

// Run the test
//testModClass();




::FU.Class.ModSettingsSystem <- class extends ::FU.Class.System
{
	Screens = {};
	Locked = null;
    
    /**
     * Constructor for the ModSettingsSystem class.
     */	
	constructor()
	{
		this.logInfo("ModSettingsSystem constructor called");
 		this.logInfo("Initial Screens type: " + typeof this.Screens);
		this.constructor(::FU.SystemID.ModSettings);
    		this.logInfo("Screens type after constructor: " + typeof this.Screens);
		this.Locked = false;

 		this.logInfo("OrderedMap type: " + typeof ::FU.Class.OrderedMap);
 		this.logInfo("OrderedMap contents: " + ::FU.Class.OrderedMap);
      		this.Screens = {};  // Changed to a simple table instead of OrderedMap
      		this.logInfo("Screens initialized: " + (this.Screens != null));
	}
    /**
     * Registers a mod with the mod settings system.
     * @param _mod {Mod} - The mod to register.
     */
	function registerMod( _mod )
	{		
		 this.logInfo("Screens type at start of registerMod: " + typeof this.Screens);
		this.logInfo("ModSettingsSystem mod registeration for Name " + _mod.getName() + " begun")
		this.logInfo("ModSettingsSystem mod registeration for  ID " + _mod.getID() + " begun")

	   	 this.logInfo("SettingsScreen class: " + ::FU.Class.SettingsScreen);


		_mod.ModSettings = ::FU.Class.ModSettingsModAddon(_mod);
		this.logInfo("SettingsScreen class: " + ::FU.Class.SettingsScreen);
		local screen = ::FU.Class.SettingsScreen(_mod.getID(), _mod.getName());
		this.logInfo("Created screen instance: " + screen);
		screen.setMod(_mod);
		
	        this.logInfo("Screen type: " + typeof screen);
	        this.logInfo("Screen contents: " + screen);

		// Add the screen to the Screens table
        	this.Screens[_mod.getID()] <- screen;
		
		this.logInfo("ModSettingsSystem " + _mod.getName() + " registered");
	}

	function addPanel( _modPanel )
	{
		if (this.Locked)
		{
			::logError("Settings Manager is Locked, no more settings can be added");
		}
		else
		{
			if (!(_modPanel instanceof ::FU.Class.SettingsPanel))
			{
				throw ::FU.Exception.InvalidType(_modPanel);
			}
			this.Panels[_modPanel.getID()] <- _modPanel;
		}
	}

	function getScreen( _id )
	{
		return this.Screens[_id];
	}


        function hasScreen(_modID)
        {
                return _modID in this.Screens;
        }
	function getAllElementsAsArray( _filter = null )
	{
		local ret = [];
		foreach (panel in this.getPanels())
		foreach (screen in this.Screens)
		{
		    ret.extend(screen.getAllComponentsAsArray(_filter));
		}
		return ret;
	}

	function finalize()
	{
		this.Locked = true;
		this.Screens.sort(this.sortScreensByName);
		local order = 0;
		foreach (screen in this.Screens)
		{
			panel.Order = order;
			order++
		}
	}

	function updateSettingsFromJS( _data )
	{
		/*
		_data = {
			modID = {
				settingID =
				{
					type,
					value
				}
			}
		}
		*/
		foreach (modID, screen in _data)
		{
			foreach (settingID, data in screen)
			{
				this.updateSettingFromJS({
					mod = modID,
					id = settingID,
					type = data.type,
					value = data.value
				});
			}
		}
	}

	function onSettingPressed( _data )
	{
		local setting = this.Screens[_data.modID].getSetting(_data.settingID);
		setting.onPressedCallback();
	}

	function setSettingFromPersistence( _modID, _settingID, _value )
	{
		if (!this.Screens.contains(_modID))
		{
			::FU.Mod.Debug.printWarning(format("The mod %s has been removed", _modID), "debug");
			return;
		}
		if (!this.getScreens(_modID).hasSetting(_settingID))
		{
			::FU.Mod.Debug.printWarning(format("Mod %s no longer has the setting %s", _modID, _settingID), "debug");
			return;
		}
		::getModSetting(_modID, _settingID).set(_value, true, false, true);
	}

	function updateSettingFromJS( _data )
	{
		if (_data.type == "float") _data.value = _data.value.tofloat();
		::getModSetting(_data.mod, _data.id).set(_data.value);
	}

	function updateSettingInJS( _modID, _settingID, _value )
	{
		this.Screen.updateSettingInJS( _modID, _settingID, _value );
	}

	function callScreensFunction( _function, _argsArray )
	{
		_argsArray.insert(0, null);

		foreach (screen in this.Screens)
		{
			_argsArray[0] = screen;
			screen[_function].acall(_argsArray);
		}
	}

	function importPersistentSettings()
	{
		::FU.System.PersistentData.loadFileForEveryMod("ModSetting");
	}

	function flagSerialize( _out )
	{
		this.callPanelsFunction("flagSerialize", [_out]);
	}

	function flagDeserialize( _in )
	{
		this.callPanelsFunction("flagDeserialize", [_in]);
	}

	function getUIData( _flags = null )
	{
		local ret = {};
		foreach (panel in this.getPanels())
		{
			ret[panel.getID()] <- panel.getUIData(_flags);
		}
		return ret;
	}

	function isVisibleWithFlags( _flags )
	{
		foreach (screen in this.getScreens())
		{
			if (screen.verifyFlags(_flags)) return true;
		}
		return false;
	}

	function sortScreensByName( _key1, _mod1, _key2, _mod2 )
	{
		return _mod1.getName() <=> _mod2.getName();
	}
}

::FU.Class.ModSettingsModAddon <- class
{
	Mod = null;
	constructor( _mod )
	{
		this.Mod = _mod;
	}

	function getMod()
	{
		return this.Mod;
	}
}
