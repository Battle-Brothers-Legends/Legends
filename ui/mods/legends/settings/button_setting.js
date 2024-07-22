/**
 * Class representing a ButtonSetting.
 * This class handles the creation, display, and interaction with a button-based setting.
 */
class ButtonSetting {
    /**
     * Constructor for ButtonSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.layout = $('<div class="setting-box button-box"/>');
        parentDiv.append(this.layout);

        // Create title and content boxs
        this.createTitlebox();
        this.createContentbox(mod);

        // Bind tooltip to the title and button
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
     * Creates the content box and button for the setting.
     * @param {Object} mod - The mod object.
     */
    createContentbox(mod) {
        this.contentbox = $('<div class="setting-content-box"/>');
        this.layout.append(this.contentbox);

        this.button = this.contentbox.createTextButton(this.data.value, () => {
            this.notifyBackendSettingButtonPressed(mod.id, this.data.id);
        }, 'button-setting-button', 4);

        if (this.data.locked) {
            this.button.attr('disabled', true);
        }
    }

    /**
     * Notifies the backend that the button has been pressed.
     * @param {string} modID - The mod ID.
     * @param {string} settingID - The setting ID.
     */
    notifyBackendSettingButtonPressed(modID, settingID) {
        const ret = {
            "modID": modID,
            "settingID": settingID
        };
        Screens.ModSettingsScreen.notifyBackendSettingButtonPressed(ret);
    }

    /**
     * Binds tooltips to the title and button.
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
        this.button.bindTooltip({
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
        this.button.unbindTooltip();
    }
}

// Example usage:
let mod = { id: 'exampleMod' }; // Example mod object
let page = {}; // Example page object
let setting = {
    name: 'Example Button Setting',
    id: 'exampleButtonSetting',
    value: 'Press Me',
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let buttonSetting = new ButtonSetting(mod, page, setting, parentDiv);

