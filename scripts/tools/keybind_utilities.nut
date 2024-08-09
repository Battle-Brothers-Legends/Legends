
/**
 * Keybind Utilities
 * 
 * This file contains the core functionality for handling keybinds in the FU mod system.
 * It provides a flexible and extensible framework for managing keyboard and mouse inputs
 * across different environments (Squirrel and JavaScript) and game states.
 *
 * Key components:
 * 
 * 1. FU.Key object:
 *    - Defines key mappings, enums, and utility functions for key operations.
 *    - Provides backwards compatibility functions for older code.
 *
 * 2. KeybindsSystem class:
 *    - Manages the registration, removal, and updating of keybinds.
 *    - Handles input events and routes them to appropriate keybind handlers.
 *    - Interfaces with the mod settings system for persistent keybind configurations.
 *
 * 3. KeybindTemplate class:
 *    - Abstract base class for keybinds, defining common properties and methods.
 *
 * 4. KeybindJS and KeybindSQ classes:
 *    - Concrete implementations for JavaScript and Squirrel keybinds respectively.
 *    - Handle environment-specific keybind behaviors.
 *
 * This system allows mods to easily define and manage custom keybinds, integrating
 * seamlessly with the game's input system and the mod settings UI. It supports
 * complex key combinations, different activation states, and provides a bridge
 * between Squirrel and JavaScript environments for consistent keybind behavior.
 *
 * Usage:
 * - Mods can register keybinds using the KeybindsSystem.
 * - The system automatically handles input processing and keybind activation.
 * - Keybind configurations can be persisted and loaded through the mod settings system.
 *
 * Note: This system interacts closely with other components of the FU mod framework,
 * including the ModSettings system and the UI.JSConnection for frontend communication.
 */

::include("scripts/tools/functional_utilities.nut");

::FU.Key <- {
    // Enums for different aspects of key handling
    Environment = {
        SQ = 0,
        JS = 1
    },
    State = {
        World = 1,
        Tactical = 2,
        MainMenu = 4,
        All = 1 + 2 + 4
    },
    Input = {
        Keyboard = 0,
        Mouse = 1
    },
    KeyState = {
        Press = 1,
        Release = 2,
        Continuous = 4
    },



    // Unified keymap structure
    KeyMap = {
    SQ = {
        Keyboard = {
            "1": "1", "2": "2", "3": "3", "4": "4", "5": "5",
            "6": "6", "7": "7", "8": "8", "9": "9", "10": "0",
            "11": "a", "12": "b", "13": "c", "14": "d", "15": "e",
            "16": "f", "17": "g", "18": "h", "19": "i", "20": "j",
            "21": "k", "22": "l", "23": "m", "24": "n", "25": "o",
            "26": "p", "27": "q", "28": "r", "29": "s", "30": "t",
            "31": "u", "32": "v", "33": "w", "34": "x", "35": "y",
            "36": "z", "37": "backspace", "38": "tab", "39": "enter",
            "40": "space", "41": "escape", "44": "end", "45": "home",
            "46": "pagedown", "47": "pageup", "48": "left", "49": "up",
            "50": "right", "51": "down", "53": "insert", "54": "delete",
            "55": "n0", "56": "n1", "57": "n2", "58": "n3", "59": "n4",
            "60": "n5", "61": "n6", "62": "n7", "63": "n8", "64": "n9",
            "71": "f1", "72": "f2", "73": "f3", "74": "f4", "75": "f5",
            "76": "f6", "77": "f7", "78": "f8", "79": "f9", "80": "f10",
            "81": "f11", "82": "f12", "83": "f13", "84": "f14", "85": "f15",
            "86": "f16", "87": "f17", "88": "f18", "89": "f19", "90": "f20",
            "91": "f21", "92": "f22", "93": "f23", "94": "f24",
            "95": "ctrl", "96": "shift", "97": "alt"
        },
        Mouse = {
            "1": "leftclick",
            "2": "rightclick"
        }
    },
    JS = {
        Keyboard = {
            "8": "backspace", "9": "tab", "13": "return", "16": "shift",
            "17": "ctrl", "18": "alt", "19": "pause", "20": "capslock",
            "27": "escape", "32": "space", "33": "pageup", "34": "pagedown",
            "35": "end", "36": "home", "37": "left", "38": "up", "39": "right",
            "40": "down", "45": "insert", "46": "delete",
            "48": "0", "49": "1", "50": "2", "51": "3", "52": "4", "53": "5",
            "54": "6", "55": "7", "56": "8", "57": "9",
            "65": "a", "66": "b", "67": "c", "68": "d", "69": "e", "70": "f",
            "71": "g", "72": "h", "73": "i", "74": "j", "75": "k", "76": "l",
            "77": "m", "78": "n", "79": "o", "80": "p", "81": "q", "82": "r",
            "83": "s", "84": "t", "85": "u", "86": "v", "87": "w", "88": "x",
            "89": "y", "90": "z",
            "91": "leftwindowkey", "92": "rightwindowkey", "93": "selectkey",
            "96": "n0", "97": "n1", "98": "n2", "99": "n3", "100": "n4",
            "101": "n5", "102": "n6", "103": "n7", "104": "n8", "105": "n9",
            "106": "*", "107": "+", "109": "-", "110": ".", "111": "/",
            "112": "f1", "113": "f2", "114": "f3", "115": "f4", "116": "f5",
            "117": "f6", "118": "f7", "119": "f8", "120": "f9", "121": "f10",
            "122": "f11", "123": "f12", "144": "numlock", "145": "scrolllock",
            "186": "semicolon", "187": "equalsign", "188": "comma",
            "189": "dash", "190": "period", "191": "forwardslash",
            "192": "graveaccent", "219": "openbracket", "220": "backslash",
            "221": "closebracket", "222": "singlequote"
        },
        Mouse = {
            "0": "leftclick",
            "2": "rightclick"
        }
    }
},

    /**
     * Gets the key name from its code for a specific environment.
     * @param {number} code - The key code.
     * @param {number} environment - The environment (SQ or JS).
     * @param {number} inputType - The input type (Keyboard or Mouse).
     * @returns {string|null} - The key name or null if not found.
     */
    function getKeyName(code, environment, inputType) {
        local envMap = environment == this.Environment.SQ ? this.KeyMap.SQ : this.KeyMap.JS;
        local typeMap = inputType == this.Input.Keyboard ? envMap.Keyboard : envMap.Mouse;
        return code.tostring() in typeMap ? typeMap[code.tostring()] : null;
    },
    /**
     * Gets the key code from its name for a specific environment.
     * @param {string} name - The key name.
     * @param {number} environment - The environment (SQ or JS).
     * @param {number} inputType - The input type (Keyboard or Mouse).
     * @returns {number|null} - The key code or null if not found.
     */
    function getKeyCode(name, environment, inputType) {
        local envMap = environment == this.Environment.SQ ? this.KeyMap.SQ : this.KeyMap.JS;
        local typeMap = inputType == this.Input.Keyboard ? envMap.Keyboard : envMap.Mouse;
        foreach (code, keyName in typeMap) {
            if (keyName == name) return code.tointeger();
        }
        return null;
    },



    /**
     * Sorts a key combination string.
     * @param {string} _key - The key combination to sort.
     * @returns {string} - The sorted key combination.
     */
    function sortKeyString(_key) {
        local keyArray = split(_key, "+");
        local mainKey = keyArray.pop();
        
        if (keyArray.len() > 1) {
            keyArray.sort();
            return keyArray.reduce(@(_a, _b) _a + "+" + _b) + "+" + mainKey;
        } else if (keyArray.len() == 1) {
            return keyArray[0] + "+" + mainKey;
        }
        
        return mainKey;
    },

    /**
     * Validates a key combination.
     * @param {array} _keyCombinations - Array of key combinations to validate.
     * @param {boolean} _sq - Whether to use Squirrel (true) or JavaScript (false) mappings.
     * @throws {Exception.KeyNotFound} If an invalid key is found.
     */
    function isValidCombination(_keyCombinations, _sq = true) {
        local mouseMap = _sq ? this.ReverseMouseMapSQ : this.ReverseMouseMapJS;
        local keyMap = _sq ? this.ReverseKeyMapSQ : this.ReverseKeyMapJS;

        foreach (combination in _keyCombinations) {
            foreach (entry in split(combination, "+")) {
                if (!(entry in mouseMap || entry in keyMap)) {
                    ::logError(format("Keybind %s is not valid!", combination));
                    throw ::FU.Exception.KeyNotFound(entry);
                }
            }
        }
    },

    /**
     * Sorts a string of key combinations.
     * @param {string} _keyCombinations - The key combinations to sort.
     * @returns {string} - The sorted key combinations.
     */
    function sortKeyCombinationsString(_keyCombinations) {
        if (_keyCombinations == "") return "";
        local array = split(_keyCombinations, "/");
        array = array.map(this.sortKeyString.bindenv(this));
        array.sort();
        return array.join("/");
    },

    /**
     * Gets the key state from a raw key state.
     * @param {number} _rawKeyState - The raw key state.
     * @returns {number} - The corresponding KeyState.
     */
    function getKeyState(_rawKeyState) {
        return _rawKeyState == 0 ? this.KeyState.Release : this.KeyState.Press;
    },

    /**
     * Gets the mouse state from a raw mouse state.
     * @param {number} _rawMouseState - The raw mouse state.
     * @returns {number} - The corresponding KeyState.
     */
    function getMouseState(_rawMouseState) {
        return _rawMouseState == 0 ? this.KeyState.Press : this.KeyState.Release;
    },

    /**
     * Checks if a key is known.
     * @param {object} _key - The key object to check.
     * @returns {boolean} - Whether the key is known.
     */
    function isKnownKey(_key) {
        return _key.getKey().tostring() in this.KeyMap.SQ.Keyboard;
    },

    /**
     * Checks if a mouse input is known.
     * @param {object} _mouse - The mouse object to check.
     * @returns {boolean} - Whether the mouse input is known.
     */
    function isKnownMouse(_mouse) {
        return _mouse.getID().tostring() in this.KeyMap.SQ.Mouse;
    }

    // Helper functions for backwards compatibility

    /**
     * Gets the SQ key map (for backwards compatibility).
     * @returns {table} - The SQ key map.
     */
    function getKeyMapSQ() {
        local result = {};
        foreach (code, data in this.KeyMap.SQ.Keyboard) {
            result[code] <- data;
        }
        return result;
    },

    /**
     * Gets the SQ mouse map (for backwards compatibility).
     * @returns {table} - The SQ mouse map.
     */
    function getMouseMapSQ() {
        local result = {};
        foreach (code, data in this.KeyMap.SQ.Mouse) {
            result[code] <- data;
        }
        return result;
    },

    /**
     * Gets the reverse SQ key map (for backwards compatibility).
     * @returns {table} - The reverse SQ key map.
     */
    function getReverseKeyMapSQ() {
        local result = {};
        foreach (code, data in this.KeyMap.SQ.Keyboard) {
            result[data] <- code;
        }
        return result;
    },

    /**
     * Gets the reverse SQ mouse map (for backwards compatibility).
     * @returns {table} - The reverse SQ mouse map.
     */
    function getReverseMouseMapSQ() {
        local result = {};
        foreach (code, data in this.KeyMap.SQ.Mouse) {
            result[data] <- code;
        }
        return result;
    },

    /**
     * Gets the reverse JS key map (for backwards compatibility).
     * @returns {table} - The reverse JS key map.
     */
    function getReverseKeyMapJS() {
        local result = {};
        foreach (code, data in this.KeyMap.JS.Keyboard) {
            result[data] <- code;
        }
        return result;
    },

    /**
     * Gets the reverse JS mouse map (for backwards compatibility).
     * @returns {table} - The reverse JS mouse map.
     */
    function getReverseMouseMapJS() {
        local result = {};
        foreach (code, data in this.KeyMap.JS.Mouse) {
            result[data] <- code;
        }
        return result;
    }
};

/**
 * KeybindsSystem Class
 * 
 * This class manages keybindings for mods. It's responsible for registering,
 * tracking, and responding to key inputs for mod-specific actions.
 * 
 * Key components:
 * - KeybindsByKey: Organizes keybinds by the key they're bound to
 * - KeybindsByMod: Organizes keybinds by the mod they belong to
 * - KeybindsForJS: Keybinds that need to be communicated to the JavaScript frontend
 * 
 * Note: This system interacts closely with the JavaScript frontend. Changes in how
 * keybinds are stored or processed here may require updates in the frontend code.
 */

class ::FU.Class.KeybindsSystem extends ::FU.Class.System{
    KeybindsByKey = null;
    KeybindsByMod = null;
    KeybindsForJS = null;
    PressedKeys = null;
    KeysChanged = false;

    /**
     * Constructor for the KeybindsSystem class.
     */
    constructor() {
        base.constructor(SystemID.Keybinds);
	this.logInfo("Initializing KeybindsSystem");
 	::FU.Class.KeybindsSystem.initialize();
        this.logInfo("KeybindsSystem initialized");
    }

    static function initialize()
    {
        this.logInfo("Initializing KeybindsSystem");
     //   if (::FU.Class.KeybindsSystem.KeybindsByKey == null) ::FU.Class.KeybindsSystem.KeybindsByKey = {};
    //    if (::FU.Class.KeybindsSystem.KeybindsByMod == null) ::FU.Class.KeybindsSystem.KeybindsByMod = {};
     //   if (::FU.Class.KeybindsSystem.KeybindsForJS == null) ::FU.Class.KeybindsSystem.KeybindsForJS = {};
     //   if (::FU.Class.KeybindsSystem.PressedKeys == null) ::FU.Class.KeybindsSystem.PressedKeys = {};
     //   ::FU.Class.KeybindsSystem.KeysChanged = false;
     //   this.logInfo("KeybindsSystem initialized");
    }

    /**
     * Registers a mod with the keybinds system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        this.logInfo("Registering mod in KeybindsSystem: " + _mod.getID());
        
        if (::FU.Class.KeybindsSystem.KeybindsByMod == null || ::FU.Class.KeybindsSystem.KeybindsForJS == null)
        {
            ::FU.Class.KeybindsSystem.initialize();
        }
        
     //   this.logInfo("KeybindsByMod before: " + (this.KeybindsByMod != null));
      //  this.logInfo("KeybindsForJS before: " + (this.KeybindsForJS != null));
        
	this.logInfo("Registering keybinds for mod: " + _mod.getID());
	
        if (!::FU.Class.ModSettingsSystem.hasScreen(_mod.getID())) 
        {
            ::FU.Class.ModSettingsSystem.registerMod(_mod);
        }

        _mod.Keybinds = ::FU.Class.KeybindTemplate(_mod, _mod.getID(), _mod.getName());
        ::FU.Class.ModSettingsSystem.getScreen(_mod.getID()).addPage(::FU.Class.SettingsPage("Keybinds"));


        //::FU.Class.KeybindsSystem.KeybindsByMod[_mod.getID()] <- {};
        //::FU.Class.KeybindsSystem.KeybindsForJS[_mod.getID()] <- {};
	//this.logInfo("KeybindsByMod: " + (this.KeybindsByMod != null));
	//this.logInfo("KeybindsForJS: " + (this.KeybindsForJS != null));
        //this.logInfo("Keybinds registered for mod: " + _mod.getID());
    }

    /**
     * Adds a keybind to the system.
     * @param _keybind {KeybindTemplate} - The keybind to add.
     * @param _makeSetting {boolean} - Whether to create a setting for the keybind.
     */
    function add(_keybind, _makeSetting = true) {
        if (!(_keybind instanceof KeybindTemplate)) {
            throw Exception.InvalidType(_keybind);
        }
        if (_keybind instanceof KeybindJS) {
            if (UI.JSConnection.isConnected()) {
                UI.JSConnection.addKeybind(_keybind);
            }
            this.KeybindsForJS[_keybind.getMod().getID()][_keybind.getID()] <- _keybind;
        } else if (_keybind instanceof KeybindSQ) {
            foreach (key in _keybind.getRawKeyCombinations()) {
                Mod.Debug.printWarning(format("Adding keyCombination %s for keybind %s", key, _keybind.getID()), "keybinds")
                if (!(key in this.KeybindsByKey)) {
                    this.KeybindsByKey[key] <- [];
                    Mod.Debug.printWarning("Creating Keybind array for key: " + key, "keybinds")
                }
                this.KeybindsByKey[key].push(_keybind);
            }
        }

        this.KeybindsByMod[_keybind.getMod().getID()][_keybind.getID()] <- _keybind;
        if (_makeSetting) {
            this.addKeybindSetting(_keybind);
        }
    }

    /**
     * Removes a keybind from the system.
     * @param _modID {string} - The ID of the mod the keybind belongs to.
     * @param _id {string} - The ID of the keybind to remove.
     * @returns {KeybindTemplate} - The removed keybind.
     */
    function remove(_modID, _id) {
        Mod.Debug.printWarning("Removing Keybind" + this.KeybindsByMod[_modID][_id], "keybinds");
        local keybind = this.KeybindsByMod[_modID].rawdelete(_id);
        if (keybind instanceof KeybindJS) {
            this.KeybindsForJS[_modID].rawdelete(_id);
            UI.JSConnection.removeKeybind(keybind);
        } else if (keybind instanceof KeybindSQ) {
            foreach (key in keybind.getRawKeyCombinations()) {
                this.KeybindsByKey[key].remove(this.KeybindsByKey[key].find(keybind));
                if (this.KeybindsByKey[key].len() == 0) {
                    this.KeybindsByKey.rawdelete(key);
                }
            }
        }
        return keybind;
    }

    /**
     * Updates a keybind in the system.
     * @param _modID {string} - The ID of the mod the keybind belongs to.
     * @param _id {string} - The ID of the keybind to update.
     */
    function update(_modID, _id) {
        local keybind = this.remove(_modID, _id);
        keybind.KeyCombinations = split(::FU.Key.sortKeyCombinationsString(getModSetting(_modID, _id).getValue()), "/");
        this.add(keybind, false);
    }

    /**
     * Calls the appropriate keybind function for a given key event.
     * @param _key {string} - The key that was pressed.
     * @param _environment {table} - The environment table.
     * @param _state {string} - The state of the key event.
     * @param _keyState {string} - The key state (press, release, continuous).
     * @returns {boolean} - Whether the keybind was successfully called.
     */
    function call(_key, _environment, _state, _keyState) {
        if (!(_key in this.KeybindsByKey)) {
            return;
        }

        foreach (keybind in this.KeybindsByKey[_key]) {
            Mod.Debug.printWarning("Checking keybind: " + keybind.tostring(), "keybinds");
            if (!keybind.hasState(_state)) {
                continue;
            }

            if (!keybind.callOnKeyState(_keyState)) {
                continue;
            }

            Mod.Debug.printWarning("Calling keybind", "keybinds");
            if (keybind.call(_environment) == true) {
                Mod.Debug.printWarning("Returning after keybind call returned true.", "keybinds");
                return true;
            }
        }
    }

    /**
     * Adds a keybind setting to the mod settings.
     * @param _keybind {KeybindTemplate} - The keybind to add as a setting.
     */
    function addKeybindSetting(_keybind) {
        ::FU.Class.ModSettingsSystem.getScreen(_keybind.getMod().getID()).getPage("Keybinds").addElement(_keybind.makeSetting());
    }

    /**
     * Gets all JavaScript keybinds.
     * @returns {array} - An array of keybind data for JavaScript.
     */
    function getJSKeybinds() {
        local ret = [];
        foreach (mod in this.KeybindsForJS) {
            foreach (keybind in mod) {
                ret.push(keybind.getUIData());
            }
        }
        return ret;
    }

    /**
     * Handles key input events.
     * 
     * This method is called when a key is pressed.
     * 1. It translates the key input into a string representation.
     * 2. It determines if the key state is continuous (held down) or not.
     * 3. It delegates to a more general input handler (onInput).
     * 
     * The processed key input is then used to trigger appropriate mod actions.
     * This method is the link between user input and mod functionality.
     * 
     * @param _key The key input object
     * @param _environment The current game environment
     * @param _state The state of the key event
     * @returns The result of processing the input
     */
    function onKeyInput(_key, _environment, _state) {
        this.KeysChanged = true;
        local keyAsString = ::FU.Key.getKeyName(_key.getKey(), ::FU.Key.Environment.SQ, ::FU.Key.Input.Keyboard);
        local keyState;
        if (this.isKeyStateContinuous(_key)) {
            keyState = ::FU.Key.KeyState.Continuous;
        } else {
            keyState = ::FU.Key.getKeyState(_key.getState());
        }
        return this.onInput(_key, _environment, _state, keyAsString, keyState);
    }


    /**
     * Updates the frame and clears keys if necessary.
     */
    function frameUpdate(_) {
        if (!this.KeysChanged && this.PressedKeys.len() != 0) {
            UI.JSConnection.clearKeys();
            this.PressedKeys = {};
        }
        this.KeysChanged = false;
        Time.scheduleEvent(TimeUnit.Real, 1, this.frameUpdate.bindenv(this), null);
    }

    /**
     * Handles mouse input events.
     * @param _mouse {string} - The mouse event.
     * @param _environment {table} - The environment table.
     * @param _state {string} - The state of the mouse event.
     */
    function onMouseInput(_mouse, _environment, _state) {
        local keyAsString = ::FU.Key.getKeyName(_mouse.getID(), ::FU.Key.Environment.SQ, ::FU.Key.Input.Mouse);
        return this.onInput(_mouse, _environment, _state, keyAsString, ::FU.Key.getMouseState(_mouse.getState()));
    }

    /**
     * Handles input events.
     * @param _key {string} - The key or mouse event.
     * @param _environment {table} - The environment table.
     * @param _state {string} - The state of the event.
     * @param _keyAsString {string} - The key as a string.
     * @param _keyState {string} - The state of the key.
     * @returns {boolean} - Whether the input was successfully handled.
     */
    function onInput(_key, _environment, _state, _keyAsString, _keyState) {
        local key = "";
        foreach (pressedKeyID, value in this.PressedKeys) {
            if (_keyAsString != pressedKeyID) {
                key += pressedKeyID + "+";
            }
        }
        key += _keyAsString;
        key = sortKeyString(key);
        Mod.Debug.printWarning("Final key string: " + key, "keybinds");
        return this.call(key, _environment, _state, _keyState);
    }

    /**
     * Checks if the key state is continuous.
     * @param _key {string} - The key event.
     * @returns {boolean} - Whether the key state is continuous.
     */
    function isKeyStateContinuous(_key) {
        local key = ::FU.Key.getKeyName(_key.getKey(), ::FU.Key.Environment.SQ, ::FU.Key.Input.Keyboard);

        if (_key.getState() == 1) {
            if (key in this.PressedKeys) {
                return true;
            }
            this.PressedKeys[key] <- 1;
        } else {
            if (key in this.PressedKeys) {
                delete this.PressedKeys[key];
            }
        }
        return false;
    }
    /**
     * Checks if a keybind is pressed.
     * @param _modID {string} - The ID of the mod the keybind belongs to.
     * @param _id {string} - The ID of the keybind.
     * @returns {boolean} - Whether the keybind is pressed.
     */
    function isKeybindPressed(_modID, _id) {
        local keybind = this.KeybindsByMod[_modID][_id];
        foreach (rawKeyCombination in keybind.getRawKeyCombinations()) {
            local keyCombination = split(rawKeyCombination, "+");
            if (keyCombination.len() != this.PressedKeys.len()) continue;
            local failedKeyCombination = false;
            foreach (key in keyCombination) {
                if (!(key in this.PressedKeys)) {
                    failedKeyCombination = true;
                    break;
                }
            }
            if (failedKeyCombination) continue;
            return true;
        }
        return false;
    }

    /**
     * Imports persistent settings for keybinds.
     */
    function importPersistentSettings() {
        System.PersistentData.loadFileForEveryMod("Keybind");
    }

    /**
     * Updates keybinds from persistent settings.
     * @param _modID {string} - The ID of the mod.
     * @param _id {string} - The ID of the keybind.
     * @param _keyCombinations {string} - The key combinations for the keybind.
     */
    function updateFromPersistence(_modID, _id, _keyCombinations) {
        ::FU.Class.ModSettingsSystem.setSettingFromPersistence(_modID, _id, _keyCombinations);
    }
}


/**
 * KeybindTemplate class
 * 
 * This abstract class represents a keybind.
 */
::FU.Class.KeybindTemplate <- class {
    Mod = null;
    ID = null;
    Name = null;
    KeyCombinations = [];

    /**
     * Constructor for the KeybindTemplate class.
     * @param _mod {Mod} - The mod to which the keybind belongs.
     * @param _id {string} - The unique identifier for the keybind.
     * @param _name {string} - The display name of the keybind.
     */
    constructor(_mod, _id, _name) {
        if (typeof _mod != "instance" || !(_mod instanceof ::FU.Class.Mod)) {
            throw "Invalid mod instance";
        }
        this.Mod = _mod;
        this.ID = _id;
        this.Name = _name;
    }

    /**
     * Gets the mod to which the keybind belongs.
     * @returns {Mod} - The mod to which the keybind belongs.
     */
    function getMod() {
        return this.Mod;
    }

    /**
     * Gets the ID of the keybind.
     * @returns {string} - The ID of the keybind.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the name of the keybind.
     * @returns {string} - The name of the keybind.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the key combinations for the keybind.
     * @returns {array} - The key combinations for the keybind.
     */
    function getKeyCombinations() {
        return this.KeyCombinations;
    }

    /**
     * Sets the key combinations for the keybind.
     * @param _keyCombinations {array} - The key combinations to set.
     */
    function setKeyCombinations(_keyCombinations) {
        this.KeyCombinations = _keyCombinations;
    }

    /**
     * Checks if the keybind has a given state.
     * @param _state {string} - The state to check.
     * @returns {boolean} - True if the keybind has the state, false otherwise.
     */
    function hasState(_state) {
        return false; // To be overridden by subclasses
    }

    /**
     * Calls the keybind with a given environment.
     * @param _environment {table} - The environment table.
     * @returns {boolean} - True if the keybind was successfully called, false otherwise.
     */
    function call(_environment) {
        return false; // To be overridden by subclasses
    }

    /**
     * Makes a setting for the keybind.
     * @returns {Setting} - The setting for the keybind.
     */
    function makeSetting() {
        return Setting(this.ID, this.Name, this.KeyCombinations.join("/"));
    }
}

/**
 * KeybindJS class
 * 
 * This class represents a JavaScript keybind.
 */
class KeybindJS extends ::FU.Class.KeybindTemplate{
    /**
     * Constructor for the KeybindJS class.
     * @param _mod {Mod} - The mod to which the keybind belongs.
     * @param _id {string} - The unique identifier for the keybind.
     * @param _name {string} - The display name of the keybind.
     * @param _keyCombinations {array} - The key combinations for the keybind.
     */
    constructor(_mod, _id, _name, _keyCombinations) {
        base.constructor(_mod, _id, _name);
        this.setKeyCombinations(_keyCombinations);
    }

    /**
     * Checks if the keybind has a given state.
     * @param _state {string} - The state to check.
     * @returns {boolean} - True if the keybind has the state, false otherwise.
     */
    function hasState(_state) {
        return true; // JavaScript keybinds are always active
    }

    /**
     * Calls the keybind with a given environment.
     * @param _environment {table} - The environment table.
     * @returns {boolean} - True if the keybind was successfully called, false otherwise.
     */
    function call(_environment) {
        return UI.JSConnection.callKeybind(this.getMod().getID(), this.getID(), _environment);
    }

    /**
     * Gets the UI data for the keybind.
     * @returns {table} - The UI data for the keybind.
     */
    function getUIData() {
        return { id = this.getID(), name = this.getName(), keys = this.getKeyCombinations() };
    }
}

/**
 * KeybindSQ class
 * 
 * This class represents a Squirrel keybind.
 */
class KeybindSQ extends ::FU.Class.KeybindTemplate {
    State = null;

    /**
     * Constructor for the KeybindSQ class.
     * @param _mod {Mod} - The mod to which the keybind belongs.
     * @param _id {string} - The unique identifier for the keybind.
     * @param _name {string} - The display name of the keybind.
     * @param _keyCombinations {array} - The key combinations for the keybind.
     * @param _state {string} - The state for the keybind.
     */
    constructor(_mod, _id, _name, _keyCombinations, _state) {
        base.constructor(_mod, _id, _name);
        this.setKeyCombinations(_keyCombinations);
        this.State = _state;
    }

    /**
     * Checks if the keybind has a given state.
     * @param _state {string} - The state to check.
     * @returns {boolean} - True if the keybind has the state, false otherwise.
     */
    function hasState(_state) {
        return this.State == _state;
    }

    /**
     * Calls the keybind with a given environment.
     * @param _environment {table} - The environment table.
     * @returns {boolean} - True if the keybind was successfully called, false otherwise.
     */
    function call(_environment) {
        // Implement the logic for calling the Squirrel keybind
        return true; // Placeholder implementation
    }
}

// Create properties that use the helper functions for backwards compatibility
::FU.Key.KeyMapSQ <- ::FU.Key.getKeyMapSQ();
::FU.Key.MouseMapSQ <- ::FU.Key.getMouseMapSQ();
::FU.Key.ReverseKeyMapJS <- ::FU.Key.getReverseKeyMapJS();
::FU.Key.ReverseMouseMapJS <- ::FU.Key.getReverseMouseMapJS();

// Example usage of the settings, keybinds, and tooltips
function exampleUsage() {
    local mod1 = Mod("Mod1", "1.0.0", "First Mod");

    // Settings
    local setting1 = Setting("Setting1", "First Setting", "DefaultValue");
    ::FU.Class.ModSettingsSystem.addSetting(mod1.getID(), setting1);
    this.logInfo("Setting1 Value: " + ::FU.Class.ModSettingsSystem.getSetting(mod1.getID(), "Setting1").getValue());

    // Keybinds
    local keybindJS = KeybindJS(mod1, "KeybindJS1", "JavaScript Keybind", ["Ctrl+J"]);
    System.Keybinds.add(keybindJS);
    this.logInfo("KeybindJS1 ID: " + keybindJS.getID());

    local keybindSQ = KeybindSQ(mod1, "KeybindSQ1", "Squirrel Keybind", ["Ctrl+S"], "active");
    System.Keybinds.add(keybindSQ);
    this.logInfo("KeybindSQ1 ID: " + keybindSQ.getID());

    // Tooltips
    local tooltip = Tooltip("Tooltip1", "This is a tooltip.");
    System.Tooltips.addTooltip(mod1.getID(), "Tooltip1", tooltip);
    this.logInfo("Tooltip1 Text: " + System.Tooltips.getTooltip(mod1.getID(), "Tooltip1").getText());
}

// Uncomment to run the example usage function
// exampleUsage();

// Unit test for keybind system
function testKeybindsSystem() {
    local keybindsSystem = KeybindsSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    keybindsSystem.registerMod(mod);

    local keybindJS = KeybindJS(mod, "KeybindJS1", "JavaScript Keybind", ["Ctrl+J"]);
    keybindsSystem.add(keybindJS);

    assert(keybindsSystem.KeybindsByMod["TestMod"]["KeybindJS1"] == keybindJS);

    keybindsSystem.remove("TestMod", "KeybindJS1");
    assert(keybindsSystem.KeybindsByMod["TestMod"].rawin("KeybindJS1") == false);

    print("KeybindsSystem class tests passed.");
}

// Run the test
//testKeybindsSystem();


