/**
 * Class representing a ColorPickerSetting.
 * This class handles the creation, display, and interaction with a color picker-based setting.
 */
class ColorPickerSetting {
    /**
     * Constructor for ColorPickerSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.values = this.data.data.values;
        this.parent = parentDiv;

        this.layout = $('<div class="setting-box picker-box"/>');
        parentDiv.append(this.layout);

        // Create title and content boxs
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
    createTitlebox() {
        this.titlebox = $('<div class="setting-title-box"/>');
        this.layout.append(this.titlebox);

        this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
        this.titlebox.append(this.title);
    }

    /**
     * Creates the content box and button for the setting.
     */
    createContentbox() {
        this.contentbox = $('<div class="setting-content-box"/>');
        this.layout.append(this.contentbox);

        this.button = $('<div class="picker-button"/>');
        this.button.on("click", () => {
            this.createColorPickerPopup();
        });
        this.contentbox.append(this.button);

        this.buttonLabel = $('<span class="picker-button-label text-font-normal">' + this.getRGBA(this.values) + '</span>');
        this.button.append(this.buttonLabel);
    }

    /**
     * Updates the value of the color picker setting.
     */
    updateValue() {
        this.values = this.data.data.values;
        this.updateColor();
    }

    /**
     * Creates a popup dialog for selecting a color.
     */
    createColorPickerPopup() {
        this.popup = $('.FU-settings-screen').createPopupDialog('Color Picker', null, null, 'picker-popup', false);
        Screens.ModSettingsScreen.setPopupDialog(this.popup);

        this.popup.values = {
            "Red": 0,
            "Green": 0,
            "Blue": 0,
            "Alpha": 0
        };
        this.cloneSettingsToFrom(this.popup.values, this.values);

        this.popup.addPopupDialogOkButton(() => {
            this.cloneSettingsToFrom(this.values, this.popup.values);
            this.updateColor();
            Screens.ModSettingsScreen.destroyPopupDialog();
        });

        this.popup.addPopupDialogCancelButton(() => {
            Screens.ModSettingsScreen.destroyPopupDialog();
        });

        this.popup.addPopupDialogContent(this.createPopupContent());
        this.updateColorInPopup();
    }

    /**
     * Creates the content for the color picker popup.
     * @returns {Object} - The popup content element.
     */
    createPopupContent() {
        const result = $('<div class="pick-color-content-box"/>');
        this.popup.currentColorDisplay = $('<div class="current-color-display"/>');
        result.append(this.popup.currentColorDisplay);

        this.createColorRowContent(result, "Red");
        this.createColorRowContent(result, "Green");
        this.createColorRowContent(result, "Blue");
        this.createColorRowContent(result, "Alpha");

        return result;
    }

    /**
     * Creates a row for a color component in the popup.
     * @param {Object} parentDiv - The parent div to append the row to.
     * @param {string} name - The name of the color component (Red, Green, Blue, Alpha).
     */
    createColorRowContent(parentDiv, name) {
        const result = $('<div class="row"/>');
        parentDiv.append(result);

        result.title = $('<div class="title title-font-big font-bold font-color-title">' + name + '</div>');
        result.append(result.title);

        result.control = $('<div class="scale-control"/>');
        result.append(result.control);

        result.slider = $('<input class="scale-slider" type="range"/>');
        result.slider.attr({
            min: name === "Alpha" ? 0 : 0,
            max: name === "Alpha" ? 1 : 255,
            step: name === "Alpha" ? 0.01 : 1
        });
        result.slider.val(this.popup.values[name]);
        result.control.append(result.slider);

        result.label = $('<div class="scale-label title-font-big font-bold font-color-title">' + this.popup.values[name] + '</div>');
        result.append(result.label);

        result.on("change", () => {
            this.popup.values[name] = parseFloat(result.slider.val());
            result.label.text('' + this.popup.values[name]);
            this.updateColorInPopup();
        });
    }

    /**
     * Clones the color values from one object to another.
     * @param {Object} destination - The destination object.
     * @param {Object} source - The source object.
     */
    cloneSettingsToFrom(destination, source) {
        destination.Red = source.Red;
        destination.Green = source.Green;
        destination.Blue = source.Blue;
        destination.Alpha = source.Alpha;
    }

    /**
     * Converts the color values to an RGBA string.
     * @param {Object} values - The color values.
     * @returns {string} - The RGBA string.
     */
    getRGBA(values) {
        return `rgba(${values.Red}, ${values.Green}, ${values.Blue}, ${values.Alpha});`;
    }

    /**
     * Updates the button color based on the current color values.
     */
    updateColor() {
        this.button.css("background-color", this.getRGBA(this.values));
        this.buttonLabel.text(this.getRGBA(this.values));
        this.data.value = `${this.values.Red},${this.values.Green},${this.values.Blue},${this.values.Alpha}`;
        const oppositeColors = {
            "Red": 255 - this.values.Red,
            "Green": 255 - this.values.Green,
            "Blue": 255 - this.values.Blue,
            "Alpha": 1
        };
        this.buttonLabel.css("color", this.getRGBA(oppositeColors));
    }

    /**
     * Updates the color display in the popup dialog.
     */
    updateColorInPopup() {
        if (this.popup !== undefined) {
            this.popup.currentColorDisplay.css("background-color", this.getRGBA(this.popup.values));
        }
    }

    /**
     * Unbinds tooltips from the elements.
     */
    unbindTooltip() {
        this.title.unbindTooltip();
        this.button.unbindTooltip();
    }
}

// Example usage:
let mod = { id: 'exampleMod' }; // Example mod object
let page = {}; // Example page object
let setting = {
    name: 'Example Color Picker Setting',
    id: 'exampleColorPickerSetting',
    data: { values: { Red: 255, Green: 0, Blue: 0, Alpha: 1 } },
    value: 'rgba(255, 0, 0, 1);',
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let colorPickerSetting = new ColorPickerSetting(mod, page, setting, parentDiv);

