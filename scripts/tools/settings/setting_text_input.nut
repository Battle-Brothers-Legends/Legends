/**
 * Class representing a TextInputSetting.
 * A setting that holds a text input value, which can be a string, integer, or float.
 */
class TextInputSetting extends TemplateSetting {
     Type = "TextInput";

    /**
     * Constructor for TextInputSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {string|integer|float} - The value of the setting.
     * @param _name {string} - The name of the setting (optional).
     * @param _description {string} - The description of the setting (optional).
     */
    constructor(_id, _value, _name = null, _description = null) {
        requireOneFromTypes(["string", "integer", "float"], _value);
        base.constructor(_id, _value, _name, _description);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {string} - The new value to set.
     * @param _updateJS {bool} - Whether to update JavaScript.
     * @param _updatePersistence {bool} - Whether to update persistence.
     * @param _updateBeforeChangeCallback {bool} - Whether to update before change callback.
     * @param _force {bool} - Whether to force the update.
     * @param _updateAfterChangeCallback {bool} - Whether to update after change callback.
     */
    function set(_newValue, _updateJS = true, _updatePersistence = true, _updateBeforeChangeCallback = true, _force = false, _updateAfterChangeCallback = true) {
        requireString(_newValue);
        return base.set(_newValue, _updateJS, _updatePersistence, _updateBeforeChangeCallback, _force, _updateAfterChangeCallback);
    }

    /**
     * Gets the current value of the setting.
     * @returns {string|integer|float} - The current value.
     */
    function get() {
        return this.Value;
    }
}

// Alias for backward compatibility
::MSU.Class.StringSetting <- TextInputSetting



// Test case for TextInputSetting
function testTextInputSetting() {
    // Creating a new TextInputSetting
    local textSetting = TextInputSetting("testID", "testValue");

    // Asserting initial value
    assert(textSetting.get() == "testValue", "Initial value should be 'testValue'");

    // Setting and asserting new value
    textSetting.set("newTestValue");
    assert(textSetting.get() == "newTestValue", "New value should be 'newTestValue'");

    // Serializing and deserializing the setting
    local serializedData = textSetting.serialize();
    local newTextSetting = TextInputSetting("testID", "");
    newTextSetting.deserialize(serializedData);
    assert(newTextSetting.get() == "newTestValue", "Deserialized value should be 'newTestValue'");

    // Asserting ID, name, and description
    assert(newTextSetting.getID() == "testID", "ID should be 'testID'");
    assert(newTextSetting.getName() == null, "Name should be null by default");
    assert(newTextSetting.getDescription() == null, "Description should be null by default");

    // Setting and asserting name and description
    newTextSetting.setName("Test Name");
    newTextSetting.setDescription("Test Description");
    assert(newTextSetting.getName() == "Test Name", "Name should be 'Test Name'");
    assert(newTextSetting.getDescription() == "Test Description", "Description should be 'Test Description'");

    print("All tests passed!");
}

// Run test case
//testTextInputSetting();

