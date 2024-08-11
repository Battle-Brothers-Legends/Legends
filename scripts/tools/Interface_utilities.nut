/**
 * Interface Utilities for JavaScript-Squirrel Communication
 *
 * This file contains utility functions and objects that facilitate communication 
 * between the Squirrel backend and the JavaScript frontend in the FU mod framework. 
 *
 * Workflow:
 * ----------
 * 1. **Initialization**: 
 *    - The connection is initialized using the `create()` function, setting up the necessary 
 *      handles and IDs for communication.
 * 
 * 2. **Connection Establishment**: 
 *    - The `connect()` function is called to establish a live connection with the JavaScript 
 *      frontend, allowing the backend to send and receive data.
 *
 * 3. **Ongoing Communication**: 
 *    - During gameplay, the backend continuously checks the connection status using 
 *      `isConnected()` and can manage UI states with `isVisible()` and `isAnimating()`.
 *
 * 4. **Termination**: 
 *    - When the connection is no longer needed, the `destroy()` function is used to safely 
 *      terminate the connection, preventing memory leaks and ensuring the game engine can 
 *      clean up resources.
 *
 */


::FU.UI <- {
	Connections = [],
	Callbacks = [],
	JSConnection = null,

	function registerConnection( _connection )
	{
		this.Connections.push(_connection);
	}

	function connect()
	{
		foreach (connection in this.Connections)
		{
			connection.connect();
		}
		this.Connections.clear();
		foreach (callback in this.Callbacks)
		{
			callback();
		}
		this.Callbacks.clear();
	}

	function addOnConnectCallback( _function )
	{
		::FU.requireFunction(_function);
		this.Callbacks.push(_function);
	}
}

::mods_registerCSS("utilities/css/utilities.css");

::mods_registerJS("utilities/functional_utilities.js");
::mods_registerJS("utilities/keybind_utilities.js");
::mods_registerJS("utilities/connection_utilities.js");

//TODO rework
//::mods_registerJS("utilities/ui_hooks/main_menu_module.js");
//::mods_registerJS("utilities/ui_hooks/main_menu_screen.js");
//::mods_registerJS("utilities/ui_hooks/tooltip_module.js");

::mods_registerJS("utilities/settings/setting_button.js");
::mods_registerJS("utilities/settings/setting_dropdown.js");
::mods_registerJS("utilities/settings/setting_heading.js");
::mods_registerJS("utilities/settings/setting_keybind.js");
::mods_registerJS("utilities/settings/setting_layout.js");
::mods_registerJS("utilities/settings/setting_multiselect.js");
::mods_registerJS("utilities/settings/setting_picker.js");
::mods_registerJS("utilities/settings/setting_slider.js");
::mods_registerJS("utilities/settings/setting_screen.js");
::mods_registerJS("utilities/settings/setting_toggle.js");
::mods_registerJS("utilities/settings/setting_textinput.js");


 /**
 *     JS Connection
 *    - This object manages the connection lifecycle between the Squirrel backend and the 
 *      JavaScript frontend.
 *    - It includes methods for establishing (`connect`), managing (`isConnected`), and 
 *      terminating (`destroy`) the connection.
 *    - Additional methods (`isVisible`, `isAnimating`) provide hooks for UI state management, 
 *      though they are set to return `false` by default and can be overridden as needed.
  */

FU.js_connection<- class {
    constructor() {
        this.m = {
            JSHandle = null,
            ID = null
        };
    }
    /**
     * Initializes the connection to the JavaScript UI.
     * This method is typically called during the game's initialization process.
     */
	function create()
	{
 		// Logic to initialize connection
	}
    /**
     * Establishes the connection with the JavaScript UI.
     * This is a crucial step where the Squirrel backend connects with the JavaScript frontend.
     */
	function connect()
	{
		this.m.JSHandle = this.UI.connect(this.m.ID, this);
	}
    /**
     * Destroys the connection with the JavaScript UI.
     * It is important to properly disconnect to avoid memory leaks and dangling references.
     */
	function destroy()
	{
		this.m.JSHandle = ::UI.disconnect(this.m.JSHandle);
	}
    /**
     * Checks if the UI is currently visible.
     * @returns {boolean} - False by default, override if needed.
     */
	function isVisible()
	{
		return false
	}
    /**
     * Checks if the UI is currently animating.
     * @returns {boolean} - False by default, override if needed.
     */
	function isAnimating()
	{
		return false
	}
    /**
     * Checks if there is an active connection to the JavaScript UI.
     * @returns {boolean} - True if connected, false otherwise.
     */
	function isConnected()
	{
		return this.m.JSHandle != null;
	}
};
::FU.FU_connection <- class extends ::FU.js_connection{
    
    constructor() {
        base.constructor();  
        this.m = {};  
    }

	function connect()
	{
		this.m.JSHandle = ::UI.connect("FUConnection", this);
		this.querySettingsData();
		this.checkForModUpdates();
	}

	function querySettingsData()
	{
		local data = {
			keybinds = ::FU.System.Keybinds.getJSKeybinds(),
			settings = ::FU.System.ModSettings.getUIData()
		};
		this.m.JSHandle.asyncCall("onQuerySettingsData", data);
	}

	function removeKeybind( _keybind )
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("removeKeybind", _keybind.getUIData())
		}
	}

	function addKeybind( _keybind )
	{
		if (this.m.JSHandle != null)
		{
			this.m.JSHandle.asyncCall("addKeybind", _keybind.getUIData())
		}
	}

	function clearKeys()
	{
		this.m.JSHandle.asyncCall("clearKeys", null);
	}

	function checkForModUpdates()
	{
		this.m.JSHandle.asyncCall("checkForModUpdates", ::FU.System.Registry.getModsForUpdateCheck());
	}

	function receiveModVersions( _modVersions )
	{
		::FU.System.Registry.checkIfModVersionsAreNew(_modVersions);
	}
};

::FU.UI.JSConnection <- ::FU.FU_connection ;
::FU.UI.registerConnection(::FU.UI.JSConnection);




