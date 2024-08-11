function requireBool(value) {
    if (typeof value != "bool") {
        throw "Expected boolean, got " + typeof value;
    }
}


/**
 * Class representing a ToggleSetting.
 * A setting that holds a boolean value (true/false).
 */
::FU.Class.ToggleSetting <- class extends ::FU.Class.TemplateSetting{
    Type = "Toggle";

    /**
     * Constructor for ToggleSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {bool} - The value of the setting.
     * @param _name {string} - The name of the setting (optional).
     * @param _description {string} - The description of the setting (optional).
     */
    constructor(_id, _value, _name = null, _description = null) {
       requireBool(_value);
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
::FU.Class.BooleanSetting <- ::FU.Class.ToggleSetting

// Test case for ToggleSetting
function testToggleSetting() {
    // Creating a new ToggleSetting
    local toggleSetting = ToggleSetting("testID", true);

    // Logging initial values
    this.logInfo("Initial value is 'true': " + (toggleSetting.get() == true));

    // Setting and logging new values
    toggleSetting.set(false);
    this.logInfo("New value is 'false': " + (toggleSetting.get() == false));

    // Toggling and logging values
    toggleSetting.toggle();
    this.logInfo("Toggled value is 'true': " + (toggleSetting.get() == true));
    toggleSetting.toggle();
    this.logInfo("Toggled value is 'false': " + (toggleSetting.get() == false));

    // Serializing and deserializing the setting
    local serializedData = toggleSetting.serialize();
    local newToggleSetting = ToggleSetting("testID", false);
    newToggleSetting.deserialize(serializedData);
    this.logInfo("Deserialized value is 'false': " + (newToggleSetting.get() == false));

    // Logging ID, name, and description
    this.logInfo("ID is 'testID': " + (newToggleSetting.getID() == "testID"));
    this.logInfo("Name is null by default: " + (newToggleSetting.getName() == null));
    this.logInfo("Description is null by default: " + (newToggleSetting.getDescription() == null));

    // Setting and logging name and description
    newToggleSetting.setName("Test Name");
    newToggleSetting.setDescription("Test Description");
    this.logInfo("Name is 'Test Name': " + (newToggleSetting.getName() == "Test Name"));
    this.logInfo("Description is 'Test Description': " + (newToggleSetting.getDescription() == "Test Description"));

     this.logInfo("All toggle tests passed!");
}

// Run test case
//testToggleSetting();

