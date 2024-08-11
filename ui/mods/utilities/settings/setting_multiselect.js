
/**
 * Function constructor representing a MultiselectSetting.
 * This function handles the creation, display, and interaction with an array-based setting.
 */
function MultiselectSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.layout = $('<div class="setting-box multiselect-box outline"/>');
    parentDiv.append(this.layout);

    // Create title and content boxes
    this.createTitlebox();
    this.createContentbox(mod);
}

/**
 * Creates the title box for the setting.
 */
MultiselectSetting.prototype.createTitlebox = function() {
    this.titlebox = $('<div class="setting-title-box"/>');
    this.layout.append(this.titlebox);

    this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
    this.titlebox.append(this.title);
};

/**
 * Creates the content box, including the checkboxes for the multiselect options.
 * @param {Object} mod - The mod object.
 */
MultiselectSetting.prototype.createContentbox = function(mod) {
    this.contentbox = $('<div class="setting-content-box"/>');
    this.layout.append(this.contentbox);
    
    var self = this;
    this.data.options.forEach(function(option) {
        var checkbox = $('<input type="checkbox"/>').val(option.value);
        if (self.data.selected.includes(option.value)) {
            checkbox.prop('checked', true);
        }
        var label = $('<label/>').text(option.label);
        var container = $('<div class="multiselect-option"/>');

        container.append(checkbox).append(label);
        self.contentbox.append(container);

        checkbox.on('change', function() {
            if (checkbox.is(':checked')) {
                self.data.selected.push(option.value);
            } else {
                var index = self.data.selected.indexOf(option.value);
                if (index > -1) {
                    self.data.selected.splice(index, 1);
                }
            }
            self.onSelectionChanged(mod);
        });
    });
};

/**
 * Handles selection change events.
 * @param {Object} mod - The mod object.
 */
MultiselectSetting.prototype.onSelectionChanged = function(mod) {
    console.log("MultiselectSetting: Selection changed", this.data.selected);
};

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Multiselect Setting",
        options: [
            { label: "Option 1", value: "opt1" },
            { label: "Option 2", value: "opt2" },
            { label: "Option 3", value: "opt3" }
        ],
        selected: ["opt1", "opt3"]
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    var multiselectSetting = new MultiselectSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});
