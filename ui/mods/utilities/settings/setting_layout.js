
/**
 * Function constructor representing a LayoutSetting.
 * This function handles the creation and management of layout settings, including Title, Divider, and Spacer settings.
 */
function LayoutSetting(mod, page, setting, parentDiv) {
    this.data = setting;

    switch (setting.type) {
        case "Title":
            this.createTitle(mod, parentDiv);
            break;
        case "Divider":
            this.createDivider(parentDiv);
            break;
        case "Spacer":
            this.createSpacer(parentDiv);
            break;
        default:
            console.error("Invalid LayoutSetting type.");
    }
}

/**
 * Creates a title element.
 * @param {Object} mod - The mod object.
 * @param {Object} parentDiv - The parent HTML element to which the setting is appended.
 */
LayoutSetting.prototype.createTitle = function(mod, parentDiv) {
    this.layout = $('<div class="layout-title"/>').text(this.data.title);
    parentDiv.append(this.layout);
    this.bindTooltip(mod);
};

/**
 * Creates a divider element.
 * @param {Object} parentDiv - The parent HTML element to which the setting is appended.
 */
LayoutSetting.prototype.createDivider = function(parentDiv) {
    this.layout = $('<hr class="layout-divider"/>');
    parentDiv.append(this.layout);
};

/**
 * Creates a spacer element.
 * @param {Object} parentDiv - The parent HTML element to which the setting is appended.
 */
LayoutSetting.prototype.createSpacer = function(parentDiv) {
    this.layout = $('<div class="layout-spacer"/>');
    parentDiv.append(this.layout);
};

/**
 * Binds a tooltip to the layout element, if applicable.
 * @param {Object} mod - The mod object.
 */
LayoutSetting.prototype.bindTooltip = function(mod) {
    if (this.data.tooltip) {
        this.layout.bindTooltip({
            title: this.data.tooltip,
            mod: mod
        });
    }
};

/**
 * Unbinds the tooltip from the layout element.
 */
LayoutSetting.prototype.unbindTooltip = function() {
    if (this.data.tooltip) {
        this.layout.unbindTooltip();
    }
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object

    var exampleSettingTitle = {
        type: "Title",
        title: "Example Layout Title",
        tooltip: "This is a layout title"
    };
    var exampleSettingDivider = {
        type: "Divider"
    };
    var exampleSettingSpacer = {
        type: "Spacer"
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    new LayoutSetting(exampleMod, examplePage, exampleSettingTitle, parentDiv);
    new LayoutSetting(exampleMod, examplePage, exampleSettingDivider, parentDiv);
    new LayoutSetting(exampleMod, examplePage, exampleSettingSpacer, parentDiv);
});
