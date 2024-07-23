/**
 * Class representing a SliderSetting.
 * This class handles the creation, display, and interaction with a range-based setting.
 */
class SliderSetting {
    /**
     * Constructor for SliderSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.fixFloatConversion();
        this.layout = $('<div class="setting-box slider-box"/>');
        parentDiv.append(this.layout);

        // Create title and content boxes
        this.createTitlebox();
        this.createContentbox();

        // Update the slider and label values based on the setting data
        this.updateValue();

        // Bind tooltip to the control and title
        this.bindTooltip(mod);
    }

    /**
     * Fixes float conversion issues by ensuring precision for float values.
     */
    fixFloatConversion() {
        this.data.value = this.fixPrecision(this.data.value);
        this.data.min = this.fixPrecision(this.data.min);
        this.data.max = this.fixPrecision(this.data.max);
        this.data.step = this.fixPrecision(this.data.step);
    }

    /**
     * Fixes the precision of a float value.
     * @param {number} value - The value to fix precision for.
     * @returns {number} - The value with fixed precision.
     */
    fixPrecision(value) {
        return value % 1 !== 0 ? parseFloat(value.toPrecision(6)) : value;
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
     * Creates the content box, slider, and label for the setting.
     */
    createContentbox() {
        this.contentbox = $('<div class="setting-content-box"/>');
        this.layout.append(this.contentbox);

        this.control = $('<div class="scale-control"/>');
        this.contentbox.append(this.control);

        this.slider = $('<input class="scale-slider" type="range"/>');
        this.control.append(this.slider);

        this.label = $('<div class="scale-label text-font-normal font-color-subtitle">' + this.data.value + '</div>');
        this.control.append(this.label);

        // Update the setting value when the slider changes
        this.layout.on("change", () => {
            this.data.value = parseFloat(this.slider.val());
            this.label.text('' + this.data.value);
        });

        if (this.data.locked) {
            this.slider.attr('disabled', true);
        }
    }

    /**
     * Updates the slider and label values based on the current setting data.
     */
    updateValue() {
        this.slider.attr({
            min: this.data.min,
            max: this.data.max,
            step: this.data.step
        });
        this.slider.val(this.data.value);
        this.label.text('' + this.data.value);
    }

    /**
     * Binds a tooltip to the control and title.
     * @param {Object} mod - The mod object.
     */
    bindTooltip(mod) {
        this.control.bindTooltip({
            contentType: 'FU-generic',
            modId: FU.ID,
            elementId: "ModSettings.Element.Tooltip",
            elementModId: mod.id,
            settingsElementId: this.data.id
        });
        this.title.bindTooltip({
            contentType: 'FU-generic',
            modId: FU.ID,
            elementId: "ModSettings.Element.Tooltip",
            elementModId: mod.id,
            settingsElementId: this.data.id
        });
    }

    /**
     * Unbinds tooltips from the elements.
     */
    unbindTooltip() {
        this.control.unbindTooltip();
        this.title.unbindTooltip();
    }
}

// Alias for backward compatibility
var RangeSetting = function(mod, page, setting, parentDiv) {
    console.warn("RangeSetting is deprecated. Please use SliderSetting instead.");
    return new SliderSetting(mod, page, setting, parentDiv);
};

// Example usage:
let mod = { id: 'exampleMod' }; // Example mod object
let page = {}; // Example page object
let setting = {
    name: 'Example Slider Setting',
    id: 'exampleSliderSetting',
    value: 10.123456,
    min: 0,
    max: 100,
    step: 0.01,
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let sliderSetting = new SliderSetting(mod, page, setting, parentDiv);

