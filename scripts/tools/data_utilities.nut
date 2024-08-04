/**
 * DataManager Class
 * 
 * This is the system-wide data manager that handles how mod data is saved and loaded across all mods.
 * Each mod is then given its own instance of the ModData class and functions which are further below.
 * Most of the time as a mod author you should be dealing with ModData rather than DataManager.
 * 
 * Key concepts:
 * Unlike MSU the DataManager handles both the loading of mod files, and the read/write to those files.
 * We don't separate Persistence and Serialization to make it easier to see how it all works. 
 * - this.ModList is a table storing data for each mod.
 * - ManagersToClear: A list of read/write managers that need to be cleared.
 * - Serialization: The process of converting complex data structures into a format that can be easily stored or transmitted.
 * 
 * Note for maintainers: This class interacts with the JavaScript frontend indirectly through the data it manages.
 * Changes in how data is structured here may require corresponding updates in the frontend.
 */
class DataManager {
    ModList = null;
    ModConfigPath = "mod_config/";
    ManagersToClear = null;
    Separator = "@";
    
    /**
     * Constructor for DataManager.
     * Initializes the Mods and ManagersToClear containers.
     */
    constructor() {
        this.ModList  = {};
        this.ManagersToClear = [];
    }

    /**
     * Registers a mod with the DataManager.
     * Initializes the mod's data and loads its configuration files.
     * @param {Mod} _mod - The mod object to register.
     */
    function registerMod(_mod) {
        if (typeof _mod != "instance" || !(_mod instanceof Mod)) {
            throw Exception.InvalidType(_mod);
        }

        _mod.DataManager = ModData(_mod);  // Initialize ModData for the mod
        this.addMod(_mod.getID());  // Add the mod to the Mods container
        this.importModFiles(_mod.getID());  // Load the mod's configuration files
    }

    /**
     * Adds a mod to the Mods container.
     * @param {string} _modID - The unique identifier for the mod.
     * @param {boolean} _reset - Flag indicating whether to reset the mod data if it already exists.
     */
    function addMod(_modID, _reset = false) {
        if (this.hasMod(_modID) && _reset == false) {
            return;
        }
        this.ModList [_modID] = {};
    }

    /**
     * Checks if a mod is registered in the Mods container.
     * @param {string} _modID - The unique identifier for the mod.
     * @returns {boolean} - True if the mod is registered, false otherwise.
     */
    function hasMod(_modID) {
        return _modID in this.ModList ;
    }

    /**
     * Retrieves the data for a registered mod.
     * @param {string} _modID - The unique identifier for the mod.
     * @returns {table} - The mod's data.
     * @throws {Exception.KeyNotFound} - If the mod is not registered.
     */
    function getMod(_modID) {
        if (!this.hasMod(_modID)) {
            throw Exception.KeyNotFound(_modID);
        }
        return this.ModList [_modID];
    }

    /**
     * Imports the configuration files for a mod.
     * @param {string} _modID - The unique identifier for the mod.
     */
    function importModFiles(_modID) {
        local modDataDirectory = IO.enumerateFiles(this.ModConfigPath + _modID);
        if (modDataDirectory == null) {
            return;
        }
        foreach (file in modDataDirectory) {
            local components = split(file, "/");
            local modID = components[1];
            local fileType = components[2];
            this.ModList [_modID][fileType] = file;
        }
    }

    /**
     * Loads a specific configuration file for a mod.
     * @param {string} _modID - The unique identifier for the mod.
     * @param {string} _fileID - The unique identifier for the file.
     * @returns {boolean} - True if the file was loaded, false otherwise.
     */
    function loadModFile(_modID, _fileID) {
        if (_fileID in this.getMod(_modID)) {
            include(this.getMod(_modID)[_fileID]);
            return true;
        }
        return false;
    }

    /**
     * Loads all configuration files for a mod.
     * @param {string} _modID - The unique identifier for the mod.
     * @throws {Exception.KeyNotFound} - If the mod is not registered.
     */
    function loadAllModFiles(_modID) {
        if (!this.hasMod(_modID)) {
            throw Exception.KeyNotFound(_modID);
        }

        foreach (file in this.getMod(_modID)) {
            this.loadModFile(_modID, file);
        }
    }

    /**
     * Serializes (writes) data for a mod.
     * 
     * This method is crucial for saving mod data. Key points:
     * 1. It uses a WriteManager, which mimics the game's serialization system.
     * 2. It checks if the object is a "BB object" (Battle Brothers game object), which needs to be broken up before being written.
     * 3. It stores the serialized data in a "flag container", which is a game-specific storage mechanism.
     * 
     * @param _mod The mod object.
     * @param _id A unique identifier for this data.
     * @param _object The data to serialize.
     * @param _flags Optional flags to control serialization behavior.
     * 
     * @throws Exception.InvalidType if _object is a BB object.
     */
    function writeData(_mod, _id, _object, _flags = null) {
        if (isBBObject(_object)) {
            throw Exception.InvalidType("_object");
        }
        if (_flags == null) _flags = World.Flags;

        local outManager = WriteManager(_mod, _id, _flags);
        this.ManagersToClear.push(outManager);
        this.write(_object, outManager);
        outManager.storeDataInFlagContainer();
    }

    /**
     * Deserializes (reads) data from a flag container into an object.
     * @param {Mod} _mod - The mod object.
     * @param {string} _id - The unique identifier for the serialized data.
     * @param {variant} _defaultValue - The default value if deserialization fails.
     * @param {variant} _object - Optional object to deserialize into.
     * @param {table} _flags - Optional flags for deserialization.
     * @returns {variant} - The deserialized object.
     */
    function readData(_mod, _id, _defaultValue, _object = null, _flags = null) {
        if (isBBObject(_object)) {
            throw Exception.InvalidType("_object");
        }
        if (_flags == null) _flags = World.Flags;

        local inManager = ReadManager(_mod, _id, _flags);
        if (!inManager.loadDataFromFlagContainer()) return _defaultValue;
        return _object == null ? this.read(inManager) : this.readInto(_object, inManager);
    }

    /**
     * Clears all flags in the ManagersToClear container.
     */
    function clearFlags() {
        foreach (flagContainer in this.ManagersToClear)
            flagContainer.clearFlags();
        this.ManagersToClear.clear();
    }

    /**
     * Logs data for a mod.
     * @param {string} _fileID - The unique identifier for the file.
     * @param {string} _modID - The unique identifier for the mod.
     * @param {variant} _payload - The data to log.
     */
    function logData(_fileID, _modID, _payload) {
        local result = format("%sBBPARSER%s%s%s%s", this.Separator, this.Separator, _fileID, this.Separator, _modID);
        if (typeof _payload != "array") {
            _payload = [_payload];
        }
        foreach (arg in _payload) {
            requireAnyTypeExcept(["array", "table", "class"], arg);
            result += this.Separator + arg;
        }
        result += this.Separator;
        logInfo(result);
    }

}

// Alias for backwards compatibility. This means calls to MSU will work in FU.
::MSU.Class.PersistentDataSystem <- DataManager;
::MSU.Class.SerializationSystem <- DataManager;





/**
 * Class representing mod-specific data management.
 * This class handles data and serialization for a specific mod.
 */
class ModData {
    Mod = null;

    /**
     * Constructor for ModData.
     * @param {Mod} _mod - The mod object.
     */
    constructor(_mod) {
        this.Mod = _mod;
    }

    /**
     * Loads a specific configuration file for the mod.
     * @param {string} _fileID - The unique identifier for the file.
     */
    function loadFile(_fileID) {
        DataManager.loadModFile(this.Mod.getID(), _fileID);
    }

    /**
     * Loads all configuration files for the mod.
     */
    function loadAllFiles() {
        DataManager.loadAllModFiles(this.Mod.getID());
    }

    /**
     * Serializes (writes) an object and stores it in a flag container.
     * @param {string} _id - The unique identifier for the serialized data.
     * @param {variant} _object - The object to serialize.
     * @param {table} _flags - Optional flags for serialization.
     */
    function write(_id, _object, _flags = null) {
        DataManager.writeData(this.Mod, _id, _object, _flags);
    }

    /**
     * Deserializes (reads) data from a flag container into an object.
     * @param {string} _id - The unique identifier for the serialized data.
     * @param {variant} _defaultValue - The default value if deserialization fails.
     * @param {variant} _object - Optional object to deserialize into.
     * @param {table} _flags - Optional flags for deserialization.
     * @returns {variant} - The deserialized object.
     */
    function read(_id, _defaultValue, _object = null, _flags = null) {
        return DataManager.readData(this.Mod, _id, _defaultValue, _object, _flags);
    }

    /**
     * Gets a read manager for the mod.
     * @param {string} _id - The unique identifier for the serialized data.
     * @param {table} _flags - Optional flags for deserialization.
     * @returns {ReadManager} - The read manager.
     */
    function getReadManager(_id, _flags = null) {
        return DataManager.getReadManager(this.Mod, _id, _flags);
    }

    /**
     * Gets a write manager for the mod.
     * @param {string} _id - The unique identifier for the serialized data.
     * @param {table} _flags - Optional flags for serialization.
     * @returns {WriteManager} - The write manager.
     */
    function getWriteManager(_id, _flags = null) {
        return DataManager.getWriteManager(this.Mod, _id, _flags);
    }

    /**
     * Logs data for the mod.
     * @param {string} _fileID - The unique identifier for the file.
     * @param {variant} _payload - The data to log.
     */
    function logData(_fileID, _payload) {
        DataManager.logData(_fileID, this.Mod.getID(), _payload);
    }
}

// Alias for backwards compatibility. This means your existing mod calls for MSU will just work in FU.
// We'll keep interoperability with MSU 127 but won't keep updating.
// You might want to update to the new calls if you like the new metaphors and structure.
// You don't have to though, you do you.
//
::FU.Class.PersistentModAddon <- ModData;
::FU.Class.SerializationModAddon <- ModData;

// Test function for ModData
function testModData() {
    local mod = Mod("testMod");
    local modData = ModData(mod);
    modData.loadFile("testFile");
    modData.write("testID", { key = "value" });
    local deserializedData = modData.read("testID", { key = "default" });
    modData.logData("testFile", "testPayload");
    // Add more test cases as needed
}
// Run the test
// testModData();

// Test function for DataManager
function testDataManager() {
    local manager = DataManager();
    local mod = Mod("testMod");
    manager.registerMod(mod);
    manager.logData("testFile", mod.getID(), "testPayload");

}
// Run the test
// testDataManager();


function testRegisterMod() {
    local manager = DataManager();
    local mod = Mod("testMod");
    manager.registerMod(mod);
    assert(manager.hasMod("testMod"));
    print("Test registerMod passed.");
}

function testAddMod() {
    local manager = DataManager();
    manager.addMod("testMod");
    assert(manager.hasMod("testMod"));
    manager.addMod("testMod", true);  // Resetting should still pass
    assert(manager.hasMod("testMod"));
    print("Test addMod passed.");
}

function testImportModFiles() {
    local manager = DataManager();
    // Mock IO function
    IO.enumerateFiles <- function(path) {
        return path == "mod_config/testMod" ? ["testMod/config1", "testMod/config2"] : null;
    };
    manager.addMod("testMod");
    manager.importModFiles("testMod");
    assert("config1" in manager.getMod("testMod"));
    assert("config2" in manager.getMod("testMod"));
    print("Test importModFiles passed.");
}

function testLoadModFile() {
    local manager = DataManager();
    // Mock include function
    include <- function(file) {
        print("Included: " + file);
    };
    manager.addMod("testMod");
    manager.getMod("testMod")["config1"] <- "mod_config/testMod/config1";
    assert(manager.loadModFile("testMod", "config1"));
    assert(!manager.loadModFile("testMod", "nonExistentConfig"));
    print("Test loadModFile passed.");
}

function testLoadAllModFiles() {
    local manager = DataManager();
    // Mock include function
    include <- function(file) {
        print("Included: " + file);
    };
    manager.addMod("testMod");
    manager.getMod("testMod")["config1"] <- "mod_config/testMod/config1";
    manager.getMod("testMod")["config2"] <- "mod_config/testMod/config2";
    manager.loadAllModFiles("testMod");
    print("Test loadAllModFiles passed.");
}

function testWriteAndReadData() {
    local manager = DataManager();
    local mod = Mod("testMod");
    manager.registerMod(mod);
    local dataToWrite = { key1 = 123, key2 = "value", key3 = [1, 2, 3] };
    manager.writeData(mod, "testDataID", dataToWrite);

    local readData = manager.readData(mod, "testDataID", {});
    assert(compareTables(dataToWrite, readData));
    print("Test writeData and readData passed.");
}

function testClearFlags() {
    local manager = DataManager();
    local mod = Mod("testMod");
    manager.registerMod(mod);
    local dataToWrite = { key1 = 123, key2 = "value", key3 = [1, 2, 3] };
    manager.writeData(mod, "testDataID", dataToWrite);

    manager.clearFlags();
    assert(manager.ManagersToClear.len() == 0);
    print("Test clearFlags passed.");
}

function testLogData() {
    local manager = DataManager();
    manager.logData("testFileID", "testModID", "testPayload");
    print("Test logData passed.");
}


// Run the test for dataManager
//testRegisterMod();
//testAddMod();
//testImportModFiles();
//testLoadModFile();
//testLoadAllModFiles();
//testWriteAndReadData();
//testClearFlags();
//testLogData();
//testGetDataType();
//testSerialization();
//testMergeTables();
//testOperatorCompare();

