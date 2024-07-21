/**
 * Settings class
 * 
 * This class represents a mod setting.
 */
class Setting {
    ID = null;
    Name = null;
    Value = null;

    /**
     * Constructor for the Setting class.
     * @param _id {string} - The unique identifier for the setting.
     * @param _name {string} - The display name of the setting.
     * @param _value {any} - The value of the setting.
     */
    constructor(_id, _name, _value) {
        requireString(_id, _name);
        this.ID = _id;
        this.Name = _name;
        this.Value = _value;
    }

    /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the value of the setting.
     * @returns {any} - The value of the setting.
     */
    function getValue() {
        return this.Value;
    }

    /**
     * Sets the value of the setting.
     * @param _value {any} - The value to set.
     */
    function setValue(_value) {
        this.Value = _value;
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return format("Setting %s: %s", this.getName(), this.getValue());
    }
}

//unit test for settings
function testModSettingsSystem() {
    local modSettingsSystem = ModSettingsSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    modSettingsSystem.registerMod(mod);

    local setting = Setting("Setting1", "First Setting", "DefaultValue");
    modSettingsSystem.addSetting("TestMod", setting);

    assert(modSettingsSystem.getSetting("TestMod", "Setting1") == setting);

    modSettingsSystem.setSettingFromPersistence("TestMod", "Setting1", "NewValue");
    assert(modSettingsSystem.getSetting("TestMod", "Setting1").getValue() == "NewValue");

    print("ModSettingsSystem class tests passed.");
}

// Run the test
// testModSettingsSystem();

