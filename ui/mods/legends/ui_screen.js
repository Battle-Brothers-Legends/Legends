/**
 * Base class for UI screens.
 * @class
 * @extends {FUBackendConnection}
 */
class FUUIScreen extends FUBackendConnection {
    constructor() {
        super();
        this.mEventListener = null;
        this.mContainer = null;
        this.mPopupDialog = null;
        this.mID = "FUUIScreen";
    }

    /**
     * Registers an event listener.
     * @param {Object} _listener - The event listener to register.
     */
    registerEventListener(_listener) {
        this.mEventListener = _listener;
    }

    /**
     * Called when a connection is established.
     * @param {Object} _handle - The connection handle.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    onConnection(_handle, _parentDiv = $('.root-screen')) {
        this.mSQHandle = _handle;
        this.register(_parentDiv);
    }

    /**
     * Called when the connection is disconnected.
     */
    onDisconnection() {
        this.mSQHandle = null;
        this.unregister();
    }

    /**
     * Creates the DIV elements for the screen.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    createDIV(_parentDiv) {
        // Should be implemented by subclasses
    }

    /**
     * Destroys the DIV elements of the screen.
     */
    destroyDIV() {
        this.mContainer.empty();
        this.mContainer.remove();
        this.mContainer = null;
    }

    /**
     * Binds tooltips for the screen.
     */
    bindTooltips() {
        // Should be implemented by subclasses
    }

    /**
     * Unbinds tooltips for the screen.
     */
    unbindTooltips() {
        // Should be implemented by subclasses
    }

    /**
     * Shows the screen with an optional animation.
     * @param {boolean} _moveLeftRight - Whether to animate the screen horizontally.
     * @param {boolean} _considerParent - Whether to consider the parent's width in the animation.
     */
    show(_moveLeftRight, _considerParent) {
        const self = this;
        let moveTo = { opacity: 1 };
        let offset = -this.mContainer.width();

        if (_moveLeftRight === true) {
            moveTo = { opacity: 1, left: '0', right: '0' };
            offset = -(this.mContainer.width());
            if (_considerParent === true && this.mContainer.parent() !== null && this.mContainer.parent() !== undefined) {
                offset -= this.mContainer.parent().width();
            }
            this.mContainer.css('left', offset);
        }

        this.mContainer.velocity("finish", true).velocity(moveTo, {
            duration: Constants.SCREEN_SLIDE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                $(this).removeClass('display-none').addClass('display-block');
                self.notifyBackendOnAnimating();
            },
            complete: function () {
                self.mIsVisible = true;
                self.notifyBackendOnShown();
            }
        });

        this.onShow();
    }

    /**
     * Hides the screen with an optional animation.
     * @param {boolean} _moveLeftRight - Whether to animate the screen horizontally.
     * @param {boolean} _considerParent - Whether to consider the parent's width in the animation.
     */
    hide(_moveLeftRight, _considerParent) {
        const self = this;
        let moveTo = { opacity: 0 };
        let offset = -this.mContainer.width();

        if (_moveLeftRight === true) {
            if (_considerParent === true && this.mContainer.parent() !== null && this.mContainer.parent() !== undefined) {
                offset -= this.mContainer.parent().width();
            }
            moveTo["left"] = offset;
        }

        this.mContainer.velocity("finish", true).velocity(moveTo, {
            duration: Constants.SCREEN_FADE_IN_OUT_DELAY,
            easing: 'swing',
            begin: function () {
                self.notifyBackendOnAnimating();
            },
            complete: function () {
                $(this).removeClass('display-block').addClass('display-none');
                self.notifyBackendOnHidden();
            }
        });

        this.onHide();
    }

    /**
     * Called when the screen is shown.
     */
    onShow() {
        // Can be overridden by subclasses
    }

    /**
     * Called when the screen is hidden.
     */
    onHide() {
        // Can be overridden by subclasses
    }

    /**
     * Creates the screen elements and binds tooltips.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    create(_parentDiv) {
        this.createDIV(_parentDiv);
        this.bindTooltips();
    }

    /**
     * Destroys the screen elements and unbinds tooltips.
     */
    destroy() {
        this.unbindTooltips();
        this.destroyDIV();
    }

    /**
     * Registers the screen by creating its elements.
     * @param {Object} _parentDiv - The parent DIV element.
     */
    register(_parentDiv) {
        console.log(this.mID + '::REGISTER');

        if (this.mContainer !== null) {
            console.error("ERROR: Failed to register " + this.mID + ". Reason: " + this.mID + " is already initialized.");
            return;
        }

        if (_parentDiv !== null && typeof (_parentDiv) == 'object') {
            this.create(_parentDiv);
        }
    }

    /**
     * Unregisters the screen by destroying its elements.
     */
    unregister() {
        console.log(this.mID + '::UNREGISTER');

        if (this.mContainer === null) {
            console.error("ERROR: Failed to unregister " + this.mID + ". Reason: " + this.mID + " is not initialized.");
            return;
        }

        this.destroy();
    }

    /**
     * Checks if the screen is registered.
     * @returns {boolean} - True if registered, false otherwise.
     */
    isRegistered() {
        return this.mContainer !== null && this.mContainer.parent().length !== 0;
    }

    /**
     * Shows the background image.
     */
    showBackgroundImage() {
        // Can be implemented by subclasses
    }

    /**
     * Sets the popup dialog for the screen.
     * @param {Object} _dialog - The popup dialog.
     */
    setPopupDialog(_dialog) {
        this.mPopupDialog = _dialog;
        this.notifyBackendPopupVisible(true);
    }

    /**
     * Destroys the popup dialog.
     */
    destroyPopupDialog() {
        if (this.mPopupDialog !== null) {
            this.mPopupDialog.destroyPopupDialog();
            this.mPopupDialog = null;
        }
        this.notifyBackendPopupVisible(false);
    }

    /**
     * Notifies the backend that the popup visibility has changed.
     * @param {boolean} _data - The visibility state.
     */
    notifyBackendPopupVisible(_data) {
        SQ.call(this.mSQHandle, 'onPopupVisible', _data);
    }

    /**
     * Notifies the backend that the screen is shown.
     */
    notifyBackendOnShown() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenShown');
        }
    }

    /**
     * Notifies the backend that the screen is hidden.
     */
    notifyBackendOnHidden() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenHidden');
        }
    }

    /**
     * Notifies the backend that the screen is animating.
     */
    notifyBackendOnAnimating() {
        if (this.mSQHandle !== null) {
            SQ.call(this.mSQHandle, 'onScreenAnimating');
        }
    }
}

