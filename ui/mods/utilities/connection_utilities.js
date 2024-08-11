/**
 * FUBackendConnection Class
 * This class manages the connection to the Squirrel backend, which is the bridge between the JavaScript UI and the game's core logic.
 * Understanding this connection is crucial for modders as it allows the UI to communicate with the game engine.
 */
class FUBackendConnection {
    constructor() {
        this.mSQHandle = null; // Handle to the Squirrel backend connection
    }

    /**
     * Checks if there is an active connection to the Squirrel backend.
     * @returns {boolean} - True if connected, false otherwise.
     */
    isConnected() {
        return this.mSQHandle !== null;
    }

    /**
     * Handles the establishment of a connection to the Squirrel backend.
     * This method is called when the game engine initiates a connection to the UI.
     * @param {object} _handle - The handle to the Squirrel backend.
     */
    onConnection(_handle) {
        this.mSQHandle = _handle;
    }

    /**
     * Handles the disconnection from the Squirrel backend.
     */
    onDisconnection() {
        this.mSQHandle = null;
    }
}

/**
 * FUConnection Class
 * This class extends FUBackendConnection and handles specific communication tasks with the Squirrel backend.
 * It's responsible for managing mod settings, keybinds, and update checks.
 */
class FUConnection extends FUBackendConnection {
    constructor() {
        super(); // Call the parent constructor
    }

    /**
     * Handles the reception of settings data from the Squirrel backend.
     * @param {object} _data - The settings data received from the backend.
     */
    onQuerySettingsData(_data) {
        FU.Keybinds.setKeybinds(_data.keybinds);
        Screens.ModSettingsScreen.setSettings(_data.settings);
    }

    /**
     * Removes a keybind.
     * @param {object} _keybind - The keybind to be removed.
     */
    removeKeybind(_keybind) {
        FU.Keybinds.removeKeybind(_keybind.modID, _keybind.id);
    }

    /**
     * Adds a keybind.
     * @param {object} _keybind - The keybind to be added.
     */
    addKeybind(_keybind) {
        FU.Keybinds.addKeybindFromSQ(_keybind.modID, _keybind.id, _keybind.keyCombinations);
    }

    /**
     * Clears all pressed keys.
     */
    clearKeys() {
        FU.Keybinds.PressedKeys = {};
    }

/**
 * Creates a promise to check for updates from a given URL.
 * 
 * This method can be confusing because it involves several advanced concepts:
 * 1. Promises: It returns a new Promise, which represents an asynchronous operation.
 * 2. XMLHttpRequest: It uses this to make an HTTP request to check for updates.
 * 3. Error handling: It handles different scenarios (success, failure, timeout) differently.
 * 
 * Here's what happens:
 * - If the request is successful (status 200), it resolves the promise with the version tag.
 * - If the request fails or times out, it resolves with null (not reject, to avoid error handling complications).
 * - If there's a network error, it rejects the promise.
 * 
 * This approach allows us to handle all scenarios without needing to catch errors.
 * 
 * @param {string} _updateURL - The URL to check for updates.
 * @returns {Promise} - A promise that resolves with the version tag or null.
 */
    getUpdateCheckPromise(_updateURL) {
        return new Promise((resolve, reject) => {
            const xhttp = new XMLHttpRequest();
            xhttp.onloadend = function() {
                if (this.status == 200) {
                    resolve(JSON.parse(this.responseText).tag_name); // Resolve with the version tag
                } else {
                    resolve(null); // Resolve with null if the status is not 200
                }
            };
            xhttp.ontimeout = function() {
                resolve(null); // Resolve with null on timeout
            };
            xhttp.onerror = function() {
                reject("Error checking for updates"); // Reject on error
            };
            xhttp.open('GET', _updateURL);
            xhttp.send();
        });
    }

    /**
     * Checks for mod updates by sending requests to the update URLs.
     * @param {object} _mods - An object containing mod IDs and their update URLs.
     */
    checkForModUpdates(_mods) {
        const modIDs = Object.keys(_mods);
        const promises = modIDs.map(modID => this.getUpdateCheckPromise(_mods[modID]));

        Promise.all(promises)
            .then(versions => {
                const modVersions = {};
                versions.forEach((version, index) => {
                    if (version !== null) {
                        modVersions[modIDs[index]] = version;
                    }
                });
                this.notifyBackendReceivedModVersions(modVersions);
            })
            .catch(error => {
                console.error("Something went wrong with FU Update checks:", error);
            });
    }

    /**
     * Notifies the backend with the received mod versions.
     * @param {object} _modVersions - An object containing mod IDs and their versions.
     */
    notifyBackendReceivedModVersions(_modVersions) {
        SQ.call(this.mSQHandle, "receiveModVersions", _modVersions);
    }
}

// Register the FUConnection screen
registerScreen("FUConnection", new FUConnection());



