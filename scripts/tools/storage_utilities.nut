class Utils {
    constructor() {
        this.DataType = {
            Integer: 0,
            Float: 1,
            Boolean: 2,
            String: 3,
            Array: 4,
            Table: 5,
            Class: 6,
            Instance: 7,
            Null: 8
        };
        this.Timers = {};
        this.States = {};
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

    // Serializes an object to a binary format
    // _object: the object to serialize (must be an array or table)
    // _out: the output stream to write to
    function serialize(_object, _out) {
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
                    this.serialize(element, _out);
                    break;
                case this.DataType.Table:
                    _out.writeU8(this.DataType.Table);
                    this.serialize(element, _out);
                    break;
                case this.DataType.Null:
                    _out.writeU8(this.DataType.Null);
                    break;
                default:
                    throw "Invalid data type during serialization: " + typeof element;
            }
        }
    }

    // Deserializes an object from a binary format
    // _in: the input stream to read from
    // Returns the deserialized object (array or table)
    function deserialize(_in) {
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
                    val = this.deserialize(_in);
                    break;
                case this.DataType.Null:
                    val = null;
                    break;
                default:
                    throw "Invalid data type during deserialization: " + dataType;
            }

            if (isTable) ret[key] <- val;
            else ret[i] = val;
        }

        return ret;
    }

    // Deserializes into an existing object (array or table)
    // _object: the object to deserialize into (must be an array or table)
    // _in: the input stream to read from
    // Returns the modified object
    function deserializeInto(_object, _in) {
        requireOneFromTypes(["table", "array"], _object);

        local deserializedObj = this.deserialize(_in);

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

// Helper function to ensure the input is one of the specified types
function requireOneFromTypes(types, ...args) {
    foreach (arg in args) {
        if (types.find(typeof arg) == null) {
            throw "Invalid type: " + typeof arg;
        }
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


function testSerialization() {
    local utils = Utils();

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

    // Serialize
    local outStream = MockOutputStream();
    utils.serialize(originalTable, outStream);
    local serializedData = outStream.getBuffer();
    print("Serialized Data: " + serializedData);

    // Deserialize
    local inStream = MockInputStream(serializedData);
    local deserializedTable = utils.deserialize(inStream);

    // Compare original and deserialized tables
    local isEqual = compareTables(originalTable, deserializedTable);
    print("Serialization Test Passed: " + isEqual);
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







