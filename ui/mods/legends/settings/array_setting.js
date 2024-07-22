/**
 * Class representing an ArraySetting.
 * This class handles the creation, display, and interaction with an array-based setting.
 */
class ArraySetting {
    /**
     * Constructor for ArraySetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.layout = $('<div class="setting-box array-box outline"/>');
        parentDiv.append(this.layout);

        // Create title and content boxs
        this.createTitlebox();
        this.createContentbox(mod);
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
     * Creates the content box for the setting.
     * @param {Object} mod - The mod object.
     */
    createContentbox(mod) {
        this.contentbox = $('<div class="setting-content-box"/>');
        this.layout.append(this.contentbox);

        this.button = this.contentbox.createTextButton(this.data.name, () => {
            this.createPopup();
        }, 'popup-button', 4);

        // Tooltip binding for title and button
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
     * Creates a popup dialog for editing the array setting.
     */
    createPopup() {
        this.popup = $('.FU-settings-screen').createPopupDialog('Change Array', this.data.name, null, 'change-array-popup');
        Screens.ModSettingsScreen.setPopupDialog(this.popup);
        let result = this.popup.addPopupDialogContent($('<div class="change-array-box"/>'));
        let rowWidth = this.data.data.lockLength ? 600 : 720;
        this.popup.resizePopup(null, rowWidth);

        // Create the scroll box for the array entries
        this.createArrayScrollbox(result);

        // Add buttons to the popup dialog
        this.popup.addPopupDialogButton('Cancel', 'l-cancel-keybind-button', () => {
            Screens.ModSettingsScreen.destroyPopupDialog();
        });

        if (!this.data.data.lockLength) {
            this.popup.addPopupDialogButton('Add', 'l-add-keybind-button', () => {
                this.createEntryRow([null, ""]);
            });
        }

        this.popup.addPopupDialogButton('OK', 'l-ok-keybind-button', () => {
            this.getPopupValues();
            Screens.ModSettingsScreen.destroyPopupDialog();
        });
    }

    /**
     * Creates a scrollable box for the array entries within the popup.
     * @param {Object} dialog - The dialog element to append the scroll box to.
     */
    createArrayScrollbox(dialog) {
        this.mButtonbox = dialog.createList(2);
        this.data.value.forEach(entry => {
            this.createEntryRow(entry);
        });
    }

    /**
     * Creates a row for each array entry within the scroll box.
     * @param {Array} entry - The array entry data.
     */
    createEntryRow(entry) {
        let row = $('<div class="row array-row"/>');
        let entryCopy = [...entry];
        row.data("entry", entryCopy);

        let name = $('<div class="title-font-normal font-color-brother-name array-entry-name">' + entry[0] + '</div>');
        row.append(name);

        let buttonLayout = $('<div class="string-input-box"/>');
        row.append(buttonLayout);
        let input = $('<input type="text" class="title-font-normal font-color-brother-name string-input string-input"/>');
        buttonLayout.append(input);
        input.val(entry[1]);
        input.on("change", function() {
            row.data("entry")[1] = $(this).val();
        });

        // Create a delete button if length is not locked
        if (!this.data.data.lockLength) {
            let destroyButtonLayout = $('<div class="keybind-delete-button-box"/>');
            row.append(destroyButtonLayout);
            let destroyButton = destroyButtonLayout.createTextButton("Delete", () => {
                row.remove();
                this.resizePopup();
            }, 'delete-keybind-button', 2);
        }

        this.mButtonbox.findListScrollbox().append(row);
        this.resizePopup();
    }

    /**
     * Resizes the popup dialog based on the number of rows.
     */
    resizePopup() {
        let rowHeight = this.popup.find(".row:first").height();
        let rowHeightSum = Math.min(600, this.popup.find(".row").length * rowHeight);
        this.popup.resizePopup(rowHeightSum, null);
        this.popup.find(".list").css("height", rowHeightSum);
    }

    /**
     * Retrieves the values from the popup and updates the setting data.
     */
    getPopupValues() {
        let result = [];
        $(".array-row").each(function() {
            result.push($(this).data("entry"));
        });
        this.data.value = result;
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
    name: 'Example Array Setting',
    id: 'exampleArraySetting',
    data: { lockLength: false },
    value: [['Item1', 'Value1'], ['Item2', 'Value2']]
};
let parentDiv = $('<div></div>'); // Example parent div

let arraySetting = new ArraySetting(mod, page, setting, parentDiv);

