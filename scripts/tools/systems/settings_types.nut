/**
 * Class representing a generic Setting.
 */
class Setting {
    ID = null;
    Name = null;
    Value = null;
    Description = null;
    Persistence = true;
    Callbacks = {
        BeforeChange = [],
        AfterChange = []
    };

    /**
     * Constructor for Setting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {variant} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _name = null, _description = null) {
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
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return format("Setting %s: %s", this.getName(), this.getValue());
    }

}

/**
 * Class representing a StringSetting.
 */
class StringSetting {
    Setting = null;

    /**
     * Constructor for StringSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {string|integer|float} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _name = null, _description = null) {
        requireOneFromTypes(["string", "integer", "float"], _value);
        this.Setting = Setting(_id, _value, _name, _description);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {string} - The new value to set.
     */
    function set(_newValue) {
        requireString(_newValue);
        this.Setting.set(_newValue);
    }

    /**
     * Gets the current value of the setting.
     * @returns {string} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }

//Getters and setters for QoL and compatibility// 

     /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */    
    function getID() {
        return this.Setting.getID();
    }
    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Setting.getName();
    }
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
      /**
     * Gets the description of the setting.
     * @returns {variant} - The description of the setting.
     */  
       function getDescription() {
        return this.Setting.Description;
    }
     /**
     * Sets the description of the setting.
     * @param _description {variant} - The description to set.
     */   
    function setDescription(_description) {
        this.Setting.Description = _description;
    }    
    
    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return this.Setting.tostring();
    }

}

/**
 * Class representing a BooleanSetting.
 */
class BooleanSetting {
    Setting = null;

    /**
     * Constructor for BooleanSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {bool} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _name = null, _description = null) {
        requireBool(_value);
        this.Setting = Setting(_id, _value, _name, _description);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {bool} - The new value to set.
     */
    function set(_newValue) {
        requireBool(_newValue);
        this.Setting.set(_newValue);
    }

    /**
     * Gets the current value of the setting.
     * @returns {bool} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Toggles the current value of the setting.
     */
    function toggle() {
        this.Setting.set(!this.Setting.get());
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }

//Getters and setters for QoL and compatibility// 

     /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */    
    function getID() {
        return this.Setting.getID();
    }
    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Setting.getName();
    }
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
     /**
     * Gets the description of the setting.
     * @returns {variant} - The description of the setting.
     */  
       function getDescription() {
        return this.Setting.Description;
    }
     /**
     * Sets the description of the setting.
     * @param _description {variant} - The description to set.
     */   
    function setDescription(_description) {
        this.Setting.Description = _description;
    }     
    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return this.Setting.tostring();
    }
}

/**
 * Class representing a RangeSetting.
 */
class RangeSetting {
    Setting = null;
    Min = null;
    Max = null;
    Step = null;

    /**
     * Constructor for RangeSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {integer|float} - The value of the setting.
     * @param _min {integer|float} - The minimum value for the range.
     * @param _max {integer|float} - The maximum value for the range.
     * @param _step {integer|float} - The step value for the range.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _min, _max, _step, _name = null, _description = null) {
        requireOneFromTypes(["integer", "float"], _min, _max, _step);
        this.Setting = Setting(_id, _value, _name, _description);
        this.Min = _min;
        this.Max = _max;
        this.Step = _step;
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {integer|float} - The new value to set.
     */
    function set(_newValue) {
        requireOneFromTypes(["integer", "float"], _newValue);
        if (_newValue < this.Min || _newValue > this.Max) {
            throw Exception.InvalidValue(_newValue);
        }
        this.Setting.set(_newValue);
    }

    /**
     * Gets the current value of the setting.
     * @returns {integer|float} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Gets the minimum value for the range.
     * @returns {integer|float} - The minimum value.
     */
    function getMin() {
        return this.Min;
    }

    /**
     * Gets the maximum value for the range.
     * @returns {integer|float} - The maximum value.
     */
    function getMax() {
        return this.Max;
    }

    /**
     * Gets the step value for the range.
     * @returns {integer|float} - The step value.
     */
    function getStep() {
        return this.Step;
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }
    
     //Getters and setters for QoL and compatibility// 

     /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */    
    function getID() {
        return this.Setting.getID();
    }
    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Setting.getName();
    }
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
     /**
     * Gets the description of the setting.
     * @returns {variant} - The description of the setting.
     */  
       function getDescription() {
        return this.Setting.Description;
    }
     /**
     * Sets the description of the setting.
     * @param _description {variant} - The description to set.
     */   
    function setDescription(_description) {
        this.Setting.Description = _description;
    }    
      /**
     * Sets the minimum value for the range.
     */  
     function setMin(_min) {
        requireOneFromTypes(["integer", "float"], _min);
        this.Min = _min;
    }
    /**
     * Sets the maximum value for the range.
     */
    function setMax(_max) {
        requireOneFromTypes(["integer", "float"], _max);
        this.Max = _max;
    }
    /**
     * Gets the step value for the range.
     */
    function setStep(_step) {
        requireOneFromTypes(["integer", "float"], _step);
        this.Step = _step;
    }   
     
    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return this.Setting.tostring();
    }
}

/**
 * Class representing a ColorPickerSetting.
 */
class ColorPickerSetting {
    Setting = null;

    /**
     * Constructor for ColorPickerSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {string} - The value of the setting in RGBA format.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _name = null, _description = null) {
        _value = String.replace(_value, " ", "", true);
        this.Setting = Setting(_id, _value, _name, _description);
    }

    /**
     * Gets the value as a table of RGBA components.
     * @returns {table} - The RGBA components.
     */
    function getValueAsTable() {
        local asArray = split(this.Setting.get(), ",");
        local asTable = {
            Red = asArray[0],
            Green = asArray[1],
            Blue = asArray[2],
            Alpha = asArray[3]
        };
        return asTable;
    }

    /**
     * Gets the value as an RGBA string.
     * @returns {string} - The RGBA string.
     */
    function getValueAsRGBA() {
        local asRGBA = "rgba(";
        local asArray = split(this.Setting.get(), ",");
        asRGBA += asArray[0] + ", ";
        asRGBA += asArray[1] + ", ";
        asRGBA += asArray[2] + ", ";
        asRGBA += asArray[3] + ");";
        return asRGBA;
    }

    /**
     * Gets the value as a hexadecimal string.
     * @returns {string} - The hexadecimal string.
     */
    function getValueAsHexString() {
        local asArray = split(this.Setting.get(), ",");
        local red = format("%x", asArray[0].tointeger());
        local green = format("%x", asArray[1].tointeger());
        local blue = format("%x", asArray[2].tointeger());
        local opacity = format("%x", (asArray[3].tofloat() * 255).tointeger());
        if (red.len() == 1) red = "0" + red;
        if (green.len() == 1) green = "0" + green;
        if (blue.len() == 1) blue = "0" + blue;
        if (opacity.len() == 1) opacity = "0" + opacity;
        return red + green + blue + opacity;
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {string} - The new value to set.
     */
    function set(_newValue) {
        _newValue = String.replace(_newValue, " ", "", true);
        this.Setting.set(_newValue);
    }

    /**
     * Gets the current value of the setting.
     * @returns {string} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }
     //Getters and setters for QoL and compatibility// 

     /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */    
    function getID() {
        return this.Setting.getID();
    }
    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Setting.getName();
    }
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
     /**
     * Gets the description of the setting.
     * @returns {variant} - The description of the setting.
     */  
       function getDescription() {
        return this.Setting.Description;
    }
     /**
     * Sets the description of the setting.
     * @param _description {variant} - The description to set.
     */   
    function setDescription(_description) {
        this.Setting.Description = _description;
    }    
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
    
    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return this.Setting.tostring();
    }
}

/**
 * Class representing a ButtonSetting.
 */
class ButtonSetting {
    Setting = null;

    /**
     * Constructor for ButtonSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _name = null, _description = null) {
        this.Setting = Setting(_id, null, _name, _description);
    }

    /**
     * Simulates a button press.
     */
    function press() {
        foreach (callback in this.Setting.Callbacks.BeforeChange) {
            callback.call(this.Setting);
        }

        // Button specific logic
    }

    // Dummy overwrites as buttons don't implement serialization
    function serialize() {}
    function deserialize(_data) {}
    
    function getID() {
        return this.Setting.getID();
    }

    function getName() {
        return this.Setting.getName();
    }

    function getDescription() {
        return this.Setting.Description;
    }

    function setDescription(_description) {
        this.Setting.Description = _description;
    }

    function tostring() {
        return this.Setting.tostring();
    }    
}


/**
 * Class representing an EnumSetting.
 */
class EnumSetting {
    Setting = null;
    Array = null;

    /**
     * Constructor for EnumSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {variant} - The value of the setting.
     * @param _array {array} - The array of possible values.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _value, _array, _name = null, _description = null) {
        if (_array.find(_value) == null) {
            logError("_value must be an element in _array");
            throw Exception.KeyNotFound(_value);
        }
        this.Setting = Setting(_id, _value, _name, _description);
        this.Array = _array;
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {variant} - The new value to set.
     */
    function set(_newValue) {
        if (this.Array.find(_newValue) == null) {
            logError("_value must be an element in _array");
            throw Exception.KeyNotFound(_newValue);
        }
        this.Setting.set(_newValue);
    }

    /**
     * Gets the current value of the setting.
     * @returns {variant} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }
    function getID() {
        return this.Setting.getID();
    }

    function getName() {
        return this.Setting.getName();
    }

    function getValue() {
        return this.Setting.getValue();
    }

    function setValue(_value) {
        this.Setting.setValue(_value);
    }

    function getDescription() {
        return this.Setting.Description;
    }

    function setDescription(_description) {
        this.Setting.Description = _description;
    }

    function getArray() {
        return this.Array;
    }

    function setArray(_array) {
        this.Array = _array;
    }

    function tostring() {
        return this.Setting.tostring();
    }


}


/**
 * Class representing an ArraySetting.
 */
class ArraySetting {
    Setting = null;

    /**
     * Constructor for ArraySetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {array} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     * @param _lockLength {boolean} - Whether to lock the length of the array.
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
        this.Setting = Setting(_id, _value, _name, _description);
        this.lockLength(_lockLength);
    }

    /**
     * Locks or unlocks the length of the array.
     * @param _lockLength {boolean} - Whether to lock the length.
     */
    function lockLength(_lockLength) {
        this.Setting.Data.lockLength <- _lockLength;
    }

    /**
     * Gets the current value of the setting.
     * @returns {array} - The current value.
     */
    function get() {
        return this.Setting.get();
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {array} - The new value to set.
     */
    function set(_newValue) {
        requireArray(_newValue);
        this.Setting.set(_newValue);
    }

    /**
     * Serializes the setting.
     */
    function serialize() {
        this.Setting.serialize();
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        this.Setting.deserialize(_data);
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - The string representation.
     */
   function tostring() {
        local ret = "Type: " + this.Setting.getType() + " | ID: " + this.Setting.getID() + " | Name: " + this.Setting.getName() + " | Values: \n";
        foreach (value in this.Setting.get()) {
            ret += (value[0] == null ? "null" : value[0]) + " : " + value[1] + "\n";
        }
        return ret;
    }
    //Getters and setters for QoL and compatibility// 

     /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */    
    function getID() {
        return this.Setting.getID();
    }
    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Setting.getName();
    }
    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Setting.getValue();
    }
    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.Setting.setValue(_value);
    }
    
}


