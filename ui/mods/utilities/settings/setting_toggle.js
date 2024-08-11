
/**
 * Function constructor representing a ToggleSetting.
 * This function handles the creation, display, and interaction with a toggle-based setting.
 */
function ToggleSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.layout = $('<div class="setting-box toggle-box"/>');
    parentDiv.append(this.layout);

    // Create title box and checkbox
    this.createTitlebox(mod);
    this.createCheckbox();

    // Update the checkbox value based on the setting data
    this.updateValue();

    // Bind tooltip to the title
    this.bindTooltip(mod);
}

/**
 * Creates the title box for the setting.
 * @param {Object} mod - The mod object.
 */
ToggleSetting.prototype.createTitlebox = function(mod) {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the checkbox for the toggle setting.
 */
ToggleSetting.prototype.createCheckbox = function() {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);

    this.checkbox = $('<input type="checkbox" class="toggle-checkbox"/>').prop('checked', this.data.value);
    this.contentbox.append(this.checkbox);

    var self = this;
    this.checkbox.on('change', function() {
        self.data.value = this.checked;
        if (typeof self.data.onChange === 'function') {
            self.data.onChange(self.data.value);
        }
    });
};

/**
 * Updates the checkbox value based on the current setting data.
 */
ToggleSetting.prototype.updateValue = function() {
    this.checkbox.prop('checked', this.data.value);
};

/**
 * Binds a tooltip to the title.
 * @param {Object} mod - The mod object.
 */
ToggleSetting.prototype.bindTooltip = function(mod) {
    this.title.bindTooltip({
        title: this.data.tooltip,
        mod: mod
    });
};

/**
 * Unbinds the tooltip from the title.
 */
ToggleSetting.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Toggle Setting",
        value: true,
        tooltip: "Enable or disable this setting",
        onChange: function(value) {
            console.log("Toggle value changed to", value);
        }
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var toggleSetting = new ToggleSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
