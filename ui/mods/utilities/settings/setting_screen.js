/**
 * ModSettingsScreen Class
 * This class is responsible for creating and managing the mod settings user interface.
 * It's a crucial part of the mod system, allowing users to customize mod behavior.
 */
class ModSettingsScreen extends FUUIScreen {
    constructor() {
        super();
        this.mID = "ModSettingsScreen";

        this.mDialogbox = null;
        this.mListbox = null;
        this.mListScrollbox = null;
        this.mModPageScrollbox = null;
        this.mPageTabbox = null;
        /**
         * Stores all mod settings. This object is structured as:
         * {
         *   [modID]: {
         *     settings: {
         *       [settingID]: settingObject
         *     },
         *     pages: [pageObjects]
         *   }
         * }
         */
        this.mModSettings = {};
        this.mOrderedScreens = [];
        this.mActiveScreen = null;
        this.mLastActiveScreen = null;
        this.mActivePage = null;
        this.mLastActivePage = null;
        this.mActiveSettings = [];

        this.mIsFirstShow = null;
    }

    /**
     * Creates the main UI layout for the settings screen.
     * This method demonstrates how to build complex UI structures programmatically.
     */
    createDIV(_parentDiv) {
        super.createDIV(_parentDiv);
        this.mPopupDialog = null;
        this.mbox = $('<div class="FU-settings-screen dialog-screen ui-control display-none opacity-none"/>');
        _parentDiv.append(this.mbox);

        let dialogLayout = $('<div class="l-dialog-box"/>');
        this.mbox.append(dialogLayout);
        this.mDialogbox = dialogLayout.createDialog('Mod Settings', "Select a Mod From the List", null, true, 'dialog-1024-768');

        this.mPageTabbox = $('<div class="l-tab-button-bar"/>');
        this.mDialogbox.findDialogTabbox().append(this.mPageTabbox);

        this.createFooterButtons();
        this.createContentboxs();
    }

    /**
     * Creates the footer buttons for Cancel, Reset, Apply, and Save actions.
     */
    createFooterButtons() {
        let footerButtonBar = $('<div class="l-button-bar"></div>');
        this.mDialogbox.findDialogFooterbox().append(footerButtonBar);

        this.createFooterButton(footerButtonBar, "Cancel", 'main-cancel-button', this.notifyBackendCancelButtonPressed.bind(this));
        this.createFooterButton(footerButtonBar, "Reset", 'main-reset-button', this.notifyBackendResetButtonPressed.bind(this));
        this.createFooterButton(footerButtonBar, "Apply", 'main-apply-button', this.notifyBackendApplyButtonPressed.bind(this));
        this.createFooterButton(footerButtonBar, "Save", 'main-save-button', this.notifyBackendSaveButtonPressed.bind(this));
    }

    /**
     * Helper function to create an individual footer button.
     * @param {Object} box - The box to append the button to.
     * @param {string} label - The label for the button.
     * @param {string} className - The class name for the button.
     * @param {function} callback - The callback function for the button click event.
     */
    createFooterButton(box, label, className, callback) {
        let layout = $(`<div class="l-ok-button"/>`);
        box.append(layout);
        layout.createTextButton(label, callback, className, 1);
    }

    /**
     * Creates the content boxs for mod list and mod page.
     */
    createContentboxs() {
        let content = this.mbox.findDialogContentbox();

        let pagesListScrollbox = $('<div class="l-list-box"/>');
        content.append(pagesListScrollbox);
        this.mListbox = pagesListScrollbox.createList(2);
        this.mListScrollbox = this.mListbox.findListScrollbox();

        let modPageboxLayout = $('<div class="l-page-box"/>');
        content.append(modPageboxLayout);
        this.mModPagebox = modPageboxLayout.createList(2);
        this.mModPageScrollbox = this.mModPagebox.findListScrollbox();
    }

    /**
     * Binds tooltips to the buttons.
     */
    bindTooltips() {
        this.bindTooltipToButton('.main-cancel-button', "ModSettings.Main.Cancel");
        this.bindTooltipToButton('.main-reset-button', "ModSettings.Main.Reset");
        this.bindTooltipToButton('.main-apply-button', "ModSettings.Main.Apply");
        this.bindTooltipToButton('.main-save-button', "ModSettings.Main.OK");
    }

    /**
     * Helper function to bind tooltips to buttons.
     * @param {string} selector - The selector for the button.
     * @param {string} elementId - The element ID for the tooltip.
     */
    bindTooltipToButton(selector, elementId) {
        this.mDialogbox.find(selector).bindTooltip({
            contentType: 'FU-generic',
            modId: FU.ID,
            elementId: elementId
        });
    }

    /**
     * Destroys the active settings and calls the parent destroy method.
     */
    destroy() {
        this.mActiveSettings.forEach(setting => setting.remove());
        this.mActiveSettings = [];
        super.destroy();
    }

    /**
     * Unbinds tooltips from the buttons and calls the parent unbind tooltips method.
     */
    unbindTooltips() {
        this.mActiveSettings.forEach(setting => setting.unbindTooltip());
        this.unbindTooltipFromButton('.main-cancel-button');
        this.unbindTooltipFromButton('.main-reset-button');
        this.unbindTooltipFromButton('.main-apply-button');
        this.unbindTooltipFromButton('.main-save-button');
        super.unbindTooltips();
    }

    /**
     * Helper function to unbind tooltips from buttons.
     * @param {string} selector - The selector for the button.
     */
    unbindTooltipFromButton(selector) {
        this.mDialogbox.find(selector).unbindTooltip();
    }

    /**
     * Destroys the DIV elements and calls the parent destroyDIV method.
     */
    destroyDIV() {
        if (this.mPopupDialog !== null) {
            this.mPopupDialog.destroyPopupDialog();
        }
        this.mPopupDialog = null;
        this.mDialogbox.empty();
        this.mDialogbox.remove();
        this.mDialogbox = null;
        super.destroyDIV();
    }

    /**
     * Hides the UI and clears the active settings and boxs.
     */
    hide() {
        this.mDialogbox.findDialogSubTitle().html("Select a Mod From the List");
        this.mActiveButton = null;
        this.mPageTabbox.empty();
        this.mModPageScrollbox.empty();
        this.mListScrollbox.empty();
        super.hide();
    }

    /**
     * Shows the UI, sets the settings, and switches to the appropriate screen and page.
     * @param {Object} _data - The settings data.
     */
    show(_data) {
        this.mIsFirstShow = true;
        this.setSettings(_data);
        this.createModScreenList();
        super.show(_data);
        this.mActiveScreen = null;
        this.mActivePage = null;
        if (this.mLastActiveScreen != null && this.mLastActivePage != null) {
            let screen = this.getScreen(this.mLastActiveScreen);
            if (screen != null && !screen.hidden) {
                let page = this.getPage(screen, this.mLastActivePage);
                if (page != null && !page.hidden) this.switchToPage(screen, page);
            }
        }
        if (this.mActiveScreen == null || this.mActivePage == null) {
            this.switchToFirstScreen();
            this.switchToFirstPage(this.mActiveScreen);
        }
        this.mIsFirstShow = false;
    }

/**
 * Sets the mod settings from the provided data.
 * 
 * This method might be confusing because it's restructuring the data.
 * Here's what it does step by step:
 * 1. It stores the received settings in mModSettings.
 * 2. For each screen (mod) in mModSettings:
 *    a. It creates a new 'settings' object for the screen.
 *    b. It goes through each page in the screen.
 *    c. For each setting on a page, it adds that setting to the screen's 'settings' object,
 *       using the setting's id as the key.
 * 
 * This restructuring makes it easier to quickly access settings by their ID later on.
 * 
 * @param {Object} _settings - The settings data received from the backend.
 */
    setSettings(_settings) {
        this.mModSettings = _settings;
        FU.iterateObject(this.mModSettings, (_screenID, _screen) => {
            _screen.settings = {};
            _screen.pages.forEach(_page => {
                _page.settings.forEach(_setting => {
                    _screen.settings[_setting.id] = _setting;
                });
            });
            return true;
        });
    }

    /**
     * Creates the list of mod screens.
     */
    createModScreenList() {
        this.mOrderedScreens = [];
        FU.iterateObject(this.mModSettings, (_screenID, _screen) => {
            if (_screen.hidden) return;
            this.mOrderedScreens.push(_screen);
        });
        this.mOrderedScreens.sort((a, b) => a.order - b.order);
        this.mOrderedScreens.forEach(_sortedScreen => this.addModScreenButtonToList(_sortedScreen));
    }

    /**
     * Adds buttons for each mod screen to the list.
     * @param {Object} _screen - The screen data.
     */
    addModScreenButtonToList(_screen) {
        let button = this.mListScrollbox.createCustomButton(null, () => {
            this.switchToScreen(_screen);
            this.switchToFirstPage(_screen);
        }, 'FU-button');
        button.text(_screen.name);
        button.removeClass('button');
        _screen.button = button;
    }

    /**
     * Switches to the selected screen and updates the UI accordingly.
     * @param {Object} _screen - The screen data.
     */
    switchToScreen(_screen) {
        this.mPageTabbox.empty();
        this.mbox.findDialogSubTitle().html(_screen.name);
        if (this.mActiveScreen !== null) {
            this.mActiveScreen.button.removeClass('is-active');
        }
        this.mActiveScreen = _screen;
        this.mLastActiveScreen = _screen.id;
        this.mActiveScreen.button.addClass('is-active');

        _screen.pages.forEach(page => {
            if (page.hidden) return;
            let layout = $('<div class="l-tab-button"/>');
            this.mPageTabbox.append(layout);
            let button = layout.createTabTextButton(page.name, () => {
                this.switchToPage(_screen, page);
            }, null, 'tab-button', 7);
            page.button = button;
        });
    }

    /**
     * Switches to the selected page and updates the UI accordingly.
     * @param {Object} _screen - The screen data.
     * @param {Object} _page - The page data.
     */
    switchToPage(_screen, _page) {
        if (this.mActiveScreen != _screen) this.switchToScreen(_screen);

        if (this.mActivePage !== null) {
            this.mActivePage.button.removeClass('is-active');
        }
        this.mActivePage = _page;
        this.mLastActivePage = _page.id;
        this.mActivePage.button.addClass('is-active');

        this.mActiveSettings.forEach(element => element.unbindTooltip());
        this.mActiveSettings = [];
        this.mModPageScrollbox.empty();

        _page.settings.forEach(element => {
            if (element.hidden) return;
            this.mActiveSettings.push(new window[element.type + "Setting"](_screen, _page, element, this.mModPageScrollbox));
        });

        if (this.mIsFirstShow) setTimeout(this.adjustTitles, 300, this);
        else this.adjustTitles(this);
    }

    /**
     * Retrieves the screen with the specified ID.
     * @param {string} _id - The screen ID.
     * @returns {Object|null} - The screen data or null if not found.
     */
    getScreen(_id) {
        let ret = null;
        this.mOrderedScreens.every(_screen => {
            if (_screen.id == _id) {
                ret = _screen;
                return false;
            }
            return true;
        });
        return ret;
    }

    /**
     * Retrieves the page with the specified ID within a screen.
     * @param {Object} _screen - The screen data.
     * @param {string} _id - The page ID.
     * @returns {Object|null} - The page data or null if not found.
     */
    getPage(_screen, _id) {
        let ret = null;
        _screen.pages.every(page => {
            if (page.id == _id) {
                ret = page;
                return false;
            }
            return true;
        });
        return ret;
    }

    /**
     * Switches to the first screen that is not hidden.
     */
    switchToFirstScreen() {
        this.mOrderedScreens.every(_screen => {
            if (!_screen.hidden) {
                this.switchToScreen(_screen);
                return false;
            }
            return true;
        });
    }

    /**
     * Switches to the first page within a screen that is not hidden.
     * @param {Object} _screen - The screen data.
     */
    switchToFirstPage(_screen) {
        _screen.pages.every(page => {
            if (!page.hidden) {
                this.switchToPage(_screen, page);
                return false;
            }
            return true;
        });
    }

    /**
     * Adjusts the font size of titles to fit within their boxs.
     * @param {ModSettingsScreen} self - The ModSettingsScreen instance.
     */
    adjustTitles(self) {
        self.mActiveSettings.forEach(element => {
            if ('title' in element && 'titlebox' in element) {
                while (element.title[0].scrollWidth > element.title.innerWidth()) {
                    element.title.css('font-size', (parseInt(element.title.css('font-size').slice(0, -2)) - 1) + 'px');
                    if (parseInt(element.title.css('font-size').slice(0, -2)) <= 1) {
                        console.error("Setting with ID " + element.data.id + ": Font size of title too small! Stopping font size adjustment.");
                        return;
                    }
                }
            }
        });
    }

    /**
     * Determines the type of a setting value (integer or float) and adjusts the value if necessary.
     * @param {Object} _data - The data containing the value and type.
     * @returns {Object} - The adjusted data.
     */
    setTypeIfFloatOrInt(_data) {
        if (_data.type == "number") {
            if (_data.value % 1 == 0) _data.type = "integer";
            else {
                _data.type = "float";
                _data.value = _data.value.toPrecision(6);
            }
        }
        return _data;
    }

    /**
     * Retrieves the changes made to the settings.
     * This method compares current values with original values to determine changes.
     * It's a good example of how to track and collect user modifications.
     * @returns {Object} - The changes.
     */
    getChanges() {
        let changes = {};
        FU.iterateObject(this.mModSettings, (_screenID, modScreen) => {
            changes[_screenID] = {};
            FU.iterateObject(modScreen.settings, (_elementID, element) => {
                if ("IsSetting" in element.data && !element.locked && element.currentValue != element.value) {
                    changes[_screenID][_elementID] = this.setTypeIfFloatOrInt({
                        type: typeof element.value,
                        value: element.value
                    });
                }
            });
        });
        return changes;
    }

    /**
     * Discards any changes made to the settings and reverts to the original values.
     */
    discardChanges() {
        FU.iterateObject(this.mModSettings, (_screenID, modScreen) => {
            FU.iterateObject(modScreen.settings, (_elementID, element) => {
                if ("IsSetting" in element.data && !element.locked) {
                    element.value = element.currentValue;
                }
            });
        });
    }

    /**
     * Updates a setting with the provided data.
     * @param {Object} _setting - The setting data.
     */
    updateSetting(_setting) {
        let screenSettings = this.mModSettings[_setting.mod].settings;
        screenSettings[_setting.id].value = _setting.value;
        screenSettings[_setting.id].currentValue = _setting.value;
        screenSettings[_setting.id].data = _setting.data;
        this.mActiveSettings.forEach(_activeSetting => {
            if (_activeSetting.data.id == _setting.id && "updateValue" in _activeSetting) {
                _activeSetting.updateValue();
            }
        });
    }

    /**
     * Sets the value of a mod setting.
     * @param {string} _modID - The mod ID.
     * @param {string} _settingID - The setting ID.
     * @param {any} _value - The value to set.
     */
    setModSettingValue(_modID, _settingID, _value) {
        let out = this.setTypeIfFloatOrInt({
            mod: _modID,
            type: typeof _value,
            id: _settingID,
            value: _value
        });

        this.updateSetting(out);
        this.updateSettingInNut(out);
    }

    /**
     * Updates the setting in the Squirrel script.
     * @param {Object} _data - The setting data.
     */
    updateSettingInNut(_data) {
        SQ.call(this.mSQHandle, "updateSettingFromJS", _data);
    }

    /**
     * Notifies the backend that the Cancel button was pressed.
     */
    notifyBackendCancelButtonPressed() {
        this.discardChanges();
        SQ.call(this.mSQHandle, 'onCancelButtonPressed');
    }

    /**
     * Notifies the backend that the Reset button was pressed.
     */
    notifyBackendResetButtonPressed() {
        SQ.call(this.mSQHandle, 'onResetButtonPressed', {
            "screenID": this.mActiveScreen.id,
            "pageID": this.mActivePage.id
        });
    }

    /**
     * Notifies the backend that the Apply button was pressed.
     */
    notifyBackendApplyButtonPressed() {
        SQ.call(this.mSQHandle, 'onApplyButtonPressed', this.getChanges());
    }

    /**
     * Notifies the backend that the Save button was pressed.
     */
    notifyBackendSaveButtonPressed() {
        SQ.call(this.mSQHandle, 'onSaveButtonPressed', this.getChanges());
    }

    /**
     * Notifies the backend that a setting button was pressed.
     * @param {Object} _data - The data of the setting button pressed.
     */
    notifyBackendSettingButtonPressed(_data) {
        SQ.call(this.mSQHandle, 'onSettingPressed', _data);
    }
}

// Global functions for accessing and setting mod settings
/**
 * Retrieves a setting by mod ID and setting ID.
 * This function provides an easy way for other parts of the UI to access specific mod settings.
 * @param {string} _modID - The mod ID.
 * @param {string} _settingID - The setting ID.
 * @returns {Object} - The setting data.
 */
FU.getSetting = function (_modID, _settingID) {
    return Screens.ModSettingsScreen.mModSettings[_modID].settings[_settingID];
};

/**
 * Retrieves the value of a setting by mod ID and setting ID.
 * @param {string} _modID - The mod ID.
 * @param {string} _settingID - The setting ID.
 * @returns {any} - The value of the setting.
 */
FU.getSettingValue = function (_modID, _settingID) {
    return Screens.ModSettingsScreen.mModSettings[_modID].settings[_settingID].value;
};

/**
 * Sets the value of a setting by mod ID and setting ID.
 * @param {string} _modID - The mod ID.
 * @param {string} _settingID - The setting ID.
 * @param {any} _value - The value to set.
 */
FU.setSettingValue = function (_modID, _settingID, _value) {
    Screens.ModSettingsScreen.setModSettingValue(_modID, _settingID, _value);
};

// Alias for backward compatibility
MainMenuModule.prototype.addModOptionsPanelButton = MainMenuModule.prototype.addModOptionsScreenButton;
MainMenuModule.prototype.createWorldMapPanelButtons = MainMenuModule.prototype.createWorldMapScreenButtons;
MainMenuModule.prototype.createTacticalMapPanelButtons = MainMenuModule.prototype.createTacticalMapScreenButtons;

// Register the ModSettingsScreen
registerScreen("ModSettingsScreen", new ModSettingsScreen());

