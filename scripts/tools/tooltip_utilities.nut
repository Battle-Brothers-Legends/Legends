/**
 * Tooltip Class
 * 
 * This class manages tooltip creation and data.
 * It supports basic tooltips with a title and text, as well as custom tooltips
 * defined by a function.
 */
::FU.Class.Tooltip <- class {
    Data = null;
    Title = null;
    Text = null;
    Function = null;

    /**
     * Constructor for Tooltip.
     * @param {variant} _titleOrFunction - Either a title string or a custom function.
     * @param {string} _text - The text of the tooltip (if applicable).
     * @param {table} _data - Optional data for the tooltip.
     */
    constructor(_titleOrFunction = null, _text = null, _data = null) {
        this.setData(_data);
        if (typeof _titleOrFunction == "function") {
            this.setFunction(_titleOrFunction);
        } else {
            this.setTitle(_titleOrFunction);
            this.setText(_text);
        }
    }

    /**
     * Sets the data for the tooltip.
     * @param {table} _data - The data to set.
     */
    function setData(_data) {
        if (_data == null) _data = {};
        ::FU.requireTable(_data);
        this.Data = _data;
    }

    /**
     * Sets the title for the tooltip.
     * @param {string|function} _title - The title to set.
     */
    function setTitle(_title) {
        ::FU.requireOneFromTypes(["string", "function"], _title);
        this.Title = typeof _title == "string" ? @() _title : _title;
    }

    /**
     * Sets the text for the tooltip.
     * @param {string|function} _text - The text to set.
     */
    function setText(_text) {
        ::FU.requireOneFromTypes(["string", "function"], _text);
        this.Text = typeof _text == "string" ? @() _text : _text;
    }

    /**
     * Sets the custom function for the tooltip.
     * @param {function} _function - The custom function to set.
     */
    function setFunction(_function) {
        ::FU.requireFunction(_function);
        this.Function = _function;
    }

    /**
     * Retrieves the title of the tooltip.
     * @param {table} _data - Optional data for the tooltip.
     * @returns {string} - The title of the tooltip.
     */
    function getTitle(_data) {
        return this.Title.getinfos().parameters.len() == 1 ? this.Title() : this.Title(_data);
    }

    /**
     * Retrieves the text of the tooltip.
     * @param {table} _data - Optional data for the tooltip.
     * @returns {string} - The text of the tooltip.
     */
    function getText(_data) {
        return this.Text.getinfos().parameters.len() == 1 ? this.Text() : this.Text(_data);
    }

    /**
     * Retrieves the UI data for the tooltip.
     * @param {table} _data - Optional data for the tooltip.
     * @returns {array} - The UI data for the tooltip.
     */
    function getUIData(_data) {
        if (this.Function != null) {
            return this.Function(_data);
        } else {
            return [
                {
                    id = 1,
                    type = "title",
                    text = this.getTitle(_data)
                },
                {
                    id = 2,
                    type = "description",
                    text = this.getText(_data)
                },
            ];
        }
    }
}

/**
 * TooltipManager Class
 * 
 * This class manages tooltips for mods.
 * It is responsible for registering mods and setting/getting tooltips.
 */
::FU.Class.TooltipManager <- class {
    Mods = {};

    /**
     * Constructor for TooltipManager.
     * Initializes the Mods container.
     */
    constructor() {
        this.Mods = {};
    }

    /**
     * Registers a mod with the TooltipManager.
     * Initializes the mod's tooltips.
     * @param {Mod} _mod - The mod object to register.
     */
    function registerMod(_mod) {
	this.logInfo("TooltipManager registering mod: " + _mod.getID());
        if (typeof _mod != "instance" || !(_mod instanceof ::FU.Class.Mod)) {
            throw Exception.InvalidType(_mod);
        }

        _mod.TooltipManager = ::FU.Class.ModTooltips(_mod);  // Initialize ModTooltips for the mod
        this.Mods[_mod.getID()] <- {};
    }

    /**
     * Sets tooltips for a mod.
     * @param {string} _modID - The unique identifier for the mod.
     * @param {table} _tooltipTable - The table of tooltips to set.
     */
    function setTooltips(_modID, _tooltipTable) {
        this.addTable(this.Mods[_modID], _tooltipTable);
    }

    /**
     * Adds tooltips from one table to another.
     * @param {table} _currentTable - The current table of tooltips.
     * @param {table} _tableToAdd - The table of tooltips to add.
     */
    function addTable(_currentTable, _tableToAdd) {
        foreach (key, value in _tableToAdd) {
            if (!(key in _currentTable) && typeof value == "table") {
                _currentTable[key] = {};
                this.__addTable(_currentTable[key], value);
            } else {
                _currentTable[key] = value;
            }
        }
    }

    /**
     * Retrieves a tooltip for a mod.
     * @param {string} _modID - The unique identifier for the mod.
     * @param {string} _identifier - The identifier for the tooltip.
     * @returns {variant} - The tooltip.
     */
    function getTooltip(_modID, _identifier) {
        local fullKey = split(_identifier, ".");
        local currentTable = this.Mods[_modID];
        for (local i = 0; i < fullKey.len(); ++i) {
            currentTable = currentTable[fullKey[i]];
        }
        return currentTable;
    }
}

/**
 * Class representing mod-specific tooltips management.
 * This class handles tooltips for a specific mod.
 */
::FU.Class.Tooltips <- class {
    Mod = null;

    /**
     * Constructor for ModTooltips.
     * @param {Mod} _mod - The mod object.
     */
    constructor(_mod) {
        this.Mod = _mod;
    }

    /**
     * Sets tooltips for the mod.
     * @param {table} _tooltipTable - The table of tooltips to set.
     */
    function setTooltips(_tooltipTable) {
        TooltipManager.setTooltips(this.Mod.getID(), _tooltipTable);
    }

    /**
     * Retrieves a tooltip for the mod.
     * @param {string} _identifier - The identifier for the tooltip.
     * @returns {variant} - The tooltip.
     */
    function getTooltip(_identifier) {
        return TooltipManager.getTooltip(this.Mod.getID(), _identifier);
    }
}

// Aliases for backwards compatibility
::FU.Class.BasicTooltip <- ::FU.Class.Tooltip;
::FU.Class.CustomTooltip <- ::FU.Class.Tooltip;
::FU.Class.TooltipsModAddon <- ::FU.Class.Tooltips;

// Test function for TooltipManager
function testTooltipManager() {
    local manager = TooltipManager();
    local mod = Mod("testMod");
    manager.registerMod(mod);
    
    local basicTooltip = Tooltip("Test Title", "Test Text");
    local customTooltip = Tooltip(function() { return [{ id = 1, type = "custom", text = "Custom Tooltip" }]; });
    
    manager.setTooltips(mod.getID(), { basic = basicTooltip, custom = customTooltip });
    
    assert(manager.getTooltip(mod.getID(), "basic").getTitle() == "Test Title");
    assert(manager.getTooltip(mod.getID(), "custom").getUIData() == [{ id = 1, type = "custom", text = "Custom Tooltip" }]);
    
    print("TooltipManager tests passed.");
}

// Run the test
// testTooltipManager();

