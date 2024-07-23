/**
 * Class representing a ToggleSetting.
 * A setting that holds a boolean value (true/false).
 */
class ToggleSetting extends TemplateSetting {
    Type = "Toggle";

    /**
     * Constructor for ToggleSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {bool} - The value of the setting.
     * @param _name {string} - The name of the setting (optional).
     * @param _description {string} - The description of the setting (optional).
     */
    constructor(_id, _value, _name = null, _description = null) {
        ::FU.requireBool(_value);
        base.constructor(_id, _value, _name, _description);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {bool} - The new value to set.
     * @param _updateJS {bool} - Whether to update JavaScript (optional, default: true).
     * @param _updatePersistence {bool} - Whether to update persistence (optional, default: true).
     * @param _updateBeforeChangeCallback {bool} - Whether to update before change callback (optional, default: true).
     * @param _force {bool} - Whether to force the update (optional, default: false).
     * @param _updateAfterChangeCallback {bool} - Whether to update after change callback (optional, default: true).
     * @returns {variant} - The updated value.
     */
    function set(_newValue, _updateJS = true, _updatePersistence = true, _updateBeforeChangeCallback = true, _force = false, _updateAfterChangeCallback = true) {
        ::FU.requireBool(_newValue);
        return base.set(_newValue, _updateJS, _updatePersistence, _updateBeforeChangeCallback, _force, _updateAfterChangeCallback);
    }

    /**
     * Toggles the value of the setting between true and false.
     */
    function toggle() {
        this.set(!this.Value);
    }
}

// Alias for backward compatibility
::MSU.Class.BooleanSetting <- ToggleSetting

// Test case for ToggleSetting
function testToggleSetting() {
    // Creating a new ToggleSetting
    local toggleSetting = ToggleSetting("testID", true);

    // Asserting initial values
    assert(toggleSetting.get() == true, "Initial value should be 'true'");

    // Setting and asserting new values
    toggleSetting.set(false);
    assert(toggleSetting.get() == false, "New value should be 'false'");

    // Toggling and asserting values
    toggleSetting.toggle();
    assert(toggleSetting.get() == true, "Toggled value should be 'true'");
    toggleSetting.toggle();
    assert(toggleSetting.get() == false, "Toggled value should be 'false'");

    // Serializing and deserializing the setting
    local serializedData = toggleSetting.serialize();
    local newToggleSetting = ToggleSetting("testID", false);
    newToggleSetting.deserialize(serializedData);
    assert(newToggleSetting.get() == false, "Deserialized value should be 'false'");

    // Asserting ID, name, and description
    assert(newToggleSetting.getID() == "testID", "ID should be 'testID'");
    assert(newToggleSetting.getName() == null, "Name should be null by default");
    assert(newToggleSetting.getDescription() == null, "Description should be null by default");

    // Setting and asserting name and description
    newToggleSetting.setName("Test Name");
    newToggleSetting.setDescription("Test Description");
    assert(newToggleSetting.getName() == "Test Name", "Name should be 'Test Name'");
    assert(newToggleSetting.getDescription() == "Test Description", "Description should be 'Test Description'");

    print("All tests passed!");
}

// Run test case
testToggleSetting();

