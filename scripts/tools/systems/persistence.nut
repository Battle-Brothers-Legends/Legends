class SerializationSystem extends System {
    /**
     * Constructor for the SerializationSystem class.
     */
    constructor() {
        base.constructor(SystemID.Serialization);
    }

    /**
     * Registers a mod with the serialization system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        base.registerMod(_mod);
    }

    /**
     * Serializes a mod's data.
     * @param _mod {Mod} - The mod whose data to serialize.
     * @param _out {OutputStream} - The output stream to write to.
     */
    function serializeModData(_mod, _out) {
        Utils.serialize(_mod, _out);
    }

    /**
     * Deserializes a mod's data.
     * @param _input {InputStream} - The input stream to read from.
     * @returns {Mod} - The deserialized mod.
     */
    function deserializeModData(_input) {
        return Utils.deserialize(_input);
    }
}

//Unit test for serialization
function testSerializationSystem() {
    local serializationSystem = SerializationSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");

    local outStream = MockOutputStream();
    serializationSystem.serializeModData(mod, outStream);
    local serializedData = outStream.getBuffer();

    local inStream = MockInputStream(serializedData);
    local deserializedMod = serializationSystem.deserializeModData(inStream);

    assert(deserializedMod.getID() == mod.getID());
    assert(deserializedMod.getName() == mod.getName());
    assert(deserializedMod.getVersionString() == mod.getVersionString());

    print("SerializationSystem class tests passed.");
}

// Run the test
// testSerializationSystem();



class PersistentDataSystem extends System {
    PersistentData = {};

    /**
     * Constructor for the PersistentDataSystem class.
     */
    constructor() {
        base.constructor(SystemID.PersistentData);
    }

    /**
     * Registers a mod with the persistent data system.
     * @param _mod {Mod} - The mod to register.
     */
    function registerMod(_mod) {
        base.registerMod(_mod);
        this.PersistentData[_mod.getID()] <- {};
    }

    /**
     * Loads persistent data for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _key {string} - The key for the persistent data.
     * @returns {any} - The loaded persistent data.
     */
    function load(_modID, _key) {
        return this.PersistentData[_modID][_key];
    }

    /**
     * Saves persistent data for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _key {string} - The key for the persistent data.
     * @param _data {any} - The data to save.
     */
    function save(_modID, _key, _data) {
        this.PersistentData[_modID][_key] = _data;
    }

    /**
     * Removes persistent data for a mod.
     * @param _modID {string} - The ID of the mod.
     * @param _key {string} - The key for the persistent data.
     */
    function remove(_modID, _key) {
        delete this.PersistentData[_modID][_key];
    }
}


// An example of how to use it
function exampleUsage() {
    local mod1 = Mod("Mod1", "1.0.0", "First Mod");
    local mod2 = Mod("Mod2", "1.1.0", "Second Mod");

    // Register mods
    System.Registry.registerMod(mod1);
    System.Registry.registerMod(mod2);

    // Serialization System
    local outStream = MockOutputStream();
    System.Serialization.serializeModData(mod1, outStream);
    local serializedData = outStream.getBuffer();
    print("Serialized Mod1 Data: " + serializedData);

    local inStream = MockInputStream(serializedData);
    local deserializedMod1 = System.Serialization.deserializeModData(inStream);
    print("Deserialized Mod1: " + deserializedMod1);

    // Persistent Data System
    System.PersistentData.save(mod1.getID(), "Key1", "PersistentValue1");
    local persistentValue = System.PersistentData.load(mod1.getID(), "Key1");
    print("Loaded Persistent Value: " + persistentValue);

    System.PersistentData.remove(mod1.getID(), "Key1");
    persistentValue = System.PersistentData.load(mod1.getID(), "Key1");
    print("Loaded Persistent Value after Removal: " + persistentValue);

    // Tooltips System
    local tooltip = Tooltip("TooltipID", "This is a tooltip.");
    System.Tooltips.addTooltip(mod1.getID(), "Tooltip1", tooltip);
    local retrievedTooltip = System.Tooltips.getTooltip(mod1.getID(), "Tooltip1");
    print("Retrieved Tooltip: " + retrievedTooltip.getText());

    System.Tooltips.removeTooltip(mod1.getID(), "Tooltip1");
    retrievedTooltip = System.Tooltips.getTooltip(mod1.getID(), "Tooltip1");
    print("Retrieved Tooltip after Removal: " + retrievedTooltip);
}

// Uncomment to run the example usage function
// exampleUsage();

//a unit test of the persistent data system
function testPersistentDataSystem() {
    local persistentDataSystem = PersistentDataSystem();
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    persistentDataSystem.registerMod(mod);

    persistentDataSystem.save("TestMod", "Key1", "PersistentValue1");
    local value = persistentDataSystem.load("TestMod", "Key1");

    assert(value == "PersistentValue1");

    persistentDataSystem.remove("TestMod", "Key1");
    value = persistentDataSystem.load("TestMod", "Key1");

    assert(value == null);

    print("PersistentDataSystem class tests passed.");
}

// Run the test
//testPersistentDataSystem();

