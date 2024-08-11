
/**
 * Function constructor representing a KeybindSetting.
 * This function handles the creation, display, and interaction with a keybind-based setting.
 */
function KeybindSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.parent = parentDiv;

    this.layout = $('<div class="setting-box string-box outline"/>');
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
KeybindSetting.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the keybind input field.
 */
KeybindSetting.prototype.createContentbox = function() {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);

    this.input = $('<input type="text" class="keybind-input"/>').val(this.data.value);
    this.contentbox.append(this.input);

    var self = this;
    this.input.on('focus', function() {
        $(document).on('keydown.keybind', function(e) {
            e.preventDefault();
            self.data.value = e.key;
            self.updateValue();
            $(document).off('keydown.keybind');
            self.input.blur();
            if (typeof self.data.onChange === 'function') {
                self.data.onChange(self.data.value);
            }
        });
    });

    this.input.on('blur', function() {
        $(document).off('keydown.keybind');
    });
};

/**
 * Updates the input value based on the current setting data.
 */
KeybindSetting.prototype.updateValue = function() {
    this.input.val(this.data.value);
};

/**
 * Binds a tooltip to the title and input.
 * @param {Object} mod - The mod object.
 */
KeybindSetting.prototype.bindTooltip = function(mod) {
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
KeybindSetting.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
    this.input.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Keybind Setting",
        value: "K",
        tooltip: "Press a key to bind",
        onChange: function(value) {
            console.log("Keybind value changed to", value);
        }
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var keybindSetting = new KeybindSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
