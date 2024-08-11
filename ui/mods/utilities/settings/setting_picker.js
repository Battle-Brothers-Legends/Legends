
/**
 * Function constructor representing a ColorPickerSetting.
 * This function handles the creation, display, and interaction with a color picker-based setting.
 */
function ColorPickerSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.values = this.data.data.values;
    this.parent = parentDiv;

    this.layout = $('<div class="setting-box picker-box"/>');
    parentDiv.append(this.layout);

    // Create title and content boxes
    this.createTitlebox();
    this.createContentbox();

    // Update the button color based on the setting values
    this.updateColor();

    // Bind tooltip to the title and button
    this.bindTooltip(mod);
}

/**
 * Creates the title box for the setting.
 */
ColorPickerSetting.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the color picker button.
 */
ColorPickerSetting.prototype.createContentbox = function() {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);

    this.button = $('<button class="btn btn-color-picker"/>');
    this.contentbox.append(this.button);

    this.button.on('click', this.openColorPicker.bind(this));
};

/**
 * Opens the color picker.
 */
ColorPickerSetting.prototype.openColorPicker = function() {
    // Placeholder for the color picker functionality
    console.log("Color picker opened.");
};

/**
 * Updates the button color based on the setting values.
 */
ColorPickerSetting.prototype.updateColor = function() {
    var color = this.values[this.data.value] || '#FFFFFF';
    this.button.css('background-color', color);
};

/**
 * Binds a tooltip to the title and button.
 * @param {Object} mod - The mod object.
 */
ColorPickerSetting.prototype.bindTooltip = function(mod) {
    this.title.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
    this.button.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
};

/**
 * Unbinds the tooltip from the title and button.
 */
ColorPickerSetting.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
    this.button.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Color Picker Setting",
        value: "defaultColor",
        data: {
            values: {
                defaultColor: "#FF0000"
            }
        },
        tooltip: "Select a color"
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var colorPickerSetting = new ColorPickerSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
