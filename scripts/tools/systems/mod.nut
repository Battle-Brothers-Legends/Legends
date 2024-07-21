class Mod {
    ID = null;
    Name = null;
    Version = null;
    PreRelease = null;
    Metadata = null;

    // Systems
    Debug = null;
    Keybinds = null;
    ModSettings = null;
    Registry = null;
    Serialization = null;
    PersistentData = null;
    Tooltips = null;

    /**
     * Constructor for the Mod class.
     * @param _id {string} - The unique identifier for the mod.
     * @param _version {string} - The version of the mod following semantic versioning.
     * @param _name {string} - The display name of the mod. If null, it defaults to _id.
     */
    constructor(_id, _version, _name = null) {
        if (_name == null) _name = _id;
        requireString(_id, _version, _name);

        this.ID = _id;
        this.Name = _name;

        local versionTable = SemVer.getTable(_version);
        this.Version = versionTable.Version;
        this.PreRelease = versionTable.PreRelease;
        this.Metadata = versionTable.Metadata;

        // Register the mod with various systems
        System.Registry.registerMod(this);
        System.Debug.registerMod(this);
        System.ModSettings.registerMod(this);
        System.Keybinds.registerMod(this);
        System.Serialization.registerMod(this);
        System.PersistentData.registerMod(this);
        System.Tooltips.registerMod(this);
    }

    /**
     * Gets the display name of the mod.
     * @returns {string} - The display name of the mod.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the unique identifier of the mod.
     * @returns {string} - The unique identifier of the mod.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the short version string of the mod.
     * @returns {string} - The short version string of the mod.
     */
    function getShortVersionString() {
        return SemVer.getShortVersionString(this);
    }

    /**
     * Gets the full version string of the mod.
     * @returns {string} - The full version string of the mod.
     */
    function getVersionString() {
        return SemVer.getVersionString(this);
    }

    /**
     * Converts the mod information to a string.
     * @returns {string} - The string representation of the mod.
     */
    function tostring() {
        return format("Mod %s, Version %s\n", this.getID(), this.getVersionString());
    }

    function _tostring() {
        return this.tostring();
    }
}

//unit test for mod system
function testModClass() {
    local mod = Mod("TestMod", "1.0.0", "Test Mod");

    assert(mod.getID() == "TestMod");
    assert(mod.getName() == "Test Mod");
    assert(mod.getShortVersionString() == "1.0.0");
    assert(mod.getVersionString() == "1.0.0");
    assert(mod.tostring() == "Mod TestMod, Version 1.0.0\n");

    print("Mod class tests passed.");
}

// Run the test
//testModClass();

