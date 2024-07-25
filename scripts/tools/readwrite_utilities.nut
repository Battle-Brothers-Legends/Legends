/**
 *
 * Read and Write Utilities
 *
 * Contents: 
 * DataProcessor - writing, reading and data handling
 *  L__Write - for writing direct to filesystem
 *  L__Read - for reading direct from filesystem
 * ReadWriteTemplate 
 *  L__ReadManager  - reading from the vanilla game's _in storage object 
 *  L__WriteManager - writing into the vanilla game's _out storage object
 *  L__MetadataManager - handles the vanilla game's MetaData object
 * Compatability functions
 * Test cases     
 *
 */


class DataProcessor {
    constructor() {
        this.DataType = {
            "Integer": 0,
            "Float": 1,
            "Boolean": 2,
            "String": 3,
            "Array": 4,
            "Table": 5,
            "Class": 6,
            "Instance": 7,
            "Null": 8
        };
        this.Timers <- {};
        this.States <- {};
    }

    // Returns the data type code for the given variable
    // _var: the variable to check
    // Returns an integer representing the data type
    function getDataType(_var) {
        switch (typeof _var) {
            case "integer":
                return this.DataType.Integer;
            case "float":
                return this.DataType.Float;
            case "bool":
                return this.DataType.Boolean;
            case "string":
                return this.DataType.String;
            case "array":
                return this.DataType.Array;
            case "table":
                return this.DataType.Table;
            case "class":
                return this.DataType.Class;
            case "instance":
                return this.DataType.Instance;
            case "null":
                return this.DataType.Null;
            default:
                throw "Invalid data type: " + typeof _var;
        }
    }

    // Serializes (writes) an object to a binary format
    // _object: the object to serialize (must be an array or table)
    // _out: the output stream to write to
    function write(_object, _out) {
        requireOneFromTypes(["array", "table"], _object);

        local type = typeof _object;
        local isTable = type == "table";

        _out.writeU8(isTable ? this.DataType.Table : this.DataType.Array);
        _out.writeU32(_object.len());

        foreach (key, element in _object) {
            if (isTable) _out.writeString(key);
            local dataType = this.getDataType(element);

            switch (dataType) {
                case this.DataType.Integer:
                    _out.writeU8(this.DataType.Integer);
                    if (element < 0) {
                        _out.writeBool(true);
                        _out.writeI32(element);
                    } else {
                        _out.writeBool(false);
                        _out.writeU32(element);
                    }
                    break;
                case this.DataType.Float:
                    _out.writeU8(this.DataType.Float);
                    _out.writeF32(element);
                    break;
                case this.DataType.Boolean:
                    _out.writeU8(this.DataType.Boolean);
                    _out.writeBool(element);
                    break;
                case this.DataType.String:
                    _out.writeU8(this.DataType.String);
                    _out.writeString(element);
                    break;
                case this.DataType.Array:
                    _out.writeU8(this.DataType.Array);
                    this.write(element, _out);
                    break;
                case this.DataType.Table:
                    _out.writeU8(this.DataType.Table);
                    this.write(element, _out);
                    break;
                case this.DataType.Null:
                    _out.writeU8(this.DataType.Null);
                    break;
                default:
                    throw "Invalid data type during write: " + typeof element;
            }
        }
    }

    // Deserializes (reads) an object from a binary format
    // _in: the input stream to read from
    // Returns the deserialized object (array or table)
    function read(_in) {
        local type = _in.readU8();
        local isTable = type == this.DataType.Table;
        local size = _in.readU32();

        local ret = isTable ? {} : array(size);

        for (local i = 0; i < size; i++) {
            local key = isTable ? _in.readString() : null;
            local dataType = _in.readU8();
            local val;

            switch (dataType) {
                case this.DataType.Integer:
                    val = _in.readBool() ? _in.readI32() : _in.readU32();
                    break;
                case this.DataType.Float:
                    val = _in.readF32();
                    break;
                case this.DataType.Boolean:
                    val = _in.readBool();
                    break;
                case this.DataType.String:
                    val = _in.readString();
                    break;
                case this.DataType.Array:
                case this.DataType.Table:
                    val = this.read(_in);
                    break;
                case this.DataType.Null:
                    val = null;
                    break;
                default:
                    throw "Invalid data type during read: " + dataType;
            }

            if (isTable) ret[key] <- val;
            else ret[i] = val;
        }

        return ret;
    }

    // Deserializes (reads) into an existing object (array or table)
    // _object: the object to deserialize into (must be an array or table)
    // _in: the input stream to read from
    // Returns the modified object
    function readInto(_object, _in) {
        requireOneFromTypes(["table", "array"], _object);

        local deserializedObj = this.read(_in);

        if (typeof _object == "table") return mergeTables(_object, deserializedObj);

        _object.resize(math.max(_object.len(), deserializedObj.len()));
        foreach (i, value in deserializedObj) {
            _object[i] = value;
        }
        return _object;
    }

    // Merges two tables into one
    // tbl1: the first table
    // tbl2: the second table
    // Returns the merged table
    function mergeTables(tbl1, tbl2) {
        foreach (key, value in tbl2) {
            tbl1[key] = value;
        }
        return tbl1;
    }

    // Compares two values using a specified operator
    // _compareResult: the result of a comparison (-1, 0, 1)
    // _operator: the comparison operator (e.g., "==", "!=", "<", ">", "<=", ">=")
    // Returns true if the comparison is valid, false otherwise
    function operatorCompare(_compareResult, _operator) {
        switch (_compareResult) {
            case -1:
                if (["<", "<="].find(_operator) != null) return true;
                return false;
            case 0:
                if (["<=", "==", null, ">="].find(_operator) != null) return true;
                return false;
            case 1:
                if ([">", ">="].find(_operator) != null) return true;
                return false;
        }
        throw "Invalid comparison result: " + _compareResult;
    }

    // Returns the currently active state
    // Returns the active state or null if no active state is found
    function getActiveState() {
        foreach (name, state in this.States) {
            if (state != null && state.isVisible() && name != "root_state") {
                return state;
            }
        }
        return null;
    }

    // Checks if a state exists by ID
    // _id: the state ID
    // Returns true if the state exists, false otherwise
    function hasState(_id) {
        return (_id in this.States && this.States[_id] != null);
    }

    // Gets a state by ID
    // _id: the state ID
    // Returns the state or throws an error if the state is not found
    function getState(_id) {
        if (!(_id in this.States)) {
            logError("_id must be a valid state name!");
            throw "KeyNotFound: " + _id;
        }
        return this.States[_id];
    }

    // Gets or creates a timer by ID
    // _id: the timer ID
    // Returns the timer
    function Timer(_id) {
        if (_id in this.Timers) return this.Timers[_id];
        this.Timers[_id] <- TimerClass(_id);
        return this.Timers[_id];
    }

    // Logs an error message
    function logError(message) {
        print("Error: " + message);
    }

    // Checks if a string represents an integer
    function isInteger(_string) {
        foreach (char in _string) {
            if (char < '0' || char > '9') return false;
        }
        return true;
    }
}

// Helper function to simulate a binary output stream
class MockOutputStream {
    buffer = ""

    function writeU8(value) {
        this.buffer += format("U8:%d|", value);
    }

    function writeU32(value) {
        this.buffer += format("U32:%d|", value);
    }

    function writeI32(value) {
        this.buffer += format("I32:%d|", value);
    }

    function writeF32(value) {
        this.buffer += format("F32:%f|", value);
    }

    function writeBool(value) {
        this.buffer += format("Bool:%s|", value ? "true" : "false");
    }

    function writeString(value) {
        this.buffer += format("String:%s|", value);
    }

    function getBuffer() {
        return this.buffer;
    }
}

// Helper function to simulate a binary input stream
class MockInputStream {
    index = 0;
    buffer = []

    function constructor(data) {
        this.buffer = split(data, "|");
    }

    function readU8() {
        return this._parse("U8:");
    }

    function readU32() {
        return this._parse("U32:");
    }

    function readI32() {
        return this._parse("I32:");
    }

    function readF32() {
        return this._parse("F32:");
    }

    function readBool() {
        return this._parse("Bool:") == "true";
    }

    function readString() {
        return this._parse("String:");
    }

    function _parse(prefix) {
        local entry = this.buffer[this.index++];
        if (entry.find(prefix) == 0) {
            return entry.slice(prefix.len()).tointeger();
        }
        throw "Invalid data format: " + entry;
    }
}

// Test function for DataProcessor
function testDataProcessor() {
    local processor = DataProcessor();

    local originalTable = {
        key1 = 123,
        key2 = 45.67,
        key3 = true,
        key4 = "Hello",
        key5 = [1, 2, 3],
        key6 = {
            nestedKey = "NestedValue"
        }
    };

    // Write
    local outStream = MockOutputStream();
    processor.write(originalTable, outStream);
    local writtenData = outStream.getBuffer();
    print("Written Data: " + writtenData);

    // Read
    local inStream = MockInputStream(writtenData);
    local readTable = processor.read(inStream);

    // Compare original and read tables
    local isEqual = compareTables(originalTable, readTable);
    print("DataProcessor Test Passed: " + isEqual);
}

// Helper function to compare two tables
function compareTables(tbl1, tbl2) {
    foreach (key, value in tbl1) {
        if (typeof value == "table") {
            if (!compareTables(value, tbl2[key])) return false;
        } else if (tbl2[key] != value) {
            return false;
        }
    }
    return true;
}

// Base for the Write and Read Managers
class ReadWriteTemplate {
    static __IDRegex = regexp("^.*\\.\\d+$");
    Data = null;
    Mod = null;
    ID = null;
    MetaData = null;
    FlagContainer = null;

    /**
     * Constructor for the ReadWriteTemplate class.
     * @param _mod {Mod} - The mod to which the manager belongs.
     * @param _id {string} - The unique identifier for the manager.
     * @param _flagContainer {table} - The flag container.
     * @param _metaDataManager {MetaDataManager} - The metadata manager.
     */
    constructor(_mod, _id, _flagContainer, _metaDataManager = null) {
        if (_metaDataManager == null) _metaDataManager = clone ::FU.System.Serialization.MetaData;
        if (this.__IDRegex.match(_id)) {
            ::logError("The ID passed to flag serialization cannot end with a full stop followed by digits so it doesn't collide with internal FU flags");
            throw ::FU.Exception.InvalidValue(_id);
        }
        this.Data = [];
        this.Mod = _mod;
        this.ID = _id;
        this.FlagContainer = _flagContainer;
        this.MetaData = _metaDataManager;
    }

    /**
     * Gets the manager string.
     * @returns {string} - The manager string.
     */
    function getManagerString() {
        return format("FU.%s.%s", this.Mod.getID(), this.ID);
    }

    /**
     * Clears the flags in the flag container.
     */
    function clearFlags() {
        local startString = this.getManagerString();
        this.FlagContainer.remove(startString);
        for (local i = 0; i < this.Data.len(); ++i) {
            this.FlagContainer.remove(startString + "." + i);
        }
    }

    /**
     * Gets the metadata.
     * @returns {MetaDataManager} - The metadata manager.
     */
    function getMetaData() {
        return this.MetaData;
    }
}

// Emulates the _out object passed to onWrite functions
class WriteManager extends ReadWriteTemplate {
    IsIncremental = false;

    /**
     * Sets the incremental flag.
     * @param _bool {boolean} - The flag value.
     */
    function setIncremental(_bool) {
        this.IsIncremental = _bool;
    }

    /**
     * Writes data to the flag container.
     * @param _data {variant} - The data to write.
     */
    function __writeData(_data) {
        this.Data.push(_data);
        if (this.IsIncremental) {
            local startString = this.getManagerString();
            this.FlagContainer.set(startString, this.Data.len());
            this.FlagContainer.set(startString + "." + (this.Data.len() - 1), _data);
        }
    }

    /**
     * Writes a string to the flag container.
     * @param _string {string} - The string to write.
     */
    function writeString(_string) {
        this.__writeData(_string);
    }

    /**
     * Writes an integer to the flag container.
     * @param _int {integer} - The integer to write.
     */
    function __writeInt(_int) {
        this.__writeData(_int);
    }

    /**
     * Writes a float to the flag container.
     * @param _float {float} - The float to write.
     */
    function __writeFloat(_float) {
        this.__writeData(_float);
    }

    /**
     * Writes a boolean to the flag container.
     * @param _bool {boolean} - The boolean to write.
     */
    function writeBool(_bool) {
        this.__writeData(_bool);
    }

    function writeI32(_int) {
        this.__writeInt(_int);
    }

    function writeU32(_int) {
        this.__writeInt(_int);
    }

    function writeI16(_int) {
        this.__writeInt(_int);
    }

    function writeU16(_int) {
        this.__writeInt(_int);
    }

    function writeI8(_int) {
        this.__writeInt(_int);
    }

    function writeU8(_int) {
        this.__writeInt(_int);
    }

    function writeF32(_float) {
        this.__writeFloat(_float);
    }

    /**
     * Stores data in the flag container.
     */
    function storeDataInFlagContainer() {
        if (this.IsIncremental) {
            ::logError("Called storeDataInFlagContainer for an Incremental WriteManager");
            throw ::FU.Exception.InvalidValue();
        }
        local startString = this.getManagerString();
        this.FlagContainer.set(startString, this.Data.len());
        foreach (idx, element in this.Data) {
            this.FlagContainer.set(startString + "." + idx, element);
        }
    }
}

// Emulates the _in object passed to onRead functions
class ReadManager extends ReadWriteTemplate {
    Idx = -1;

    /**
     * Reads data from the flag container.
     * @returns {variant} - The read data.
     */
    function __readData() {
        if (this.Data.len() <= ++this.Idx) {
            ::logError(format("Tried to read data beyond (%i) the length (%i) of the ReadManager", this.Idx, this.Data.len()));
            return null;
        }
        return this.Data[this.Idx];
    }

    /**
     * Reads a string from the flag container.
     * @returns {string} - The read string.
     */
    function readString() {
        return this.__readData();
    }

    /**
     * Reads an integer from the flag container.
     * @returns {integer} - The read integer.
     */
    function __readInt() {
        return this.__readData();
    }

    /**
     * Reads a float from the flag container.
     * @returns {float} - The read float.
     */
    function __readFloat() {
        return this.__readData();
    }

    /**
     * Reads a boolean from the flag container.
     * @returns {boolean} - The read boolean.
     */
    function readBool() {
        return this.__readData();
    }

    function readI32() {
        return this.__readInt();
    }

    function readU32() {
        return this.__readInt();
    }

    function readI16() {
        return this.__readInt();
    }

    function readU16() {
        return this.__readInt();
    }

    function readI8() {
        return this.__readInt();
    }

    function readU8() {
        return this.__readInt();
    }

    function readF32() {
        return this.__readFloat();
    }

    /**
     * Loads data from the flag container.
     * @returns {boolean} - True if the data was successfully loaded, false otherwise.
     */
    function loadDataFromFlagContainer() {
        local startString = this.getManagerString();
        if (!this.FlagContainer.has(startString)) return false;
        this.Data = array(this.FlagContainer.get(startString));
        this.FlagContainer.remove(startString);
        for (local i = 0; i < this.Data.len(); ++i) {
            local currentFlag = startString + "." + i;
            if (!this.FlagContainer.has(currentFlag)) return false;
            this.Data[i] = this.FlagContainer.get(currentFlag);
            this.FlagContainer.remove(currentFlag);
        }
        return true;
    }
}

// Emulates the metadata object that can be gotten from _in.getMetadata() or _out.getMetadata() during on(Read/Write) function calls
class MetaDataManager {
    Version = null;
    Data = null;

    /**
     * Constructor for the MetaDataManager class.
     */
    constructor() {
        this.Data = {};
        this.Version = ::Const.Serialization.Version;
    }

    /**
     * Gets the version.
     * @returns {string} - The version.
     */
    function getVersion() {
        return this.Version;
    }

    /**
     * Sets the version.
     * @param _version {string} - The version to set.
     */
    function setVersion(_version) {
        this.Version = _version;
    }

    /**
     * Gets a value from the data.
     * @param _key {string} - The key of the value.
     * @returns {variant} - The value.
     */
    function __getValue(_key) {
        return this.Data[_key];
    }

    /**
     * Sets a value in the data.
     * @param _key {string} - The key of the value.
     * @param _value {variant} - The value to set.
     */
    function __setValue(_key, _value) {
        this.Data[_key] <- _value;
    }

    /**
     * Gets an integer from the data.
     * @param _key {string} - The key of the integer.
     * @returns {integer} - The integer.
     */
    function getInt(_key) {
        return this.__getValue(_key);
    }

    /**
     * Sets an integer in the data.
     * @param _key {string} - The key of the integer.
     * @param _value {integer} - The integer to set.
     */
    function setInt(_key, _value) {
        ::FU.requireInt(_value);
        this.__setValue(_key, _value);
    }

    /**
     * Gets a string from the data.
     * @param _key {string} - The key of the string.
     * @returns {string} - The string.
     */
    function getString(_key) {
        return this.__getValue(_key);
    }

    /**
     * Sets a string in the data.
     * @param _key {string} - The key of the string.
     * @param _value {string} - The string to set.
     */
    function setString(_key, _value) {
        ::FU.requireString(_value);
        this.__setValue(_key, _value);
    }

    /**
     * Gets a float from the data.
     * @param _key {string} - The key of the float.
     * @returns {float} - The float.
     */
    function getFloat(_key) {
        return this.__getValue(_key);
    }

    /**
     * Sets a float in the data.
     * @param _key {string} - The key of the float.
     * @param _value {float} - The float to set.
     */
    function setFloat(_key, _value) {
        ::FU.requireFloat(_value);
        this.__setValue(_key, _value);
    }

    /**
     * Checks if the data has a given key.
     * @param _key {string} - The key to check.
     * @returns {boolean} - True if the key exists, false otherwise.
     */
    function hasData(_key) {
        return _key in this.Data;
    }

    /**
     * Dummy function for getting the name.
     * @returns {string} - An empty string.
     */
    function getName() {
        return "";
    }

    /**
     * Dummy function for getting the modification date.
     * @returns {string} - An empty string.
     */
    function getModificationDate() {
        return "";
    }

    /**
     * Dummy function for getting the creation date.
     * @returns {string} - An empty string.
     */
    function getCreationDate() {
        return "";
    }

    /**
     * Dummy function for getting the file name.
     * @returns {string} - An empty string.
     */
    function getFileName() {
        return "";
    }

    /**
     * Clones the original metadata.
     * @param _original {MetaDataManager} - The original metadata.
     */
    function _cloned(_original) {
        this.Data = clone _original.Data;
        this.Version = _original.Version;
    }
}

// Aliases for backward compatibility
::MSU.Class.SerDeEmulator <- ReadWriteTemplate;
::MSU.Class.SerializationEmulator <- WriteManager;
::MSU.Class.DeserializationEmulator <- ReadManager;
::MSU.Class.MetaDataEmulator <- MetaDataManager;
::MSU.Class.Util <- DataProcessor;

// Test function for test Managers
function testManagers() {
    local mod = Mod("TestMod", "1.0.0", "Test Mod");
    local flagContainer = {};  // Placeholder for the actual flag container

    // Testing WriteManager
    local writeManager = WriteManager(mod, "TestID", flagContainer);
    writeManager.writeString("Test String");
    writeManager.writeInt(42);
    writeManager.writeFloat(3.14);
    writeManager.writeBool(true);
    writeManager.storeDataInFlagContainer();
    print("WriteManager tests passed.");

    // Testing ReadManager
    local readManager = ReadManager(mod, "TestID", flagContainer);
    readManager.loadDataFromFlagContainer();
    assert(readManager.readString() == "Test String");
    assert(readManager.readInt() == 42);
    assert(readManager.readFloat() == 3.14);
    assert(readManager.readBool() == true);
    print("ReadManager tests passed.");

    // Testing MetaDataManager
    local metaDataManager = MetaDataManager();
    metaDataManager.setInt("TestInt", 123);
    metaDataManager.setString("TestString", "Hello, World!");
    metaDataManager.setFloat("TestFloat", 1.23);
    assert(metaDataManager.getInt("TestInt") == 123);
    assert(metaDataManager.getString("TestString") == "Hello, World!");
    assert(metaDataManager.getFloat("TestFloat") == 1.23);
    print("MetaDataManager tests passed.");
}

// Uncomment to run the test
// testManagers();

