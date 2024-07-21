

/**
 * Tooltip class
 * 
 * This class represents a tooltip.
 */
class Tooltip {
    ID = null;
    Text = null;

    /**
     * Constructor for the Tooltip class.
     * @param _id {string} - The unique identifier for the tooltip.
     * @param _text {string} - The text of the tooltip.
     */
    constructor(_id, _text) {
        requireString(_id, _text);
        this.ID = _id;
        this.Text = _text;
    }

    /**
     * Gets the ID of the tooltip.
     * @returns {string} - The ID of the tooltip.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the text of the tooltip.
     * @returns {string} - The text of the tooltip.
     */
    function getText() {
        return this.Text;
    }

    /**
     * Sets the text of the tooltip.
     * @param _text {string} - The text to set.
     */
    function setText(_text) {
        this.Text = _text;
    }

    /**
     * Converts the tooltip to a string representation.
     * @returns {string} - A string representation of the tooltip.
     */
    function tostring() {
        return format("Tooltip %s: %s", this.getID(), this.getText());
    }
}


function testTooltipsSystem() {
    local tooltipsSystem = TooltipsSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    tooltipsSystem.registerMod(mod);

    local tooltip = Tooltip("TooltipID", "This is a tooltip.");
    tooltipsSystem.addTooltip("TestMod", "Tooltip1", tooltip);

    assert(tooltipsSystem.getTooltip("TestMod", "Tooltip1") == tooltip);

    tooltipsSystem.removeTooltip("TestMod", "Tooltip1");
    assert(tooltipsSystem.getTooltip("TestMod", "Tooltip1") == null);

    print("TooltipsSystem class tests passed.");
}

// Run the test
//testTooltipsSystem();

