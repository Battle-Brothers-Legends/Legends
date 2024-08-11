/**
 * Class representing a Divider on a settings page.
 * This is a simple horizontal line used to separate sections of settings.
 */
 ::FU.Class.SettingsDivider  <- class extends ::FU.Class.TemplateSetting{
    static Type = "Divider";

    /**
     * Constructor for SettingsDivider.
     * @param _id {string} - The unique identifier for the divider.
     */
    constructor(_id) {
        base.constructor(_id, "");
    }

    /**
     * Gets the type of the component.
     * @returns {string} - The type of the component.
     */
    function getType() {
        return this.Type;
    }
}

// alias for backwards compatibility 
::FU.Class.SettingsDivider <- ::FU.Class.SettingsDivider;

