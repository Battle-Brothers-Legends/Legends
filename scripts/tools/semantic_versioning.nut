//
// Semantic version comparison scripts
//


class SemVer {

//Initialize the SemVer class with the regular expression for semantic versioning.
    constructor() {
        this.Regex = regexp("^((?:(?:0|[1-9]\\d*)\\.){2}(?:0|[1-9]\\d*))(?:-((?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\\.(?:0|[1-9]\\d*|\\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\\+([0-9a-zA-Z-]+(?:\\.[0-9a-zA-Z-]+)*))?$");
    }

    // Checks if a string is a valid semantic version
    // _string: the string to check
    // Returns true if the string is a valid semantic version, false otherwise
    function isSemVer(_string) {
        if (typeof _string != "string") return false;
        return this.Regex.capture(_string) != null;
    }

    // Converts a semantic version string to a table representation
    // _version: the semantic version string
    // Returns a table with Version, PreRelease, and Metadata fields
    function getTable(_version) {
        local version = this.Regex.capture(_version);
        if (version == null) {
            logError("NotSemanticVersion: " + _version);
            throw "InvalidValue: " + _version;
        }
        return {
            Version: split(version[1], ".").map(@(v) v.tointeger()),
            PreRelease: version[2] == null ? null : split(version[2], "."),
            Metadata: version[3] == null ? null : split(version[3], ".")
        };
    }

    // Formats a vanilla version string to a semantic version string
    // _vanillaVersion: the vanilla version string
    // Returns the formatted semantic version string
    function formatVanillaVersion(_vanillaVersion) {
        local versionArray = split(_vanillaVersion, ".");
        local preRelease = versionArray.pop();
        return versionArray.reduce(@(a, b) a + "." + b) + "-" + preRelease;
    }

    // Compares two semantic version tables
    // _version1: the first version table
    // _version2: the second version table
    // Returns 1 if _version1 is greater, -1 if _version2 is greater, 0 if they are equal
    function compare(_version1, _version2) {
        for (local i = 0; i < 3; ++i) {
            if (_version1.Version[i] > _version2.Version[i]) return 1;
            if (_version1.Version[i] < _version2.Version[i]) return -1;
        }

        if (_version1.PreRelease == null || _version2.PreRelease == null) {
            if (_version1.PreRelease == null && _version2.PreRelease != null) return 1;
            if (_version1.PreRelease != null && _version2.PreRelease == null) return -1;
            return 0;
        }

        for (local i = 0; i < math.min(_version1.PreRelease.len(), _version2.PreRelease.len()); ++i) {
            local isInt1 = isInteger(_version1.PreRelease[i]);
            local isInt2 = isInteger(_version2.PreRelease[i]);

            if (isInt1 || isInt2) {
                if (isInt1 && isInt2) {
                    local int1 = _version1.PreRelease[i].tointeger();
                    local int2 = _version2.PreRelease[i].tointeger();
                    if (int1 < int2) return -1;
                    if (int1 > int2) return 1;
                } else {
                    if (isInt1) return -1;
                    return 1;
                }
            } else {
                if (_version1.PreRelease[i] > _version2.PreRelease[i]) return 1;
                if (_version1.PreRelease[i] < _version2.PreRelease[i]) return -1;
            }
        }

        if (_version1.PreRelease.len() > _version2.PreRelease.len()) return 1;
        if (_version1.PreRelease.len() < _version2.PreRelease.len()) return -1;
        return 0;
    }

    // Gets the short version string (major.minor.patch)
    // _version: the version table
    // Returns the short version string
    function getShortVersionString(_version) {
        return _version.Version.reduce(@(a, b) a + "." + b);
    }

    // Gets the full version string (including pre-release and metadata)
    // _version: the version table
    // Returns the full version string
    function getVersionString(_version) {
        local ret = this.getShortVersionString(_version);

        if (_version.PreRelease != null) {
            ret += "-" + _version.PreRelease.reduce(@(a, b) a + "." + b);
        }

        if (_version.Metadata != null) {
            ret += "+" + _version.Metadata.reduce(@(a, b) a + "." + b);
        }

        return ret;
    }

    // Compares two semantic version strings using an operator
    // _version1: the first version (string or table)
    // _operator: the comparison operator (e.g., "==", "!=", "<", ">", "<=", ">=")
    // _version2: the second version (string or table)
    // Returns true if the comparison is valid, false otherwise
    function compareVersionWithOperator(_version1, _operator, _version2) {
        verifyCompareInputs(_version1, _version2);
        if (typeof _version1 == "string") _version1 = this.getTable(_version1);
        if (typeof _version2 == "string") _version2 = this.getTable(_version2);
        return operatorCompare(this.compare(_version1, _version2), _operator);
    }

    // Compares the major versions of two semantic version strings using an operator
    // _version1: the first version (string or table)
    // _operator: the comparison operator (e.g., "==", "!=", "<", ">", "<=", ">=")
    // _version2: the second version (string or table)
    // Returns true if the comparison is valid, false otherwise
    function compareMajorVersionWithOperator(_version1, _operator, _version2) {
        verifyCompareInputs(_version1, _version2);
        if (typeof _version1 == "string") _version1 = this.getTable(_version1);
        if (typeof _version2 == "string") _version2 = this.getTable(_version2);
        return operatorCompare(_version1.Version[0] <=> _version2.Version[0], _operator);
    }

    // Compares the minor versions of two semantic version strings using an operator
    // _version1: the first version (string or table)
    // _operator: the comparison operator (e.g., "==", "!=", "<", ">", "<=", ">=")
    // _version2: the second version (string or table)
    // Returns true if the comparison is valid, false otherwise
    function compareMinorVersionWithOperator(_version1, _operator, _version2) {
        verifyCompareInputs(_version1, _version2);
        if (typeof _version1 == "string") _version1 = this.getTable(_version1);
        if (typeof _version2 == "string") _version2 = this.getTable(_version2);

        local majorCompare = _version1.Version[0] <=> _version2.Version[0];
        if (majorCompare != 0) return operatorCompare(majorCompare, _operator);

        return operatorCompare(_version1.Version[1] <=> _version2.Version[1], _operator);
    }
}

//
//Helper functions - moved outside the class
//
// Verifies the inputs for version comparison
// _version1: the first version to compare (string, table, or instance of Mod)
// _version2: the second version to compare (string, table, or instance of Mod)
function verifyCompareInputs(_version1, _version2) {
    requireOneFromTypes(["string", "table", "instance"], _version1, _version2);
    if (typeof _version1 == "instance") requireInstanceOf(Mod, _version1);
    if (typeof _version2 == "instance") requireInstanceOf(Mod, _version2);
}

// Checks if the input is one of the specified types
function requireOneFromTypes(types, ...args) {
    foreach (arg in args) {
        if (types.find(typeof arg) == null) {
            throw "Invalid type: " + typeof arg;
        }
    }
}

// Checks if the object is an instance of the specified class
function requireInstanceOf(classType, obj) {
    if (!(obj instanceof classType)) {
        throw "Object is not an instance of " + classType;
    }
}
// Logs an error message
function logError(message) {
    print("Error: " + message);
}

// Checks if a string represents an integer
// _string: the string to check
// Returns true if the string represents an integer, false otherwise
function isInteger(_string) {
    foreach (char in _string) {
        if (char < '0' || char > '9') return false;
    }
    return true;
}

// Compares two values using a specified operator
// _value1: the first value
// _value2: the second value
// _operator: the comparison operator (e.g., "==", "!=", "<", ">", "<=", ">=")
// Returns true if the comparison is valid, false otherwise
function operatorCompare(_value1, _operator, _value2) {
    switch (_operator) {
        case "==":
            return _value1 == _value2;
        case "!=":
            return _value1 != _value2;
        case "<":
            return _value1 < _value2;
        case ">":
            return _value1 > _value2;
        case "<=":
            return _value1 <= _value2;
        case ">=":
            return _value1 >= _value2;
        default:
            throw "Invalid operator: " + _operator;
    }
}

