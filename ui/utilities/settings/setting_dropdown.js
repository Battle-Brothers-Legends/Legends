/**
 * DropdownSetting Class
 * 
 * Handles the creation and management of a dropdown (enumeration) setting.
 */
class DropdownSetting {
    /**
     * Constructor for the DropdownSetting class.
     * @param {object} mod - The mod object.
     * @param {object} page - The page object.
     * @param {object} setting - The setting object containing the dropdown data.
     * @param {object} parentDiv - The parent HTML element to which the setting is appended.
     */
    constructor(mod, page, setting, parentDiv) {
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

        // Bind tooltip
        this.bindTooltips(mod);
    }

    /**
     * Creates the dropdown button and sets up event listeners.
     * @returns {object} - The jQuery button object.
     */
    createButton() {
        const self = this;
        const button = this.contentContainer.createTextButton(this.data.value, function () {
            self.cycle(true);
        }, 'dropdown-button', 4);

        button.mousedown(function (event) {
            if (event.which === 3) {  // Right-click
                self.cycle(false);
            }
        });

        return button;
    }

    /**
     * Updates the button text to reflect the current value.
     */
    updateValue() {
        this.button.changeButtonText(this.data.value);
    }

    /**
     * Cycles through the dropdown values.
     * @param {boolean} forward - If true, cycles forward; otherwise cycles backward.
     */
    cycle(forward) {
        this.idx += forward ? 1 : -1;

        if (this.idx === -1) {
            this.idx = this.data.array.length - 1;
        } else if (this.idx === this.data.array.length) {
            this.idx = 0;
        }

        this.data.value = this.data.array[this.idx];
        this.updateValue();
    }

    /**
     * Binds tooltips to the title and button elements.
     * @param {object} mod - The mod object.
     */
    bindTooltips(mod) {
        this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: mod.id, settingsElementId: this.data.id });
        this.button.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: mod.id, settingsElementId: this.data.id });
    }

    /**
     * Unbinds tooltips from the title and button elements.
     */
    unbindTooltips() {
        this.title.unbindTooltip();
        this.button.unbindTooltip();
    }
}

// Backward compatibility helper functions
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

// Example usage
const mod = { id: "exampleMod" };
const page = { id: "examplePage" };
const setting = {
    name: "Example Dropdown Setting",
    value: "Option1",
    array: ["Option1", "Option2", "Option3"],
    locked: false
};
const parentDiv = $('<div/>');  // Replace with actual parent div

const dropdownSetting = new DropdownSetting(mod, page, setting, parentDiv);
const enumSetting = EnumSetting(mod, page, setting, parentDiv);

