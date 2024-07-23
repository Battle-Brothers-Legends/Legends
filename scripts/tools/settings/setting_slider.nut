/**
 * Class representing a SliderSetting.
 * This class extends the TemplateSetting class to provide additional functionality specific to slider settings.
 */
class SliderSetting extends TemplateSetting {
    Min = null;
    Max = null;
    Step = null;

    /**
     * Constructor for SliderSetting.
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
        super(_id, _value, _name, _description);
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
        super.set(_newValue);
    }

    /**
     * Gets the minimum value for the range.
     * @returns {integer|float} - The minimum value.
     */
    function getMin() {
        return this.Min;
    }

    /**
     * Sets the minimum value for the range.
     * @param _min {integer|float} - The minimum value to set.
     */
    function setMin(_min) {
        requireOneFromTypes(["integer", "float"], _min);
        this.Min = _min;
    }

    /**
     * Gets the maximum value for the range.
     * @returns {integer|float} - The maximum value.
     */
    function getMax() {
        return this.Max;
    }

    /**
     * Sets the maximum value for the range.
     * @param _max {integer|float} - The maximum value to set.
     */
    function setMax(_max) {
        requireOneFromTypes(["integer", "float"], _max);
        this.Max = _max;
    }

    /**
     * Gets the step value for the range.
     * @returns {integer|float} - The step value.
     */
    function getStep() {
        return this.Step;
    }

    /**
     * Sets the step value for the range.
     * @param _step {integer|float} - The step value to set.
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
        return format("SliderSetting %s: %s (Min: %s, Max: %s, Step: %s)", this.getName(), this.getValue(), this.getMin(), this.getMax(), this.getStep());
    }
}

// Alias for backward compatibility
::MSU.Class.RangeSetting <- SliderSetting;


// Test Case
function testSliderSetting() {
    local setting = SliderSetting("testSliderID", 5, 0, 10, 0.5, "Test Slider Setting", "A setting used for testing sliders.");
    assert(setting.getID() == "testSliderID");
    assert(setting.getValue() == 5);
    assert(setting.getMin() == 0);
    assert(setting.getMax() == 10);
    assert(setting.getStep() == 0.5);

    setting.setValue(7);
    assert(setting.getValue() == 7);

    setting.setMin(-5);
    assert(setting.getMin() == -5);

    setting.setMax(15);
    assert(setting.getMax() == 15);

    setting.setStep(1);
    assert(setting.getStep() == 1);

    // Test with invalid value (out of range)
    try {
        setting.setValue(20);
    } catch (e) {
        print("Caught expected exception: " + e);
    }
}

//testSliderSetting();

