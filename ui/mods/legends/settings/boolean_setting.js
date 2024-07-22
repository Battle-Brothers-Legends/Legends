/**
 * Class representing a BooleanSetting.
 * This class handles the creation, display, and interaction with a boolean-based setting.
 */
class BooleanSetting {
    /**
     * Constructor for BooleanSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.layout = $('<div class="setting-box boolean-box"/>');
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
    createTitlebox(mod) {
        this.titlebox = $('<div class="setting-title-box"/>');
        this.layout.append(this.titlebox);

        const id = `${mod.id}${this.data.id}-id`;
        this.title = $(`<label class="bool-checkbox-label title-font-normal font-color-title" for="${id}">${this.data.name}</label>`);
        this.title.click(() => {
            this.checkbox.iCheck('toggle');
        });
        this.titlebox.append(this.title);
    }

    /**
     * Creates the checkbox for the boolean setting.
     */
    createCheckbox() {
        const id = `${this.data.id}-id`;
        this.checkbox = $(`<input type="checkbox" id="${id}" name="${this.data.id}-name" />`);
        this.titlebox.append(this.checkbox);
        this.checkbox.iCheck({
            checkboxClass: 'icheckbox_flat-orange',
            radioClass: 'iradio_flat-orange',
            increaseArea: '30%'
        });

        // Update the setting value when the checkbox is checked or unchecked
        this.checkbox.on('ifChecked ifUnchecked', () => {
            this.data.value = this.checkbox.prop('checked');
        });

        if (this.data.locked) {
            this.checkbox.attr('disabled', true);
        }
    }

    /**
     * Updates the checkbox value based on the setting data.
     */
    updateValue() {
        this.checkbox.iCheck(this.data.value === true ? 'check' : 'uncheck');
    }

    /**
     * Binds a tooltip to the title.
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
    }

    /**
     * Unbinds the tooltip from the title.
     */
    unbindTooltip() {
        this.title.unbindTooltip();
    }
}

// Example usage:
let mod = { id: 'exampleMod' }; // Example mod object
let page = {}; // Example page object
let setting = {
    name: 'Example Boolean Setting',
    id: 'exampleBooleanSetting',
    value: true,
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let booleanSetting = new BooleanSetting(mod, page, setting, parentDiv);

