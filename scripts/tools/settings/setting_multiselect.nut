/**
 * Class representing a MultiselectSetting.
 * A setting that holds multiple selectable values, which can be strings, integers, or floats.
 */

::FU.Class.MultiselectSetting <- class extends ::FU.Class.TemplateSetting{
     Type = "Multiselect";

    /**
     * Constructor for MultiselectSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {array} - The array of selectable values.
     * @param _name {string} - The name of the setting (optional).
     * @param _description {string} - The description of the setting (optional).
     * @param _lockLength {bool} - Whether to lock the length of the array (optional).
     */
    constructor(_id, _value, _name = null, _description = null, _lockLength = false) {
        requireArray(_value);
        for (local i = 0; i < _value.len(); ++i) {
            requireOneFromTypes(["string", "integer", "float", "array"], _value[i]);
            if (typeof _value[i] != "array") {
                _value[i] = [i, _value[i]];
            } else {
                if (_value[i].len() != 2) throw Exception.InvalidType(_value[i]);
                requireOneFromTypes(["string", "integer", "float"], _value[i][0]);
                requireOneFromTypes(["string", "integer", "float"], _value[i][1]);
            }
        }
        base.constructor(_id, _value, _name, _description);
        this.lockLength(_lockLength);
    }

    /**
     * Locks or unlocks the length of the array.
     * @param _lockLength {bool} - Whether to lock the length of the array.
     */
    function lockLength(_lockLength) {
        this.Data.lockLength = _lockLength;
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        local ret = "Type: " + this.getType() + " | ID: " + this.getID() + " | Name: " + this.getName() + " | Values: \n";
        foreach (value in this.Value) {
            ret += (value[0] == null ? "null" : value[0]) + " : " + value[1] + "\n";
        }
        return ret;
    }
}

// Alias for backward compatibility
//::MSU.Class.ArraySetting <- MultiselectSetting

// Test case for MultiselectSetting
function testMultiselectSetting() {
    // Creating a new MultiselectSetting
    local multiSelect = MultiselectSetting("testID", [["Option1", "Value1"], ["Option2", "Value2"]]);

    // Asserting initial values
    assert(multiSelect.get()[0][1] == "Value1", "Initial value should be 'Value1'");
    assert(multiSelect.get()[1][1] == "Value2", "Initial value should be 'Value2'");

    // Setting and asserting new values
    multiSelect.set([["Option1", "NewValue1"], ["Option2", "NewValue2"]]);
    assert(multiSelect.get()[0][1] == "NewValue1", "New value should be 'NewValue1'");
    assert(multiSelect.get()[1][1] == "NewValue2", "New value should be 'NewValue2'");

    // Serializing and deserializing the setting
    local serializedData = multiSelect.serialize();
    local newMultiSelect = MultiselectSetting("testID", []);
    newMultiSelect.deserialize(serializedData);
    assert(newMultiSelect.get()[0][1] == "NewValue1", "Deserialized value should be 'NewValue1'");
    assert(newMultiSelect.get()[1][1] == "NewValue2", "Deserialized value should be 'NewValue2'");

    // Asserting ID, name, and description
    assert(newMultiSelect.getID() == "testID", "ID should be 'testID'");
    assert(newMultiSelect.getName() == null, "Name should be null by default");
    assert(newMultiSelect.getDescription() == null, "Description should be null by default");

    // Setting and asserting name and description
    newMultiSelect.setName("Test Name");
    newMultiSelect.setDescription("Test Description");
    assert(newMultiSelect.getName() == "Test Name", "Name should be 'Test Name'");
    assert(newMultiSelect.getDescription() == "Test Description", "Description should be 'Test Description'");

    print("All tests passed!");
}

// Run test case
//testMultiselectSetting();

