/**
 * Class representing a ButtonSetting.
 * This class provides functionalities for managing button settings, including simulating button presses.
 */
class ButtonSetting extends ::FU.Class.TemplateSetting {
    /**
     * Constructor for ButtonSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    constructor(_id, _name = null, _description = null) {
          ::FU.Class.TemplateSetting(_id, null, _name, _description);
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


}

// Alias for backward compatibility
FU.Class.ButtonSetting <- ButtonSetting;

/**
 * Example implementation and test case for ButtonSetting
 */
// Example Implementation
//local buttonSetting = ButtonSetting("buttonID", "Button Setting", "This is a button setting.");
//print(buttonSetting.tostring());

// Test Case
//function testButtonSetting() {
//    local setting = ButtonSetting("testButtonID", "Test Button Setting", "A setting used for testing buttons.");
//    assert(setting.getID() == "testButtonID");
//    assert(setting.getName() == "Test Button Setting");
//
//   setting.press();
//    print("Button pressed: " + setting.getID());
//
//    setting.setDescription("Updated description");
//    assert(setting.getDescription() == "Updated description");
//}

//testButtonSetting();

