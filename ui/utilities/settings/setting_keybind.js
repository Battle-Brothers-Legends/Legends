/**
 * Class representing a KeybindSetting.
 * This class handles the creation, display, and interaction with a keybind-based setting.
 */
class KeybindSetting {
    /**
     * Constructor for KeybindSetting.
     * @param {Object} mod - The mod object.
     * @param {Object} page - The page object.
     * @param {Object} setting - The setting data.
     * @param {Object} parentDiv - The parent div to append the setting to.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;
        this.parent = parentDiv;

        this.layout = $('<div class="setting-box string-box outline"/>');
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
            this.data.value = this.input.val().toLowerCase();
        });

        // Open the popup when the input is clicked
        this.input.on("click", () => {
            this.input.blur();
            this.createPopup();
        });
    }

    /**
     * Updates the input value based on the setting data.
     */
    updateValue() {
        this.input.val(FU.Key.capitalizeKeyString(this.data.value));
    }

    /**
     * Creates a popup dialog for changing the keybind.
     */
    createPopup() {
        this.popup = $('.FU-settings-screen').createPopupDialog('Change Keybind', this.data.name, null, 'change-keybind-popup');
        Screens.ModSettingsScreen.setPopupDialog(this.popup);

        const result = this.popup.addPopupDialogContent($('<div class="change-keybind-box"/>'));
        this.createChangeKeybindScrollbox(result);

        this.popup.addPopupDialogButton('Cancel', 'l-cancel-keybind-button', () => {
            Screens.ModSettingsScreen.destroyPopupDialog();
        });

        this.popup.addPopupDialogButton('Add', 'l-add-keybind-button', () => {
            this.createChangeKeybindRow("");
        });

        this.popup.addPopupDialogButton('OK', 'l-ok-keybind-button', () => {
            const buttons = $(".change-keybind-button");
            let result = "";
            for (let idx = 0; idx < buttons.length; idx++) {
                const text = $(buttons[idx]).findButtonText().html();
                if (text.length > 0) {
                    result += text + "/";
                }
            }
            result = result.slice(0, -1);
            this.input.val(result);
            this.data.value = result.toLowerCase();
            Screens.ModSettingsScreen.destroyPopupDialog();
        });
    }

    /**
     * Creates a scrollable box for the keybind rows within the popup.
     * @param {Object} dialog - The dialog element to append the scroll box to.
     */
    createChangeKeybindScrollbox(dialog) {
        this.mButtonbox = dialog.createList(2);
        const keybindArray = this.data.value.split("/");
        keybindArray.forEach(keybind => {
            this.createChangeKeybindRow(keybind);
        });
    }

    /**
     * Creates a row for each keybind within the scroll box.
     * @param {string} name - The keybind name.
     */
    createChangeKeybindRow(name) {
        const row = $('<div class="row"/>');
        this.mButtonbox.findListScrollbox().append(row);

        const buttonLayout = $('<div class="keybind-button-box"/>');
        row.append(buttonLayout);

        const button = buttonLayout.createTextButton(FU.Key.capitalizeKeyString(name), null, 'change-keybind-button', 4);
        button.css('margin-top', '-0.4rem');
        button.findButtonText().css('margin-top', '0.8rem');

        let selectedButton = null;

        const callbackKeyboard = (_event) => {
            const key = FU.Key.KeyMapJS[_event.keyCode];
            if (key !== undefined && key !== null) {
                setButton(key);
            }
        };

        const callbackMouse = (_event) => {
            const key = FU.Key.MouseMapJS[_event.button];
            if (key !== undefined && key !== null) {
                setButton(key);
            }
        };

        const setButton = (_key) => {
            const pressedKeys = FU.Keybinds.getPressedKeysAsString(_key) + _key;
            selectedButton.changeButtonText(FU.Key.capitalizeKeyString(FU.Key.sortKeyString(pressedKeys)));
            toggle(selectedButton, true);
        };

        const toggle = (_button, _forcedOff) => {
            if (_forcedOff === true || _button.data("Selected") === true) {
                document.removeEventListener("keyup", callbackKeyboard, true);
                document.removeEventListener("mouseup", callbackMouse, true);
                _button.data("Selected", false);
                _button.removeClass('is-selected');
                _button.css('pointer-events', 'auto');
                selectedButton = null;
            } else {
                document.addEventListener("keyup", callbackKeyboard, true);
                document.addEventListener("mouseup", callbackMouse, true);
                _button.data("Selected", true);
                _button.addClass('is-selected');
                _button.css('pointer-events', 'none');
                selectedButton = _button;
            }
        };

        button.on("click", function() {
            const mainButton = this;
            const buttons = $(".change-keybind-button");
            buttons.map(function() {
                if (this !== mainButton) {
                    toggle($(this), true);
                }
            });
            toggle($(this), false);
        });

        button.off("mouseenter");
        button.off("mouseleave");
        button.off("mousedown");
        button.off("mouseup");

        button.on("mouseenter", function() {
            $(this).addClass('is-selected');
        });

        button.on("mouseleave", function() {
            if (!$(this).data("Selected")) {
                $(this).removeClass('is-selected');
            }
        });

        // Delete button
        const destroyButtonLayout = $('<div class="keybind-delete-button-box"/>');
        row.append(destroyButtonLayout);

        const destroyButton = destroyButtonLayout.createTextButton("Delete", () => {
            row.remove();
        }, 'delete-keybind-button', 2);
    }

    /**
     * Binds tooltips to the title and input.
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
    name: 'Example Keybind Setting',
    id: 'exampleKeybindSetting',
    value: 'ctrl+s',
    locked: false
};
let parentDiv = $('<div></div>'); // Example parent div

let keybindSetting = new KeybindSetting(mod, page, setting, parentDiv);

