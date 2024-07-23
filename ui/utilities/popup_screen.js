/**
 * Class representing a popup screen.
 * @class
 */
class FUPopup {
    constructor() {
        this.mSQHandle = null;
        this.mContainer = null;
        this.mID = "FUPopup";
        this.mHeaderContainer = null;
        this.mContentContainer = null;
        this.mListScrollContainer = null;
        this.mFooterContainer = null;
        this.mTitle = null;
    }

    /**
     * Called when a connection is established.
     * @param {Object} _handle - The connection handle.
     */
    onConnection(_handle) {
        this.register($('.root-screen'));
        this.mSQHandle = _handle;
    }

    /**
     * Creates the DIV elements for the popup.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    createDIV(_parentDiv) {
        this.mContainer = $('<div class="FU-popup ui-control dialog display-none opacity-none"/>');
        _parentDiv.append(this.mContainer);

        this.mHeaderContainer = $('<div class="header"/>');
        this.mContainer.append(this.mHeaderContainer);

        this.mTitle = $('<div class="title title-font-very-big font-bold font-bottom-shadow font-color-title">Mod Error</div>');
        this.mHeaderContainer.append(this.mTitle);

        this.mListContainer = this.mContainer.createList(1, 'content-container');
        this.mListScrollContainer = this.mListContainer.findListScrollContainer();
        this.mContainer.append(this.mContentContainer);

        this.mFooterContainer = $('<div class="footer"/>');
        this.mContainer.append(this.mFooterContainer);

        this.mFooterContainer.createTextButton("Ok", () => {
            this.hide();
        }, "ok-button", 1);

        this.mFooterContainer.find(".ok-button:first").on("force-quit", () => {
            this.mFooterContainer.find(".ok-button:first").findButtonText().html("Quit Game");
            this.mFooterContainer.find(".ok-button:first").on("click", () => {
                this.quitGame();
            });
        });
    }

    /**
     * Creates the popup elements.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    create(_parentDiv) {
        this.createDIV(_parentDiv);
    }

    /**
     * Destroys the popup elements.
     */
    destroy() {
        this.destroyDIV();
    }

    /**
     * Shows the popup.
     */
    show() {
        let moveTo = { opacity: 1, right: '10.0rem' };
        let offset = -this.mContainer.width();
        if (this.mContainer.hasClass('is-center') === true) {
            moveTo = { opacity: 1, left: '0', right: '0' };
            offset = -(this.mContainer.parent().width() + this.mContainer.width());
            this.mContainer.css({ 'left': '0' });
        }

        this.mContainer.css({ 'right': offset });
        this.mContainer.velocity("finish", true).velocity(moveTo, {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: () => {
                this.notifyBackendOnAnimating();
                this.mContainer.removeClass('display-none').addClass('display-block');
            },
            complete: () => {
                this.notifyBackendOnShown();
            }
        });
    }

    /**
     * Checks if the popup is visible.
     * @returns {boolean} - True if the popup is visible, false otherwise.
     */
    isVisible() {
        return this.mContainer.hasClass('display-block');
    }

    /**
     * Displays raw text in the popup.
     * @param {Object} _data - The data containing the text to display.
     */
    showRawText(_data) {
        if (_data.forceQuit) {
            this.mTitle.text("Fatal Mod Error");
            this.mFooterContainer.find(".ok-button:first").trigger('force-quit');
        } else {
            this.mTitle.text("Mod Error");
        }
        this.mListScrollContainer.append($('<div class="mod-raw-text">' + _data.text + '</div>'));
        if (!this.isVisible()) {
            this.show();
        }
    }

    /**
     * Displays mod updates in the popup.
     * @param {Object[]} _mods - The array of mod updates to display.
     */
    showModUpdates(_mods) {
        this.mTitle.text("Mod Updates Available");
        _mods.forEach(_modInfo => {
            const modInfoContainer = $('<div class="FU-mod-info-container"/>');
            this.mListScrollContainer.append(modInfoContainer);
            modInfoContainer.append($('<div class="mod-name title title-font-big font-bold font-color-title">' + _modInfo.name + '</div>'));

            if ("GitHub" in _modInfo.sources) {
                const githubContainer = $('<div class="l-github-button"/>');
                modInfoContainer.append(githubContainer);
                githubContainer.createImageButton(Path.GFX + "mods/FU/logos/github-32.png", () => {
                    openURL(_modInfo.sources.GitHub);
                });
            }
            if ("NexusMods" in _modInfo.sources) {
                const nexusModsContainer = $('<div class="l-nexusmods-button"/>');
                modInfoContainer.append(nexusModsContainer);
                nexusModsContainer.createImageButton(Path.GFX + "mods/FU/logos/nexusmods-32.png", () => {
                    openURL(_modInfo.sources.NexusMods);
                });
            }

            const colorFromIdx = _modInfo.updateType !== "MAJOR" ? _modInfo.availableVersion.indexOf('.') + 1 : 0;
            const versionSplitIdx = _modInfo.updateType === "PATCH" ? _modInfo.availableVersion.indexOf('.', colorFromIdx + 1) + 1 : colorFromIdx;
            const start = _modInfo.availableVersion.slice(0, versionSplitIdx);
            const coloredSpan = '<span style="color:red;">' + _modInfo.availableVersion.slice(versionSplitIdx) + '</span>';
            modInfoContainer.append($('<div class="version-info text-font-normal">' + _modInfo.currentVersion + ' => ' + start + coloredSpan + ' (Update Available)</div>'));
        });
        if (!this.isVisible()) this.show();
    }

    /**
     * Hides the popup.
     */
    hide() {
        this.mContainer.velocity("finish", true).velocity({ opacity: 0 }, {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: () => {
                this.notifyBackendOnAnimating();
            },
            complete: () => {
                this.notifyBackendOnHidden();
                this.mContainer.css({ opacity: 0 }).removeClass('display-block').addClass('display-none');
            }
        });
    }

    /**
     * Registers the popup.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    register(_parentDiv) {
        console.log('FUPopup::REGISTER');
        this.create(_parentDiv);
    }

    /**
     * Unregisters the popup.
     */
    unregister() {
        console.log('FUPopup::UNREGISTER');
        this.destroy();
    }

    /**
     * Quits the game.
     */
    quitGame() {
        SQ.call(this.mSQHandle, "quitGame");
    }

    /**
     * Notifies the backend that the popup is shown.
     */
    notifyBackendOnShown() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenShown');
        }
    }

    /**
     * Notifies the backend that the popup is hidden.
     */
    notifyBackendOnHidden() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenHidden');
        }
    }

    /**
     * Notifies the backend that the popup is animating.
     */
    notifyBackendOnAnimating() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenAnimating');
        }
    }
}

// Register the FUPopup screen
registerScreen("FUPopup", new FUPopup());

