/**
 * Main Functional Utilities Namespace
 * @namespace
 */
const FU = {
    ID: "mod_FU",
    Utils: {
        Timers: {}
    }
};

/**
 * A set of utility functions for manipulating strings, arrays, objects, popups and timers
 */

/**
 * Capitalizes the first letter of a string.
 * @param {string} str - The string to capitalize.
 * @returns {string} - The capitalized string.
 */
FU.capitalizeFirst = function(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
};

/**
 * Iterates over an object and applies a function to each key-value pair.
 * @param {Object} obj - The object to iterate over.
 * @param {Function} funct - The function to apply to each key-value pair.
 * @param {boolean} [every=false] - Whether to use Array.every instead of Array.forEach.
 */
FU.iterateObject = function(obj, funct, every = false) {
    if (every) {
        Object.keys(obj).every(key => funct(key, obj[key]));
    } else {
        Object.keys(obj).forEach(key => funct(key, obj[key]));
    }
};

/**
 * Binds an event listener to an element and ensures it is the first listener.
 * @param {string} name - The name of the event.
 * @param {Function} funct - The event handler function.
 * @returns {jQuery} - The jQuery object for chaining.
 */
$.fn.bindFirst = function(name, funct) {
    this.on(name, funct);
    this.each(function() {
        const handlers = $._data(this, 'events')[name.split('.')[0]];
        const handler = handlers.pop();
        handlers.splice(0, 0, handler);
    });
    return this;
};

/**
 * Resizes a popup dialog.
 * @param {number} [contentHeight] - The height of the content.
 * @param {number} [contentWidth] - The width of the content.
 * @returns {jQuery} - The jQuery object for chaining.
 */
$.fn.resizePopup = function(contentHeight, contentWidth) {
    const popupProper = this.findPopupDialog();
    const popupContent = this.findPopupDialogContentContainer();

    contentHeight = contentHeight || popupContent.height();
    contentWidth = contentWidth || popupContent.width();

    const headerHeight = this.find(".header").height();
    const footerHeight = this.find(".footer").height();
    const subHeaderHeight = this.find(".sub-header").height();
    const baseHeight = 8 + headerHeight + subHeaderHeight + footerHeight;
    const totalWidth = Math.max(popupProper.width(), contentWidth);
    const totalHeight = baseHeight + contentHeight;

    popupProper.css("height", totalHeight);
    popupProper.css("width", totalWidth);
    popupProper.css("background-size", `${totalWidth} ${totalHeight}`);
    popupContent.css("height", contentHeight);
    popupContent.css("width", contentWidth);
    popupProper.centerPopupDialogWithinParent();
    return this;
};

/**
 * Prints the data in a formatted string with a specified depth and maximum length.
 * @param {any} data - The data to print.
 * @param {number} [depth=1] - The depth of the data to print.
 * @param {number} [maxLen=0] - The maximum length of the data to print.
 */
FU.printData = function(data, depth = 1, maxLen = 0) {
    const length = Array.isArray(data) ? data.length : typeof data === "object" && data !== null ? Object.keys(data).length : 1;
    const isArray = Array.isArray(data);
    const generator = new LocalStringGenerator(Math.max(length, maxLen), depth);
    const string = generator.generateString("Data: ", data, isArray);
    for (let i = 0; i < string.length; i += 900) {
        console.error(string.slice(i, Math.min(i + 900, string.length)));
    }
};


/**
 * Toggles the display of an object.
 * @param {jQuery} obj - The jQuery object to toggle.
 * @param {boolean} [bool] - The desired display state.
 * @returns {boolean} - The resulting display state.
 */
FU.toggleDisplay = function(obj, bool) {
    if (bool === false) {
        obj.removeClass('display-block').addClass('display-none');
    } else if (bool === true) {
        obj.removeClass('display-none').addClass('display-block');
    } else {
        if (obj.hasClass('display-block')) {
            obj.removeClass('display-block').addClass('display-none');
            return false;
        } else {
            obj.removeClass('display-none').addClass('display-block');
            return true;
        }
    }
    return bool;
};



/**
 * Class for generating a local string representation of data.
 * @class
 */
class LocalStringGenerator {
    constructor(maxLen, depth) {
        this.maxLen = maxLen;
        this.depth = depth;
    }

    /**
     * Generates a string representation of the data.
     * @param {string} key - The key of the data.
     * @param {any} value - The value of the data.
     * @param {boolean} [isArray=false] - Whether the data is an array.
     * @returns {string} - The formatted string.
     */
    generateString(key, value, isArray = false) {
        let string = "";
        if (!isArray) {
            string += `${key} = `;
        }

        switch (typeof value) {
            case "object":
                string += this.handleObject(value);
                break;
            default:
                string += `(${typeof value}) ${value}, `;
        }
        return string;
    }

    /**
     * Handles object type values for generateString.
     * @param {object} value - The object value to handle.
     * @returns {string} - The formatted string for the object.
     */
    handleObject(value) {
        if (value === null) {
            return "null, ";
        }
        if (Array.isArray(value)) {
            return this.handleArray(value);
        } else {
            return this.handleRegularObject(value);
        }
    }

    /**
     * Handles array type values for generateString.
     * @param {array} value - The array value to handle.
     * @returns {string} - The formatted string for the array.
     */
    handleArray(value) {
        if (value.length > this.maxLen || this.depth <= 0) {
            return "array, ";
        }

        let string = '[';
        value.forEach((item, index) => {
            string += this.generateString(index, item, true);
        });

        if (value.length > 0) {
            string = string.slice(0, -2);
        }
        string += '], ';
        return string;
    }

    /**
     * Handles regular object type values for generateString.
     * @param {object} value - The object value to handle.
     * @returns {string} - The formatted string for the object.
     */
    handleRegularObject(value) {
        const keys = Object.keys(value);
        if (keys.length > this.maxLen || this.depth <= 0) {
            return "object, ";
        }

        let string = '{';
        keys.forEach(key => {
            string += this.generateString(key, value[key], false);
        });

        if (keys.length > 0) {
            string = string.slice(0, -2);
        }
        string += "}, ";
        return string;
    }
}

/**
 * If you prefer to use getLocalString calls we translate that into the generator.
 * @param {string} key - The key of the data.
 * @param {any} value - The value of the data.
 * @param {number} maxLen - The maximum length of the data to print.
 * @param {number} depth - The depth of the data to print.
 * @param {boolean} [isArray=false] - Whether the data is an array.
 * @returns {string} - The formatted string.
 */
FU.Utils.getLocalString = function(key, value, maxLen, depth, isArray = false) {
    const generator = new LocalStringGenerator(maxLen, depth);
    return generator.generateString(key, value, isArray);
};



/**
 * Class representing a timer.
 * @class
 */
class TimerObject {
    constructor(id) {
        this.ID = id;
        this.Start = new Date();
        this.PauseStart = null;
        this.PauseIncrement = 0;
    }

    /**
     * Gets the elapsed time without logging.
     * @returns {number} - The elapsed time in milliseconds.
     */
    silentGet() {
        let pauseIncrement = this.PauseIncrement;
        if (this.PauseStart !== null) {
            pauseIncrement += new Date().getTime() - this.PauseStart;
        }
        return new Date().getTime() - this.Start.getTime() - pauseIncrement;
    }

    /**
     * Gets the elapsed time with an optional message and stops the timer.
     * @param {string} [msg] - An optional message to log.
     * @param {boolean} [stop=false] - Whether to stop the timer.
     * @returns {number} - The elapsed time in milliseconds.
     */
    get(msg, stop = false) {
        const time = this.silentGet();
        let text = `Timer: "${this.ID}" is at ${time}ms`;
        if (stop) {
            text = `Timer: "${this.ID}" stopped at ${time}ms`;
        }
        if (msg) {
            text += ` | Msg: ${msg}`;
        }
        console.error(text);
        return time;
    }

    /**
     * Pauses the timer.
     */
    pause() {
        if (this.PauseStart !== null && FU.getSettingValue("mod_FU", "performanceLog")) {
            console.error(`Timer ${this.ID} tried to pause but was already paused.`);
        }
        this.PauseStart = new Date();
    }

    /**
     * Unpauses the timer.
     */
    unpause() {
        if (this.PauseStart === null) {
            if (FU.getSettingValue("mod_FU", "performanceLog")) {
                console.error(`Timer ${this.ID} tried to resume but was already resumed`);
            }
            return;
        }
        const pauseStop = new Date();
        this.PauseIncrement += pauseStop.getTime() - this.PauseStart.getTime();
        this.PauseStart = null;
    }

    /**
     * Stops the timer with an optional message.
     * @param {string} [msg] - An optional message to log.
     * @returns {number} - The elapsed time in milliseconds.
     */
    stop(msg) {
        delete FU.Utils.Timers[this.ID];
        return this.get(msg, true);
    }

    /**
     * Stops the timer silently without logging.
     * @returns {number} - The elapsed time in milliseconds.
     */
    silentStop() {
        delete FU.Utils.Timers[this.ID];
        return this.silentGet();
    }
}

/**
 * Gets or creates a timer object.
 * @param {string} id - The ID of the timer.
 * @returns {TimerObject} - The timer object.
 */
FU.Utils.Timer = function(id) {
    if (id in FU.Utils.Timers) return FU.Utils.Timers[id];
    FU.Utils.Timers[id] = new TimerObject(id);
    return FU.Utils.Timers[id];
};

