/**
 * Class representing a StringSetting.
 * This class handles the creation, display, and interaction with a string-based setting.
 */
class StringSetting {
    /**
     * Constructor for StringSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.layout = $('<div class="setting-box string-box"/>');
        parentDiv.append(this.layout);

        // Create title and content boxs
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
    createTitlebox() {
        this.titlebox = $('<div class="setting-title-box"/>');
        this.layout.append(this.titlebox);

        this.title = $('<div class="title title-font-normal font-color-title">' + this.data.name + '</div>');
        this.titlebox.append(this.title);
    }

    /**
     * Creates the content box and input for the setting.
     */
    createContentbox() {
        this.contentbox = $('<div class="setting-content-box"/>');
        this.layout.append(this.contentbox);

        this.input = $('<input type="text" class="title-font-normal font-color-brother-name string-input"/>');
        this.contentbox.append(this.input);

        // Update the setting value when the input changes
        this.input.on("change", () => {
            this.data.value = this.input.val();
        });
    }

    /**
     * Updates the input value based on the current setting data.
     */
    updateValue() {
        this.input.val(this.data.value);
    }

    /**
     * Binds a tooltip to the title and input.
     * @param {Object} mod - The mod object.
     */
    bindTooltip(mod) {
        this.title.bindTooltip({
            contentType: 'FU-generic',
            modId: FU.ID,
            elementId: "ModSettings.Element.Tooltip",
            elementModId: mod.id,
            settingsElementId: this.data.id
        });
        this.input.bindTooltip({
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
        this.title.unbindTooltip();
        this.input.unbindTooltip();
    }
}

// Example usage:
let mod = { id: 'exampleMod' }; // Example mod object
let page = {}; // Example page object
let setting = {
    name: 'Example String Setting',
    id: 'exampleStringSetting',
    value: 'Default text',
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let stringSetting = new StringSetting(mod, page, setting, parentDiv);

