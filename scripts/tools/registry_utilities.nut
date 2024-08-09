class ::FU.Class.RegistrySystem extends ::FU.Class.System {
    RegisteredMods = {};

    /**
     * Constructor for the RegistrySystem class.
     */
    constructor() {
        base.constructor(SystemID.Registry);
    }

    /**
     * Registers a mod with the registry system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
    local modID = _mod.getID();
    if (modID == null || modID == "") {
        this.logError("Invalid mod ID when registering mod: " + _mod);
        return;
    }
    this.logInfo("Registering mod: " + modID);
    this.RegisteredMods[modID] <- _mod
    }

    /**
     * Retrieves a mod by its ID.
     * @param _modID {string} - The ID of the mod.
     * @returns {Mod} - The requested mod.
     */
    function getMod(_modID) {
        return this.RegisteredMods[_modID];
    }

    /**
     * Retrieves all registered mods.
     * @returns {array} - An array of all registered mods.
     */
    function getAllMods() {
        local mods = [];
        foreach (modID, mod in this.RegisteredMods) {
            mods.append(mod);
        }
        return mods;
    }

    /**
     * Unregisters a mod from the registry system.
     * @param _modID {string} - The ID of the mod.
     */
    function unregisterMod(_modID) {
        delete this.RegisteredMods[_modID];
    }
}


// Example usage of the systems
function exampleUsage() {
    local mod1 = Mod("Mod1", "1.0.0", "First Mod");
    local mod2 = Mod("Mod2", "1.1.0", "Second Mod");

    // Register mods
    System.Registry.registerMod(mod1);
    System.Registry.registerMod(mod2);

    // Add settings for mods
    local setting1 = Setting("Setting1", "First Setting", "DefaultValue");
    System.ModSettings.addSetting(mod1.getID(), setting1);
    local setting2 = Setting("Setting2", "Second Setting", "DefaultValue");
    System.ModSettings.addSetting(mod2.getID(), setting2);

    // Log debug data
    System.Debug.log(mod1.getID(), "Debug data for Mod1");
    System.Debug.log(mod2.getID(), "Debug data for Mod2");

    // Print all debug data
    System.Debug.printAllDebugData();

    // Retrieve and print mod settings
    print("Settings for Mod1:");
    foreach (setting in System.ModSettings.getSettings(mod1.getID())) {
        print(setting.tostring());
    }

    print("Settings for Mod2:");
    foreach (setting in System.ModSettings.getSettings(mod2.getID())) {
        print(setting.tostring());
    }

    // Unregister a mod
    System.Registry.unregisterMod(mod2.getID());
    print("Mod2 unregistered.");
}
// Unit test for Registry
function testRegistrySystem() {
    local registrySystem = RegistrySystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    registrySystem.registerMod(mod);

    assert(registrySystem.getMod("TestMod") == mod);

    registrySystem.unregisterMod("TestMod");
    assert(registrySystem.getMod("TestMod") == null);

    print("RegistrySystem class tests passed.");
}

// Run the test
//testRegistrySystem();


// Uncomment to run the example usage function
// exampleUsage();

