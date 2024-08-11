
/**
 * Function constructor representing a SettingTextinput.
 * This function handles the creation, display, and interaction with a text input setting.
 */
function SettingTextinput(mod, page, setting, parentDiv) {
    this.data = setting;
    this.layout = $('<div class="setting-box string-box"/>');
    parentDiv.append(this.layout);

    // Create title and content boxes
    this.createTitlebox();
    this.createContentbox();

    // Update the input value based on the setting data
    this.updateValue();

    // Bind tooltip to the title and input
    this.bindTooltip(mod);
}

/**
 * Creates the title box for the setting.
 */
SettingTextinput.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the text input field.
 */
SettingTextinput.prototype.createContentbox = function() {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);

    this.input = $('<input type="text" class="text-input"/>').val(this.data.value);
    this.contentbox.append(this.input);

    var self = this;
    this.input.on('input change', function() {
        self.data.value = this.value;
        if (typeof self.data.onChange === 'function') {
            self.data.onChange(self.data.value);
        }
    });
};

/**
 * Updates the input value based on the current setting data.
 */
SettingTextinput.prototype.updateValue = function() {
    this.input.val(this.data.value);
};

/**
 * Binds a tooltip to the title and input.
 * @param {Object} mod - The mod object.
 */
SettingTextinput.prototype.bindTooltip = function(mod) {
    this.title.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
    this.input.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
};

/**
 * Unbinds the tooltip from the title and input.
 */
SettingTextinput.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
    this.input.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Text Input Setting",
        value: "Default Text",
        tooltip: "Enter your text here",
        onChange: function(value) {
            console.log("Text input value changed to", value);
        }
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var textinputSetting = new SettingTextinput(exampleMod, examplePage, exampleSetting, parentDiv);
});
