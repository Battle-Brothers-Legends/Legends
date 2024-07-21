class ModSettingsSystem extends System {
    SettingsByMod = {};

    /**
     * Constructor for the ModSettingsSystem class.
     */
    constructor() {
        base.constructor(SystemID.ModSettings);
    }

    /**
     * Registers a mod with the mod settings system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        base.registerMod(_mod);
        this.SettingsByMod[_mod.getID()] <- {};
    }

    /**
     * Adds a setting for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _setting {Setting} - The setting to add.
     */
    function addSetting(_modID, _setting) {
        this.SettingsByMod[_modID][_setting.getID()] <- _setting;
    }

    /**
     * Gets a setting for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _settingID {string} - The ID of the setting.
     * @returns {Setting} - The requested setting.
     */
    function getSetting(_modID, _settingID) {
        return this.SettingsByMod[_modID][_settingID];
    }

    /**
     * Sets a setting value from persistent data.
     * @param _modID {string} - The ID of the mod.
     * @param _settingID {string} - The ID of the setting.
     * @param _value {any} - The value to set.
     */
    function setSettingFromPersistence(_modID, _settingID, _value) {
        if (_settingID in this.SettingsByMod[_modID]) {
            this.SettingsByMod[_modID][_settingID].setValue(_value);
        }
    }

    /**
     * Retrieves all settings for a mod.
     * @param _modID {string} - The ID of the mod.
     * @returns {array} - An array of all settings for the mod.
     */
    function getSettings(_modID) {
        local settings = [];
        foreach (settingID, setting in this.SettingsByMod[_modID]) {
            settings.append(setting);
        }
        return settings;
    }
}

