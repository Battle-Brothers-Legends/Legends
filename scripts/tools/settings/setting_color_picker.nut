/**
 * Class representing a ColorPickerSetting.
 */
::FU.Class.ColorPickerSetting <- class extends ::FU.Class.TemplateSetting{
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
 * Example implementation and test case for ColorPickerSetting
 */
// Example Implementation
//local colorPickerSetting = ColorPickerSetting("colorID", "255,0,0,1", "Color Picker Setting", "This is a color picker setting.");
//print(colorPickerSetting.tostring());

// Test Case
function testColorPickerSetting() {
    local setting = ColorPickerSetting("testColorID", "0,128,255,0.5", "Test Color Picker Setting", "A setting used for testing color pickers.");
    assert(setting.getID() == "testColorID");
    assert(setting.getValue() == "0,128,255,0.5");
    assert(setting.getName() == "Test Color Picker Setting");

    local rgba = setting.getValueAsRGBA();
    assert(rgba == "rgba(0, 128, 255, 0.5)");

    local hex = setting.getValueAsHexString();
    assert(hex == "0080ff80");

    local tableValue = setting.getValueAsTable();
    assert(tableValue.Red == "0");
    assert(tableValue.Green == "128");
    assert(tableValue.Blue == "255");
    assert(tableValue.Alpha == "0.5");

    setting.setValue("255,0,0,1");
    assert(setting.getValue() == "255,0,0,1");
}

//testColorPickerSetting();
