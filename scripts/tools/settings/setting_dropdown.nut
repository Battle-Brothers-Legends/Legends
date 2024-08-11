/**
 * Class representing a DropdownSetting.
 * This class handles the creation, display, and interaction with a dropdown-based setting.
 */
::FU.Class.DropdownSetting <- class extends ::FU.Class.TemplateSetting{
    static Type = "Dropdown";
    Array = null;
    /**
     * Constructor for DropdownSetting.
     * @param {string} _id - The unique identifier for the setting.
     * @param {variant} _value - The value of the setting.
     * @param {array} _array - The array of possible values.
     * @param {string} [_name=null] - The name of the setting.
     * @param {string} [_description=null] - The description of the setting.
     */
    constructor(_id, _value, _array, _name = null, _description = null) {
        if (_array.find(_value) == null) {
            logError("_value must be an element in _array");
            throw Exception.KeyNotFound(_value);
        }
        base.constructor(_id, _value, _name, _description);
        this.Array = _array;
    }

    /**
     * Gets the UI data for the setting.
     * @param {array} [_flags=[]] - The flags to filter the UI data.
     * @returns {table} - The UI data for the setting.
     */
    function getUIData(_flags = []) {
        local ret = base.getUIData(_flags);
        ret.array <- this.Array;
        return ret;
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        local ret = base.tostring() + " | Array: \n";
        foreach (value in this.Array) {
            ret += value + "\n";
        }
        return ret;
    }

    /**
     * Deserializes the setting from provided data.
     * @param {variant} _in - The data to deserialize from.
     */
    function flagDeserialize(_in) {
        base.flagDeserialize(_in);
        if (this.Array.find(this.Value) == null) {
            logError("Value '" + this.Value + "' not contained in array for setting " + this.getID() + " in mod " + this.getMod().getID());
            this.Value = this.Array[0];
        }
    }
}

// Alias for backward compatibility
//::MSU.Class.EnumSetting <- ::DropdownSetting;

// Example test case for DropdownSetting
function testDropdownSetting() {
    try {
        local dropdown = DropdownSetting("testDropdown", "value1", ["value1", "value2", "value3"], "Test Dropdown", "This is a test dropdown setting.");
        print(dropdown.tostring());

        dropdown.set("value2");
        print("Updated value: " + dropdown.get());

        local uiData = dropdown.getUIData();
        print("UI Data: " + uiData);

        dropdown.flagDeserialize(["value2"]);
        print("Deserialized value: " + dropdown.get());
    } catch (e) {
        print("Error: " + e);
    }
}

testDropdownSetting();

