/**
 * FU.Keybinds - Keybind Utilities
 *
 * This file contains the core functionality for handling keybinds in the FU mod system.
 * It provides a flexible and extensible framework for managing keyboard and mouse inputs
 * across different environments (Squirrel and JavaScript) and game states.
 *
 * Key components:
 *
 * 1. FU.Keybinds object:
 *    - Manages the registration, removal, and updating of keybinds.
 *    - Handles input events and routes them to appropriate keybind handlers.
 *    - Interfaces with the mod settings system for persistent keybind configurations.
 *
 * 2. KeybindsSystem class:
 *    - A facade for higher-level management of keybinds.
 *    - Provides methods for adding, removing, and querying keybinds.
 *    - Maintains internal state and tracks which keys are currently pressed.
 *
 * 3. FU.Key object:
 *    - Contains utility functions and mappings for key operations.
 *    - Provides enums and backwards compatibility functions.
 *
 * Usage:
 * - Mods can register keybinds using the KeybindsSystem.
 * - The system automatically handles input processing and keybind activation.
 * - Keybind configurations can be persisted and loaded through the mod settings system.
 *
 * Note: This system interacts closely with other components of the FU mod framework,
 * including the ModSettings system and the UI.JSConnection for frontend communication.
 */

const FU = {
    Keybinds: {
        KeybindsByMod: {}, // Stores keybinds organized by mod
        PressedKeys: {}, // Tracks currently pressed keys

        /**
         * Sets the keybinds from the backend data.
         * @param {Array} _keybinds - Array of keybind objects from the backend.
         */
        setKeybinds: function(_keybinds) {
            var self = this;
            _keybinds.forEach(function(keybind) {
                self.addKeybindFromSQ(keybind.modID, keybind.id, keybind.keyCombinations);
            });
        },

        /**
         * Adds a keybind from Squirrel (game engine) data.
         * @param {String} _modID - The ID of the mod.
         * @param {String} _id - The ID of the keybind.
         * @param {Array} _keyCombinations - Array of key combinations.
         */
        addKeybindFromSQ: function(_modID, _id, _keyCombinations) {
            if (!(this.KeybindsByMod[_modID])) {
                this.KeybindsByMod[_modID] = {};
            }
            this.KeybindsByMod[_modID][_id] = new FU.Keybind(_modID, _id, _keyCombinations);
        },

        /**
         * Removes a keybind based on mod and keybind ID.
         * @param {String} _modID - The ID of the mod.
         * @param {String} _id - The ID of the keybind to remove.
         */
        removeKeybind: function(_modID, _id) {
            if (this.KeybindsByMod[_modID]) {
                delete this.KeybindsByMod[_modID][_id];
                if (Object.keys(this.KeybindsByMod[_modID]).length === 0) {
                    delete this.KeybindsByMod[_modID];
                }
            }
        },

        /**
         * Returns the currently pressed keys as a string.
         * @param {String} _excludeKey - A key to exclude from the output string.
         * @returns {String} - String representation of pressed keys.
         */
        getPressedKeysAsString: function(_excludeKey) {
            return Object.keys(this.PressedKeys)
                .filter(key => key !== _excludeKey)
                .join('+');
        },

        /**
         * Updates the pressed keys based on input.
         * @param {String} _key - The key to update.
         * @param {Boolean} _release - Whether the key is being released.
         * @returns {Boolean} - True if the key was already pressed, false otherwise.
         */
        updatePressedKeys: function(_key, _release) {
            if (!_release) {
                if (this.PressedKeys[_key]) {
                    return true; // Key is already pressed
                }
                this.PressedKeys[_key] = true;
            } else {
                delete this.PressedKeys[_key];
            }
            return false;
        },

        /**
         * Checks if a mousebind is pressed.
         * @param {String} _modID - The ID of the mod.
         * @param {String} _id - The ID of the keybind.
         * @param {Event} _event - The mouse event to check.
         * @returns {Boolean} - True if the mousebind is pressed, false otherwise.
         */
        isMousebindPressed: function(_modID, _id, _event) {
            var key = FU.Key.MouseMapJS[_event.button];
            return this.isPressed(_modID, _id, key);
        },

        /**
         * Checks if a keybind is pressed.
         * @param {String} _modID - The ID of the mod.
         * @param {String} _id - The ID of the keybind.
         * @param {Event} _event - The keyboard event to check.
         * @returns {Boolean} - True if the keybind is pressed, false otherwise.
         */
        isKeybindPressed: function(_modID, _id, _event) {
            var key = FU.Key.KeyMapJS[_event.keyCode];
            return this.isPressed(_modID, _id, key);
        },

        /**
         * Checks if a specific key is pressed for a given keybind.
         * @param {String} _modID - The ID of the mod.
         * @param {String} _id - The ID of the keybind.
         * @param {String} _key - The key to check.
         * @returns {Boolean} - True if the key is pressed, false otherwise.
         */
        isPressed: function(_modID, _id, _key) {
            const keybind = this.KeybindsByMod[_modID] && this.KeybindsByMod[_modID][_id];
            if (!keybind) {
                console.error(`Unknown Keybind: Mod ID = ${_modID}, Keybind ID = ${_id}`);
                return false;
            }
            return keybind.isKeyCombinationPressed(_key);
        },
    },

    Key: {
        /**
         * Enums for different aspects of key handling.
         */
        Environment: {
            SQ: 0,  // Squirrel environment
            JS: 1   // JavaScript environment
        },
        State: {
            World: 1,
            Menu: 2,
            Combat: 3
        },

        /**
         * Maps mouse buttons to string identifiers.
         */
        MouseMapJS: {
            0: 'LMB', // Left Mouse Button
            1: 'MMB', // Middle Mouse Button
            2: 'RMB'  // Right Mouse Button
        },

        /**
         * Maps keyboard key codes to string identifiers.
         */
	KeyMapJS: {
            // Function Keys
            112: 'F1',  113: 'F2',  114: 'F3',  115: 'F4',
            116: 'F5',  117: 'F6',  118: 'F7',  119: 'F8',
            120: 'F9',  121: 'F10', 122: 'F11', 123: 'F12',

            // Number Keys
            48: '0', 49: '1', 50: '2', 51: '3', 52: '4',
            53: '5', 54: '6', 55: '7', 56: '8', 57: '9',

            // Alphabet Keys
            65: 'A', 66: 'B', 67: 'C', 68: 'D', 69: 'E',
            70: 'F', 71: 'G', 72: 'H', 73: 'I', 74: 'J',
            75: 'K', 76: 'L', 77: 'M', 78: 'N', 79: 'O',
            80: 'P', 81: 'Q', 82: 'R', 83: 'S', 84: 'T',
            85: 'U', 86: 'V', 87: 'W', 88: 'X', 89: 'Y',
            90: 'Z',

            // Numpad Keys
            96: 'Numpad0', 97: 'Numpad1', 98: 'Numpad2', 99: 'Numpad3',
            100: 'Numpad4', 101: 'Numpad5', 102: 'Numpad6', 103: 'Numpad7',
            104: 'Numpad8', 105: 'Numpad9',

            // Special Characters and Operators
            32: 'Space', 13: 'Enter', 16: 'Shift', 17: 'Ctrl', 18: 'Alt',
            27: 'Escape', 9: 'Tab', 8: 'Backspace',
            20: 'CapsLock', 144: 'NumLock', 145: 'ScrollLock',
            186: 'Semicolon', 187: 'Equal', 188: 'Comma', 189: 'Minus',
            190: 'Period', 191: 'Slash', 192: 'Backtick', 219: 'BracketLeft',
            220: 'Backslash', 221: 'BracketRight', 222: 'Quote',

            // Arrow Keys
            37: 'ArrowLeft', 38: 'ArrowUp', 39: 'ArrowRight', 40: 'ArrowDown',

            // System Keys
            91: 'Meta', 93: 'ContextMenu', 19: 'PauseBreak',
            45: 'Insert', 46: 'Delete', 36: 'Home', 35: 'End',
            33: 'PageUp', 34: 'PageDown'
        },

        /**
         * Converts a string key identifier to its corresponding key code.
         * @param {String} keyStr - The string representation of the key.
         * @returns {Number} - The corresponding key code.
         */
        getKeyCode: function(keyStr) {
            for (const [code, str] of Object.entries(this.KeyMapJS)) {
                if (str === keyStr) {
                    return Number(code);
                }
            }
            console.error(`Unknown key string: ${keyStr}`);
            return null;
        },

        /**
         * Returns the string identifier for a given key code.
         * @param {Number} keyCode - The key code to look up.
         * @returns {String} - The string identifier for the key.
         */
        getKeyString: function(keyCode) {
            return this.KeyMapJS[keyCode] || `Unknown key code: ${keyCode}`;
        }
    }

    /**
     * Keybind class representing an individual keybind.
     * @param {String} modID - The ID of the mod.
     * @param {String} id - The ID of the keybind.
     * @param {Array} keyCombinations - Array of key combinations.
     */
    Keybind: function(modID, id, keyCombinations) {
        this.modID = modID;
        this.id = id;
        this.keyCombinations = keyCombinations;

        /**
         * Checks if the provided key is part of this keybind's combinations.
         * @param {String} key - The key to check.
         * @returns {Boolean} - True if the key is part of the combination, false otherwise.
         */
        this.isKeyCombinationPressed = function(key) {
            return this.keyCombinations.includes(key);
        };

        /**
         * Gets the raw key combinations for this keybind.
         * @returns {Array} - Array of key combinations.
         */
        this.getRawKeyCombinations = function() {
            return this.keyCombinations;
        };
    }
};

// Global alias to maintain access to FU.Keybinds as a top-level object
window.FUKeybinds = FU.Keybinds;
window.FUKey = FU.Key;

// Compatibility wrappers to support old function calls
window.addKeybindFromSQ = function(_modID, _id, _keyCombinations) {
    return FU.Keybinds.addKeybindFromSQ(_modID, _id, _keyCombinations);
};

window.removeKeybind = function(_modID, _id) {
    return FU.Keybinds.removeKeybind(_modID, _id);
};

window.getPressedKeysAsString = function(_excludeKey) {
    return FU.Keybinds.getPressedKeysAsString(_excludeKey);
};

// Mapping old global KeyMapJS to the new location
window.KeyMapJS = FU.Key.KeyMapJS;

// For legacy code that accesses KeyMapJS directly
window.getKeyCode = function(keyStr) {
    return FU.Key.getKeyCode(keyStr);
};

window.getKeyString = function(keyCode) {
    return FU.Key.getKeyString(keyCode);
};
