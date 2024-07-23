/**
 * Class representing a ButtonSetting.
 * This class provides functionalities for managing button settings, including simulating button presses.
 */
class ButtonSetting extends TemplateSetting {
    /**
     * Constructor for ButtonSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _name = null, _description = null) {
        super(_id, null, _name, _description);
    }

    /**
     * Simulates a button press.
     */
    function press() {
        foreach (callback in this.Callbacks.BeforeChange) {
            callback.call(this);
        }

        // Button specific logic

        foreach (callback in this.Callbacks.AfterChange) {
            callback.call(this);
        }
    }

    // Dummy overwrites as buttons don't implement serialization
    function serialize() {}
    function deserialize(_data) {}

    // Getters and setters for QoL and compatibility

    /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */
    function getID() {
        return super.getID();
    }

    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return super.getName();
    }

    /**
     * Gets the description of the setting.
     * @returns {string} - The description of the setting.
     */
    function getDescription() {
        return super.getDescription();
    }

    /**
     * Sets the description of the setting.
     * @param _description {string} - The description to set.
     */
    function setDescription(_description) {
        super.setDescription(_description);
    }

    /**
     * Converts the setting to a string representation.
     * @returns {string} - A string representation of the setting.
     */
    function tostring() {
        return super.tostring();
    }
}

// Alias for backward compatibility
FU.Class.ButtonSetting <- ButtonSetting;

/**
 * Example implementation and test case for ButtonSetting
 */
// Example Implementation
local buttonSetting = ButtonSetting("buttonID", "Button Setting", "This is a button setting.");
print(buttonSetting.tostring());

// Test Case
function testButtonSetting() {
    local setting = ButtonSetting("testButtonID", "Test Button Setting", "A setting used for testing buttons.");
    assert(setting.getID() == "testButtonID");
    assert(setting.getName() == "Test Button Setting");

    setting.press();
    print("Button pressed: " + setting.getID());

    setting.setDescription("Updated description");
    assert(setting.getDescription() == "Updated description");
}

testButtonSetting();

