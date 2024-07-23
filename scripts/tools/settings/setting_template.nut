/**
 * Class representing a generic TemplateSetting.
 */
class TemplateSetting {
    ID = null;
    Name = null;
    Value = null;
    Description = null;
    Persistence = true;
    Callbacks = {
        BeforeChange = [],
        AfterChange = []
    };

    // Class property for Type
    Type = "Template";

    /**
     * Constructor for TemplateSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {variant} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    function constructor(_id, _value, _name = null, _description = null) {
        this.ID = _id;
        this.Value = _value;
        this.Name = _name ? _name : _id;
        this.Description = _description ? _description : "";
    }

    /**
     * Adds a callback function for a specific event type.
     * @param _type {string} - The type of the callback ("BeforeChange" or "AfterChange").
     * @param _callback {function} - The callback function to add.
     */
    function addCallback(_type, _callback) {
        this.Callbacks[_type].push(_callback);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {variant} - The new value to set.
     */
    function set(_newValue) {
        foreach (callback in this.Callbacks.BeforeChange) {
            callback.call(this, _newValue);
        }

        local oldValue = this.Value;
        this.Value = _newValue;

        foreach (callback in this.Callbacks.AfterChange) {
            callback.call(this, oldValue);
        }
    }

    /**
     * Gets the current value of the setting.
     * @returns {variant} - The current value.
     */
    function get() {
        return this.Value;
    }

    /**
     * Serializes the setting if persistence is enabled.
     */
    function serialize() {
        if (this.Persistence) {
            // Serialization logic
        }
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        if (this.Persistence) {
            // Deserialization logic
        }
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
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Value;
    }

    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.set(_value);
    }

    /**
     * Gets the description of the setting.
     * @returns {string} - The description of the setting.
     */
    function getDescription() {
        return this.Description;
    }

    /**
     * Sets the description of the setting.
     * @param _description {string} - The description to set.
     */
    function setDescription(_description) {
        this.Description = _description;
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return format("Setting %s: %s", this.getName(), this.getValue());
    }
}


// Test Case
function testTemplateSetting() {
    local setting = createTemplateSetting("testID", 42, "Test Setting", "A setting used for testing.");
    assert(setting.getID() == "testID");
    assert(setting.getValue() == 42);
    assert(setting.getName() == "Test Setting");
    assert(setting.getDescription() == "A setting used for testing.");

    setting.setValue(100);
    assert(setting.getValue() == 100);
}

//testTemplateSetting();

