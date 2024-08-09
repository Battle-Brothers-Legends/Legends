
class ::FU.Class.DebugSystem extends ::FU.Class.System {
    ModIDs = [];
    ModDebugData = {};

    /**
     * Constructor for the DebugSystem class.
     */
    constructor() {
        base.constructor(SystemID.Debug);
    }

    /**
     * Registers a mod with the debug system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        base.registerMod(_mod);
        this.ModIDs.append(_mod.getID());
        this.ModDebugData[_mod.getID()] <- [];
    }

    /**
     * Logs debug data for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _data {string} - The debug data to log.
     */
    function log(_modID, _data) {
        this.ModDebugData[_modID].append(_data);
    }

    /**
     * Retrieves debug data for a mod.
     * @param _modID {string} - The ID of the mod.
     * @returns {array} - The debug data for the mod.
     */
    function getDebugData(_modID) {
        return this.ModDebugData[_modID];
    }

    /**
     * Prints debug data for all registered mods.
     */
    function printAllDebugData() {
        foreach (modID in this.ModIDs) {
            print(format("Debug data for mod %s:", modID));
            foreach (data in this.ModDebugData[modID]) {
                print(data);
            }
        }
    }
}

//unit test for debug system
function testDebugSystem() {
    local debugSystem = DebugSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    debugSystem.registerMod(mod);

    debugSystem.log("TestMod", "Test debug message");
    local debugData = debugSystem.getDebugData("TestMod");

    assert(debugData.len() == 1);
    assert(debugData[0] == "Test debug message");

    print("DebugSystem class tests passed.");
}

// Run the test
// testDebugSystem();

