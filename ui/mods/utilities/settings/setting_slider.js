
/**
 * Function constructor representing a SliderSetting.
 * This function handles the creation, display, and interaction with a range-based setting.
 */
function SliderSetting(mod, page, setting, parentDiv) {
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
 * Fixes float conversion issues by ensuring values are properly rounded.
 */
SliderSetting.prototype.fixFloatConversion = function() {
    this.data.value = parseFloat(this.data.value).toFixed(2);
    this.data.min = parseFloat(this.data.min).toFixed(2);
    this.data.max = parseFloat(this.data.max).toFixed(2);
};

/**
 * Creates the title box for the setting.
 */
SliderSetting.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the slider input and value label.
 */
SliderSetting.prototype.createContentbox = function() {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);

    this.slider = $('<input type="range" class="slider"/>').attr({
        min: this.data.min,
        max: this.data.max,
        step: this.data.step || 1,
        value: this.data.value
    });

    this.valueLabel = $('<div class="slider-value">' + this.data.value + '</div>');

    this.contentbox.append(this.slider).append(this.valueLabel);

    var self = this;
    this.slider.on('input change', function() {
        self.data.value = this.value;
        self.updateValue();
        if (typeof self.data.onChange === 'function') {
            self.data.onChange(self.data.value);
        }
    });
};

/**
 * Updates the slider and value label based on the current setting value.
 */
SliderSetting.prototype.updateValue = function() {
    this.valueLabel.text(this.data.value);
};

/**
 * Binds a tooltip to the control and title.
 * @param {Object} mod - The mod object.
 */
SliderSetting.prototype.bindTooltip = function(mod) {
    this.title.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
    this.slider.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
};

/**
 * Unbinds the tooltip from the control and title.
 */
SliderSetting.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
    this.slider.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Slider Setting",
        value: 50,
        min: 0,
        max: 100,
        step: 1,
        tooltip: "Adjust the slider value",
        onChange: function(value) {
            console.log("Slider value changed to", value);
        }
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var sliderSetting = new SliderSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
