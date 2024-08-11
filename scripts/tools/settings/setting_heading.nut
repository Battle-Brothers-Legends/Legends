/**
 * Class representing a Heading on a settings page.
 * This provides a way to add descriptive headers with varying importance and thematic coloring.
 */
::FU.Class.SettingHeading <- class extends ::FU.Class.TemplateSetting{
    static Type = "Heading";
    Size = null;
    Color = null;

    /**
     * Constructor for Heading.
     * @param _id {string} - The unique identifier for the heading.
     * @param _name {string} - The text of the heading.
     * @param _description {string} - The description of the heading.
     * @param _size {string} - The size of the heading ("extra-small", "small", "normal", "large", "extra-large").
     * @param _color {string} - The color theme of the heading ("primary", "secondary", "tertiary").
     */
    constructor(_id, _name = null, _description = null, _size = "normal", _color = "primary") {
        base.constructor(_id, _name, _description);
        this.setSize(_size);
        this.setColor(_color);
    }

    /**
     * Gets the type of the component.
     * @returns {string} - The type of the component.
     */
    function getType() {
        return this.Type;
    }

    /**
     * Sets the size of the heading.
     * @param _size {string} - The size to set ("extra-small", "small", "normal", "large", "extra-large").
     */
    function setSize(_size) {
        this.Size = _size;
    }

    /**
     * Sets the color of the heading.
     * @param _color {string} - The color theme to set ("primary", "secondary", "tertiary").
     */
    function setColor(_color) {
        this.Color = _color;
    }

    /**
     * Gets the UI data for the heading, including type, size, and color.
     * @returns {table} - The UI data for rendering the heading.
     */
    function getUIData() {
        local ret = base.getUIData();
        ret.size <- this.Size;
        ret.color <- this.Color;
        return ret;
    }

    /**
     * Converts the heading to a string representation.
     * @returns {string} - A string representation of the heading.
     */
    function tostring() {
        return format("%s: %s (%s, %s)", this.Type, this.Name, this.Size, this.Color);
    }
}

// Create an alias for backward compatibility
::FU.Class.SettingsTitle <- ::FU.Class.SettingHeading;

