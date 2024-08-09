
/**
 * This class is used to control the sorting of the layout elements like pages, panels and components
 * Its genericly titles and OrderedMap to potentially be reused somewhere else
 * This class maintains the order of keys as they are inserted.
 */
 
::FU.Class.OrderedMap <- class
{
    // Array to store the order of keys
    Array = null;
    
    // Table to store the key-value pairs
    Table = null;
    
    // Cache for the next index
    NextICache = null;

    /**
     * Constructor for OrderedMap.
     * @param _table {table} - Optional initial table to populate the OrderedMap.
     */
    constructor(_table = null)
    {
    	this.logInfo("Creating new OrderedMap instance");
        this.Array = [];
        this.Table = {};
        if (_table != null) this.addTable(_table);
    }

    /**
     * Adds or updates a key-value pair in the OrderedMap.
     * @param _key {variant} - The key.
     * @param _value {variant} - The value.
     */
    function _newslot(_key, _value)
    {
        if (!(_key in this.Table))
        {
            this.Array.push(_key);
        }
        this.Table[_key] <- _value;
    }

    /**
     * Deletes a key-value pair from the OrderedMap.
     * @param _key {variant} - The key.
     * @returns {boolean} - True if the key was found and deleted, otherwise false.
     */
    function _delslot(_key)
    {
        this.Array.remove(this.Array.find(_key));
        return delete this.Table[_key];
    }

    /**
     * Sets a value for an existing key in the OrderedMap.
     * @param _key {variant} - The key.
     * @param _value {variant} - The value.
     */
    function _set(_key, _value)
    {
        this.Table[_key] = _value;
    }

    /**
     * Gets the value associated with a key.
     * @param _key {variant} - The key.
     * @returns {variant} - The value associated with the key.
     * @throws {null} - If the key does not exist.
     */
    function _get(_key)
    {
        if (_key in this.Table) return this.Table[_key];
        throw null;
    }

    /**
     * Gets the next key in the order.
     * @param _prev {variant} - The previous key.
     * @returns {variant} - The next key.
     */
    function _nexti(_prev)
    {
        if (_prev == null) this.NextICache = 0;
        _prev = this.NextICache++;
        return _prev == this.Array.len() ? null : this.Array[_prev];
    }

    /**
     * Clones the OrderedMap from another instance.
     * @param _original {OrderedMap} - The original OrderedMap to clone from.
     */
    function _cloned(_original)
    {
        this.Array = clone _original.Array;
        this.Table = clone _original.Table;
    }

    /**
     * Converts the OrderedMap to a table.
     * @returns {table} - A table representation of the OrderedMap.
     */
    function toTable()
    {
        return clone this.Table;
    }

    /**
     * Adds key-value pairs from a table to the OrderedMap.
     * @param _table {table} - The table to add.
     * @param _overwrite {boolean} - Whether to overwrite existing keys. Default is true.
     * @throws {DuplicateKey} - If a key already exists and _overwrite is false.
     */
    function addTable(_table, _overwrite = true)
    {
        ::FU.requireTable(_table);
        
        foreach (key, value in _table)
        {
            if (!_overwrite && this.contains(key)) throw ::FU.Exception.DuplicateKey(key);
            this[key] <- value;
        }
    }

    /**
     * Sorts the keys in the OrderedMap based on a comparison function.
     * @param _function {function} - The comparison function.
     */
    function sort(_function)
    {
        for (local i = 1; i < this.Array.len(); ++i)
        {
            local key = this.Array[i];
            local j = i - 1;
            while (j >= 0 && _function(key, this.Table[key], this.Array[j], this.Table[this.Array[j]]) < 0)
            {
                this.Array[j+1] = this.Array[j];
                --j;
            }

            this.Array[j+1] = key;
        }
    }

    /**
     * Reverses the order of keys in the OrderedMap.
     */
    function reverse()
    {
        this.Array.reverse();
    }

    /**
     * Clears all key-value pairs from the OrderedMap.
     */
    function clear()
    {
        this.Array.clear();
        this.Table.clear();
    }

    /**
     * Shuffles the order of keys in the OrderedMap.
     */
    function shuffle()
    {
        ::FU.Array.shuffle(this.Array);
    }

    /**
     * Gets the number of key-value pairs in the OrderedMap.
     * @returns {integer} - The number of key-value pairs.
     */
    function len()
    {
        return this.Array.len();
    }

    /**
     * Checks if a key exists in the OrderedMap.
     * @param _key {variant} - The key.
     * @returns {boolean} - True if the key exists, otherwise false.
     */
    function contains(_key)
    {
        return _key in this.Table;
    }

    /**
     * Applies a function to each key-value pair in the OrderedMap.
     * @param _function {function} - The function to apply.
     */
    function apply(_function)
    {
        // _function (_key, _val, _idx)
        // must return new value for _key

        foreach (i, key in this.Array)
        {
            this.Table[key] = _function(key, this.Table[key], i);
        }
    }

    /**
     * Filters the key-value pairs in the OrderedMap based on a function.
     * @param _function {function} - The function to filter by.
     * @returns {OrderedMap} - A new OrderedMap with the filtered key-value pairs.
     */
    function filter(_function)
    {
        // _function (_key, _val, _idx)
        // must return a boolean

        local ret = ::FU.Class.OrderedMap();
        foreach (i, key in this.Array)
        {
            local val = this.Table[key];
            if (_function(key, val, i)) ret[key] <- val;
        }
        return ret;
    }

    /**
     * Maps the key-value pairs in the OrderedMap to a new OrderedMap using a function.
     * @param _function {function} - The function to map by.
     * @returns {OrderedMap} - A new OrderedMap with the mapped key-value pairs.
     */
    function map(_function)
    {
        // _function (_key, _val, _idx)
        // must return a length 2 array with index 0 being new key and index 1 being new value

        local ret = ::FU.Class.OrderedMap();
        foreach (i, key in this.Array)
        {
            local pair = _function(key, this.Table[key], i);
            ret[pair[0]] <- pair[1];
        }
        return ret;
    }

    /**
     * Gets an array of all values in the OrderedMap.
     * @returns {array} - An array of values.
     */
    function values()
    {
        local ret = array(this.Array.len());
        foreach (i, key in this.Array)
        {
            ret[i] = this.Table[key];
        }
        return ret;
    }

    /**
     * Gets an array of all keys in the OrderedMap.
     * @returns {array} - An array of keys.
     */
    function keys()
    {
        return clone this.Array;
    }

    /**
     * Serializes the OrderedMap to an output stream.
     * @param _out {variant} - The output stream.
     */
    function onSerialize(_out)
    {
        ::FU.Utils.serialize(this.Array, _out);
        ::FU.Utils.serialize(this.Table, _out);
    }

    /**
     * Deserializes the OrderedMap from an input stream.
     * @param _in {variant} - The input stream.
     */
    function onDeserialize(_in)
    {
        this.Array = ::FU.Utils.deserialize(_in);
        this.Table = ::FU.Utils.deserialize(_in);
    }
}
