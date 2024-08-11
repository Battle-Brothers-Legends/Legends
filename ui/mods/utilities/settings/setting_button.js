
/**
 * Function constructor representing a ButtonSetting.
 * This function handles the creation, display, and interaction with a button-based setting.
 */
function ButtonSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.layout = $('<div class="setting-box button-box"/>');
    parentDiv.append(this.layout);

    // Create title and content boxes
    this.createTitlebox();
    this.createContentbox(mod);

    // Bind tooltip to the title and button
    this.bindTooltip(mod);
}

/**
 * Creates the title box for the setting.
 */
ButtonSetting.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);
    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the button.
 * @param {Object} mod - The mod object.
 */
ButtonSetting.prototype.createContentbox = function(mod) {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);
    this.button = $('<button class="btn btn-primary">' + this.data.label + '</button>');
    this.contentbox.append(this.button);

    this.button.on('click', function() {
        if (typeof this.data.action === 'function') {
            this.data.action(mod);
        }
    }.bind(this));
};

/**
 * Binds a tooltip to the title and button.
 * @param {Object} mod - The mod object.
 */
ButtonSetting.prototype.bindTooltip = function(mod) {
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
ButtonSetting.prototype.unbindTooltip = function() {
    this.title.unbindTooltip();
    this.button.unbindTooltip();
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Button Setting",
        label: "Click Me",
        tooltip: "This is a button setting.",
        action: function(mod) {
            alert("Button clicked!");
        }
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var buttonSetting = new ButtonSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
