/**
 * DropdownSetting Class
 * 
 * Handles the creation and management of a dropdown (enumeration) setting.
 */
/**
 * DropdownSetting Constructor Function
 * 
 * Handles the creation and management of a dropdown (enumeration) setting.
 */
function DropdownSetting(mod, page, setting, parentDiv) {
    this.data = setting;
    this.idx = setting.array.indexOf(setting.value);

    if (this.idx === -1) {
        console.error("DropdownSetting Error: Invalid value in the dropdown array.");
        this.idx = 0;  // Default to the first element
    }

    this.layout = $('<div class="setting-container dropdown-container"/>');
    parentDiv.append(this.layout);

    this.titleContainer = $('<div class="setting-title-container"/>');
    this.layout.append(this.titleContainer);

    this.title = $('<div class="title title-font-normal font-color-title">' + setting.name + '</div>');
    this.titleContainer.append(this.title);

    this.contentContainer = $('<div class="setting-content-container"/>');
    this.layout.append(this.contentContainer);

    this.button = this.createButton();

    if (setting.locked) {
        this.button.attr('disabled', true);
    }

    this.createDropdown();
    this.setupEventListeners();
}

DropdownSetting.prototype.createButton = function() {
    var button = $('<button class="btn btn-default dropdown-toggle" type="button" data-toggle="dropdown"/>');
    this.contentContainer.append(button);
    return button;
};

DropdownSetting.prototype.createDropdown = function() {
    var dropdownMenu = $('<ul class="dropdown-menu"/>');
    this.data.array.forEach((item, index) => {
        var listItem = $('<li><a href="#">' + item + '</a></li>');
        if (index === this.idx) {
            listItem.addClass('active');
        }
        dropdownMenu.append(listItem);
    });
    this.contentContainer.append(dropdownMenu);
};

DropdownSetting.prototype.setupEventListeners = function() {
    var self = this;
    this.button.on('click', function() {
        self.idx = (self.idx + 1) % self.data.array.length;
        self.data.value = self.data.array[self.idx];
        self.updateButtonLabel();
    });
};

DropdownSetting.prototype.updateButtonLabel = function() {
    this.button.text(this.data.array[this.idx]);
};

DropdownSetting.prototype.onValueChanged = function() {
    console.log("DropdownSetting: Value changed to", this.data.value);
};

DropdownSetting.prototype.updateDropdown = function(newData) {
    this.data = newData;
    this.idx = newData.array.indexOf(newData.value);
    if (this.idx === -1) {
        console.error("DropdownSetting Error: Invalid value in the dropdown array.");
        this.idx = 0;
    }
    this.dropdown.empty();
    this.createDropdown();
};

DropdownSetting.prototype.unbindTooltips = function() {
    this.title.unbindTooltip();
    this.button.unbindTooltip();
};

// Backward compatibility functions
function EnumSetting(mod, page, setting, parentDiv) {
    return new DropdownSetting(mod, page, setting, parentDiv);
}

EnumSetting.prototype.updateValue = function() {
    this.updateValue();
};

EnumSetting.prototype.cycle = function(forward) {
    this.cycle(forward);
};

EnumSetting.prototype.unbindTooltip = function() {
    this.unbindTooltips();
};

// Compatibility function: Example of ensuring backwards compatibility
function ensureCompatibility() {
    if (typeof DropdownSetting !== 'function') {
        throw new Error("DropdownSetting is not defined");
    }
}

// Example usage
$(document).ready(function() {
    var exampleMod = {};  // Example mod object
    var examplePage = {}; // Example page object
    var exampleSetting = {
        name: "Example Dropdown Setting",
        value: "Option1",
        array: ["Option1", "Option2", "Option3"],
        locked: false
    };
    var parentDiv = $('<div/>');  // Replace with actual parent div

    ensureCompatibility();
    var dropdownSetting = new DropdownSetting(exampleMod, examplePage, exampleSetting, parentDiv);
    var enumSetting = EnumSetting(exampleMod, examplePage, exampleSetting, parentDiv);
});


