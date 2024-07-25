//
// Functional utilities handle data manipulation and checking
// This is includes sorting, randomisation and merges for arrays, tables, and strings 
// The checkers compare objects, check types and transpose types
//


//
// Array Manipulation
//

// Basic random
function arrayRand(arr) {
    if (arr.len() == 0) return null;
    return arr[math.rand(0, arr.len() - 1)];
}

// Basic removal
function arrayRemove(arr, item) {
    local idx = arr.find(item);
    if (idx != null) {
        return arr.remove(idx);
    }
    return null;
}

// Basic shuffle
function arrayShuffle(arr) {
    for (local i = arr.len() - 1; i > 0; i--) {
        local j = math.rand(0, i);
        local temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
}

// Sorts the array descending
function arraySortDescending(arr) {
    arr.sort(@(a, b) -1 * (a <=> b));
}

// Sorts the array ascending
function arraySortAscending(arr) {
    arr.sort();
}

//
// Table Manipulation
//

// Returns a random value from the table
// tbl: the table to get a random value from
// Returns a random value from the table
function tableRandValue(tbl) {
    local values = tableValues(tbl);
    if (values.len() == 0) return null;
    return values[math.rand(0, values.len() - 1)];
}

// Returns a random key from the table
// tbl: the table to get a random key from
// Returns a random key from the table
function tableRandKey(tbl) {
    local keys = tableKeys(tbl);
    if (keys.len() == 0) return null;
    return keys[math.rand(0, keys.len() - 1)];
}

// Returns an array of all keys in the table
// tbl: the table to get the keys from
// Returns an array of keys
function tableKeys(tbl) {
    local ret = [];
    foreach (key, value in tbl) {
        ret.append(key);
    }
    return ret;
}

// Returns an array of all values in the table
// tbl: the table to get the values from
// Returns an array of values
function tableValues(tbl) {
    local ret = [];
    foreach (key, value in tbl) {
        ret.append(value);
    }
    return ret;
}

// Merges two tables into one
// tbl1: the first table
// tbl2: the second table
// overwrite: boolean indicating whether to overwrite existing keys (default: true)
// Returns the merged table
function tableMerge(tbl1, tbl2, overwrite = true) {
    foreach (key, value in tbl2) {
        if (key in tbl1 && !overwrite) {
            throw "Duplicate key found: " + key;
        }
        tbl1[key] = value;
    }
    return tbl1;
}

// Filters the table based on a function
// tbl: the table to filter
// func: the function to determine whether to keep an entry (function(key, value) returns boolean)
// Returns a new table with filtered entries
function tableFilter(tbl, func) {
    local ret = {};
    foreach (key, value in tbl) {
        if (func(key, value)) {
            ret[key] = value;
        }
    }
    return ret;
}

// Maps the table to a new table based on a function
// tbl: the table to map
// func: the function to transform an entry (function(key, value) returns [newKey, newValue])
// Returns a new table with transformed entries
function tableMap(tbl, func) {
    local ret = {};
    foreach (key, value in tbl) {
        local pair = func(key, value);
        ret[pair[0]] = pair[1];
    }
    return ret;
}

//
// String Manipulation
//

function stringCapitalizeFirst(str) {
    if (str == "") return str;
    return str.slice(0, 1).toupper() + str.slice(1);
}

function stringReplace(str, find, replace, all = false) {
    if (all) {
        return str.replace(find, replace);
    }
    local idx = str.find(find);
    if (idx != null) {
        return str.slice(0, idx) + replace + str.slice(idx + find.len());
    }
    return str;
}

function stringIsInteger(str) {
    foreach (char in str) {
        if (char < '0' || char > '9') return false;
    }
    return true;
}

function stringStartsWith(str, start) {
    return str.find(start) == 0;
}

function stringEndsWith(str, end) {
    return end.len() <= str.len() && str.slice(-end.len()) == end;
}

//
// Checkers
//

// Checks if the given object is of a specified class type
// _thing: the object to check
// _type: the name of the class to check against
// Returns true if the thing is of the specified type, false otherwise
function isKindOf(_thing, _type) {
    if (_thing == null || _type == null) return false;
    if (typeof _thing == "instance" && _thing instanceof ::WeakTableRef) {
        if (_thing.isNull()) return false;
        _thing = _thing.get();
    }

    return ::isKindOf(_thing, _type);
}

// Checks if the given object is null or undefined
// _object: the object to check
// Returns true if the object is null or undefined, false otherwise
function isNull(_object) {
    return _object == null;
}

// Checks if a tile can be used to resurrect a unit
// _tile: the tile to check
// _force: whether to force the resurrection even if the tile's corpse is not normally resurrectable (default: false)
// Returns true if the tile can be used to resurrect, false otherwise
function canResurrectOnTile(_tile, _force = false) {
    if (!_tile.IsCorpseSpawned) {
        return false;
    }
    if (!_tile.Properties.get("Corpse").IsResurrectable && !_force) {
        return false;
    }
    return true;
}

// Checks if two objects are equal
// _object1: the first object to compare
// _object2: the second object to compare
// Returns true if the objects are equal, false otherwise
function isEqual(_object1, _object2) {
    return _object1 == _object2;
}

// Checks if an element is in an array
// _element: the element to check
// _array: the array to check in
// Returns true if the element is in the array, false otherwise
function isIn(_element, _array) {
    return _array.find(_element) != null;
}

// Checks if a string matches a regular expression
// _string: the string to check
// _pattern: the regular expression pattern
// Returns true if the string matches the pattern, false otherwise
function regexMatch(_string, _pattern) {
    local regex = regexp(_pattern);
    return regex.search(_string) != null;
}

// Checks if the given object is a Battle Brothers game object
// _object: the object to check
// Returns true if the object is a Battle Brothers game object, false otherwise
function isBBObject(_object) {
    return typeof _object == "instance" && _object != null && _object.GetType().ToString().find("BB.") == 0;
}

// Gets the value of a member function or property from an object
// _object: the object to get the member value from
// _member: the name of the member
// Returns the value of the member function or property, or null if the member does not exist
function getMember(_object, _member) {
    if (_object == null || !_member in _object) return null;
    return _object[_member];
}

// Gets the value of a field from an object
// _object: the object to get the field value from
// _field: the name of the field
// Returns the value of the field, or null if the field does not exist
function getField(_object, _field) {
    if (_object == null || !_field in _object) return null;
    return _object[_field];
}

// Converts an object to a WeakTableRef if it is not already one
// _object: the object to convert
// Returns a WeakTableRef to the object
function asWeakTableRef(_object) {
    if (_object == null) return null;
    if (typeof _object == "instance" && _object instanceof ::WeakTableRef) {
        return _object;
    }
    return ::WeakTableRef(_object);
}

//
// Function testing
//

function runUtilitiesTests() {
    this.loginfo("Testing ArrayUtils...");

    // Test arrayRand
    local arr = [1, 2, 3, 4, 5];
    local randVal = arrayRand(arr);
    this.loginfo("arrayRand: " + randVal);

    // Test arrayRemove
    arrayRemove(arr, 3);
    this.loginfo("arrayRemove: " + arr);

    // Test arrayShuffle
    arrayShuffle(arr);
    this.loginfo("arrayShuffle: " + arr);

    // Test arraySortDescending
    arraySortDescending(arr);
    this.loginfo("arraySortDescending: " + arr);

    // Test arraySortAscending
    arraySortAscending(arr);
    this.loginfo("arraySortAscending: " + arr);

    this.loginfo("Testing TableUtils...");

    // Test tableKeys
    local tbl = { "a": 1, "b": 2, "c": 3 };
    local keys = tableKeys(tbl);
    this.loginfo("tableKeys: " + keys);

    // Test tableValues
    local values = tableValues(tbl);
    this.loginfo("tableValues: " + values);

    // Test tableMerge
    local tbl1 = { "a": 1, "b": 2 };
    local tbl2 = { "b": 3, "c": 4 };
    local mergedTbl = tableMerge(tbl1, tbl2);
    this.loginfo("tableMerge: " + mergedTbl);

    // Test tableFilter
    local filteredTbl = tableFilter(tbl, function(key, value) {
        return value > 1;
    });
    this.loginfo("tableFilter: " + filteredTbl);

    // Test tableMap
    local mappedTbl = tableMap(tbl, function(key, value) {
        return [key, value * 2];
    });
    this.loginfo("tableMap: " + mappedTbl);

    this.loginfo("Testing StringUtils...");

    // Test stringCapitalizeFirst
    local str = "hello";
    local capitalized = stringCapitalizeFirst(str);
    this.loginfo("stringCapitalizeFirst: " + capitalized);

    // Test stringReplace
    local replaced = stringReplace("hello world", "world", "Squirrel", true);
    this.loginfo("stringReplace: " + replaced);

    // Test stringIsInteger
    local isInt = stringIsInteger("123");
    this.loginfo("stringIsInteger (123): " + isInt);
    isInt = stringIsInteger("abc");
    this.loginfo("stringIsInteger (abc): " + isInt);

    // Test stringStartsWith
    local starts = stringStartsWith("hello", "he");
    this.loginfo("stringStartsWith (he): " + starts);
    starts = stringStartsWith("hello", "lo");
    this.loginfo("stringStartsWith (lo): " + starts);

    // Test stringEndsWith
    local ends = stringEndsWith("hello", "lo");
    this.loginfo("stringEndsWith (lo): " + ends);
    ends = stringEndsWith("hello", "he");
    this.loginfo("stringEndsWith (he): " + ends);

    this.loginfo("Testing WeightedContainer...");

    // Create a container
    local container = createWeightedContainer();

    // Add elements
    weightedContainerAdd(container, 10, "Element1");
    weightedContainerAdd(container, 20, "Element2");
    weightedContainerAdd(container, 30, "Element3");

    // Test getting a random element
    local element = weightedContainerGet(container);
    this.loginfo("Weighted Container Element: " + element);

    // Test removing an element
    weightedContainerRemove(container, "Element2");
    element = weightedContainerGet(container);
    this.loginfo("After removal, Weighted Container Element: " + element);

    // Test clearing the container
    weightedContainerClear(container);
    this.loginfo("After clearing, Container Total Weight: " + container.totalWeight);
}

function runIsKindOfTests() {
    class ExampleClass {
        function constructor() {
            this.name = "Example";
        }
    }

    local exampleInstance = ExampleClass();
    
    // Check if the instance is of type ExampleClass
    local result = isKindOf(exampleInstance, "ExampleClass");
    this.loginfo("Is exampleInstance of type ExampleClass? " + result); // Should be true
    
    // Check with a different class name
    result = isKindOf(exampleInstance, "NonExistentClass");
    this.loginfo("Is exampleInstance of type NonExistentClass? " + result); // Should be false
    
    // Check with null values
    result = isKindOf(null, "ExampleClass");
    this.loginfo("Is null of type ExampleClass? " + result); // Should be false
    
    result = isKindOf(exampleInstance, null);
    this.loginfo("Is exampleInstance of type null? " + result); // Should be false
}

function runCheckerTests() {
    // Test isNull
    this.loginfo("isNull(null): " + isNull(null)); // Should be true
    this.loginfo("isNull(1): " + isNull(1)); // Should be false

    // Test asWeakTableRef
    local obj = { "key": "value" };
    local weakRef = asWeakTableRef(obj);
    this.loginfo("asWeakTableRef(obj): " + weakRef); // Should be a WeakTableRef to obj

    // Test isEqual
    this.loginfo("isEqual(1, 1): " + isEqual(1, 1)); // Should be true
    this.loginfo("isEqual(1, 2): " + isEqual(1, 2)); // Should be false

    // Test isBBObject (mocked for this test)
    local bbObject = { GetType = function() { return "BB.SomeObject"; } };
    this.loginfo("isBBObject(bbObject): " + isBBObject(bbObject)); // Should be true

    // Test isIn
    local array = [1, 2, 3];
    this.loginfo("isIn(2, array): " + isIn(2, array)); // Should be true
    this.loginfo("isIn(4, array): " + isIn(4, array)); // Should be false

    // Test regexMatch
    this.loginfo("regexMatch('hello', 'h.*o'): " + regexMatch("hello", "h.*o")); // Should be true
    this.loginfo("regexMatch('world', 'h.*o'): " + regexMatch("world", "h.*o")); // Should be false

    // Test getField
    local objWithField = { "field": 42 };
    this.loginfo("getField(objWithField, 'field'): " + getField(objWithField, "field")); // Should be 42
    this.loginfo("getField(objWithField, 'nonexistent'): " + getField(objWithField, "nonexistent")); // Should be null

    // Test getMember
    local objWithMember = { "member": 84 };
    this.loginfo("getMember(objWithMember, 'member'): " + getMember(objWithMember, "member")); // Should be 84
    this.loginfo("getMember(objWithMember, 'nonexistent'): " + getMember(objWithMember, "nonexistent")); // Should be null
}

function runCanResurrectOnTileTests() {
    // Create a mock tile object
    local mockTile = {
        IsCorpseSpawned = true,
        Properties = {
            get = function(key) {
                return {
                    IsResurrectable = (key == "Corpse")
                };
            }
        }
    };
    
    // Test case 1: Tile with a resurrectable corpse
    local result = canResurrectOnTile(mockTile);
    this.loginfo("Can resurrect on tile with a resurrectable corpse? " + result); // Should be true
    
    // Test case 2: Tile with a non-resurrectable corpse, force = false
    mockTile.Properties.get = function(key) {
        return {
            IsResurrectable = (key == "Corpse") ? false : false
        };
    };
    result = canResurrectOnTile(mockTile);
    this.loginfo("Can resurrect on tile with a non-resurrectable corpse (force=false)? " + result); // Should be false
    
    // Test case 3: Tile with a non-resurrectable corpse, force = true
    result = canResurrectOnTile(mockTile, true);
    this.loginfo("Can resurrect on tile with a non-resurrectable corpse (force=true)? " + result); // Should be true
    
    // Test case 4: Tile without a corpse
    mockTile.IsCorpseSpawned = false;
    result = canResurrectOnTile(mockTile);
    this.loginfo("Can resurrect on tile without a corpse? " + result); // Should be false
}



