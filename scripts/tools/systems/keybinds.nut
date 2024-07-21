class KeybindsSystem extends System {
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
        this.KeybindsByKey = {};
        this.KeybindsByMod = {};
        this.KeybindsForJS = {};
        this.PressedKeys = {};
    }

    /**
     * Registers a mod with the keybinds system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        base.registerMod(_mod);
        if (!System.ModSettings.hasPanel(_mod.getID())) {
            System.ModSettings.registerMod(_mod);
        }

        _mod.Keybinds = KeybindsModAddon(_mod);
        System.ModSettings.getPanel(_mod.getID()).addPage(SettingsPage("Keybinds"));

        this.KeybindsByMod[_mod.getID()] <- {};
        this.KeybindsForJS[_mod.getID()] <- {};
    }

    /**
     * Adds a keybind to the system.
     * @param _keybind {AbstractKeybind} - The keybind to add.
     * @param _makeSetting {boolean} - Whether to create a setting for the keybind.
     */
    function add(_keybind, _makeSetting = true) {
        if (!(_keybind instanceof AbstractKeybind)) {
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
     * @returns {AbstractKeybind} - The removed keybind.
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
        keybind.KeyCombinations = split(Key.sortKeyCombinationsString(getModSetting(_modID, _id).getValue()), "/");
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
     * @param _keybind {AbstractKeybind} - The keybind to add as a setting.
     */
    function addKeybindSetting(_keybind) {
        System.ModSettings.getPanel(_keybind.getMod().getID()).getPage("Keybinds").addElement(_keybind.makeSetting());
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
     * @param _key {string} - The key that was pressed.
     * @param _environment {table} - The environment table.
     * @param _state {string} - The state of the key event.
     */
    function onKeyInput(_key, _environment, _state) {
        this.KeysChanged = true;
        local keyAsString = Key.KeyMapSQ[_key.getKey().tostring()];
        local keyState;
        if (this.isKeyStateContinuous(_key)) {
            keyState = Key.KeyState.Continuous;
        } else {
            keyState = Key.getKeyState(_key.getState());
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
        local keyAsString = Key.MouseMapSQ[_mouse.getID().tostring()];
        return this.onInput(_mouse, _environment, _state, keyAsString, Key.getMouseState(_mouse.getState()));
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
        key = Key.sortKeyString(key);
        Mod.Debug.printWarning("Final key string: " + key, "keybinds");
        return this.call(key, _environment, _state, _keyState);
    }

    /**
     * Checks if the key state is continuous.
     * @param _key {string} - The key event.
     * @returns {boolean} - Whether the key state is continuous.
     */
    function isKeyStateContinuous(_key) {
        local key = Key.KeyMapSQ[_key.getKey().tostring()];

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
        System.ModSettings.setSettingFromPersistence(_modID, _id, _keyCombinations);
    }
}


/**
 * AbstractKeybind class
 * 
 * This abstract class represents a keybind.
 */
class AbstractKeybind {
    Mod = null;
    ID = null;
    Name = null;
    KeyCombinations = [];

    /**
     * Constructor for the AbstractKeybind class.
     * @param _mod {Mod} - The mod to which the keybind belongs.
     * @param _id {string} - The unique identifier for the keybind.
     * @param _name {string} - The display name of the keybind.
     */
    constructor(_mod, _id, _name) {
        requireInstanceOf(Mod, _mod);
        requireString(_id, _name);
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
class KeybindJS extends AbstractKeybind {
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
class KeybindSQ extends AbstractKeybind {
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

// Example usage of the settings, keybinds, and tooltips
function exampleUsage() {
    local mod1 = Mod("Mod1", "1.0.0", "First Mod");

    // Settings
    local setting1 = Setting("Setting1", "First Setting", "DefaultValue");
    System.ModSettings.addSetting(mod1.getID(), setting1);
    print("Setting1 Value: " + System.ModSettings.getSetting(mod1.getID(), "Setting1").getValue());

    // Keybinds
    local keybindJS = KeybindJS(mod1, "KeybindJS1", "JavaScript Keybind", ["Ctrl+J"]);
    System.Keybinds.add(keybindJS);
    print("KeybindJS1 ID: " + keybindJS.getID());

    local keybindSQ = KeybindSQ(mod1, "KeybindSQ1", "Squirrel Keybind", ["Ctrl+S"], "active");
    System.Keybinds.add(keybindSQ);
    print("KeybindSQ1 ID: " + keybindSQ.getID());

    // Tooltips
    local tooltip = Tooltip("Tooltip1", "This is a tooltip.");
    System.Tooltips.addTooltip(mod1.getID(), "Tooltip1", tooltip);
    print("Tooltip1 Text: " + System.Tooltips.getTooltip(mod1.getID(), "Tooltip1").getText());
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


