/**
 * Class representing a generic TemplateSetting.
 */
class ::FU.Class.TemplateSetting {
    ID = null;
    Name = null;
    Value = null;
    Data = null;
    Page = null;
    static Type = "Setting";
    Description = null;
    Persistence = true;
    Callbacks = {
        BeforeChange = [],
        AfterChange = []
    };

    // Class property for Type
    Type = "Template";

    /**
     * Constructor for TemplateSetting.
     * @param _id {string} - The unique identifier for the setting.
     * @param _value {variant} - The value of the setting.
     * @param _name {string} - The name of the setting.
     * @param _description {string} - The description of the setting.
     */
    function constructor(_id, _value, _name = null, _description = null) {
        this.ID = _id;
        this.Value = _value;
        this.Name = _name ? _name : _id;
        this.Data = {};
        this.Description = _description ? _description : "";
    }

    /**
     * Adds a callback function for a specific event type.
     * @param _type {string} - The type of the callback ("BeforeChange" or "AfterChange").
     * @param _callback {function} - The callback function to add.
     */
    function addCallback(_type, _callback) {
        this.Callbacks[_type].push(_callback);
    }

    /**
     * Sets a new value for the setting.
     * @param _newValue {variant} - The new value to set.
     */
    function set(_newValue) {
        foreach (callback in this.Callbacks.BeforeChange) {
            callback.call(this, _newValue);
        }

        local oldValue = this.Value;
        this.Value = _newValue;

        foreach (callback in this.Callbacks.AfterChange) {
            callback.call(this, oldValue);
        }
    }

    /**
     * Gets the current value of the setting.
     * @returns {variant} - The current value.
     */
    function get() {
        return this.Value;
    }

    /**
     * Serializes the setting if persistence is enabled.
     */
    function serialize() {
        if (this.Persistence) {
            // Serialization logic
        }
    }

    /**
     * Deserializes the setting from provided data.
     * @param _data {variant} - The data to deserialize from.
     */
    function deserialize(_data) {
        if (this.Persistence) {
            // Deserialization logic
        }
    }

    /**
     * Gets the ID of the setting.
     * @returns {string} - The ID of the setting.
     */
    function getID() {
        return this.ID;
    }

    /**
     * Gets the Type of the setting.
     * @returns {string} - The Typeof the setting.
     */
    function getType() {
        return this.Type;
    }


    /**
     * Gets the name of the setting.
     * @returns {string} - The name of the setting.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the value of the setting.
     * @returns {variant} - The value of the setting.
     */
    function getValue() {
        return this.Value;
    }

    /**
     * Sets the value of the setting.
     * @param _value {variant} - The value to set.
     */
    function setValue(_value) {
        this.set(_value);
    }

    /**
     * Gets the description of the setting.
     * @returns {string} - The description of the setting.
     */
    function getDescription() {
        return this.Description;
    }

    /**
     * Sets the description of the setting.
     * @param _description {string} - The description to set.
     */
    function setDescription(_description) {
        this.Description = _description;
    }

    /**
     * Gets the page the setting is on.
     */
    function getPage() {
        return this.Page;
    }
    
     /**
     * Sets the page the setting is on.
     */
    function setPage(_page) {
        this.Page = _page;
    }   
    /**
     * Gets the screen the setting is on.
     */
    function getScreenID() {
        return this.getPage().getScreenID();
    }  
    
   /**
     * Gets the mod this setting is for
     */
    function getMod() {
        return this.getPage().getMod();
    }  
    /**
     * Gets the data of the component.
     * @returns {table} - The data of the component.
     */
    function getData() {
        return this.Data;
    } 
    
    /**
     * Gets the tooltip for the component.
     * @param _data {variant} - The data for the tooltip.
     * @returns {array} - The tooltip data.
     */     
    function getTooltip( _data )
    {
    	return [
		{
			id = 1,
			type = "title",
			text = this.getName()
		},
		{
			id = 2,
			type = "description",
			text = this.getDescription()
		}
	];
    } 


     /**
     * Provides all the data required to populate the UI
     * @param _flags {table} - The flags to consider.
     * @returns {table} - The UI data.
     */ 
    function getUIData( _flags = [] )
    {
	local ret = {
		type = this.getType(),
		id = this.getID(),
		name = this.getName(),
		data = this.Data,
		panel = this.getPanelID(),
		mod = this.getMod().getID(),
		hidden = !this.verifyFlags(_flags)
	}
	return ret;
    }


     /**
     * Verifies the flags for the setting
     * @param _flags {table} - The flags to verify.
     * @returns {boolean} - Whether the flags are verified.
     */
    function verifyFlags( _flags )
    {
	if (_flags != null)
	{
		if ("required" in _flags)
		{
			foreach (required in _flags.required)
			{
				if (!(required in this.Data))
				{
					return false;
				}
			}
		}
		if ("excluded" in _flags)
		{
			foreach (excluded in _flags.excluded)
			{
				if (excluded in this.Data)
				{
					return false;
				}
			}
		}
	}
	return true;
    }    
    
    
}

function requireBool(value) {
    if (typeof value != "bool") {
        throw "Expected boolean, got " + typeof value;
    }
}


// Test Case
function testTemplateSetting() {
    local setting = createTemplateSetting("testID", 42, "Test Setting", "A setting used for testing.");
    assert(setting.getID() == "testID");
    assert(setting.getValue() == 42);
    assert(setting.getName() == "Test Setting");
    assert(setting.getDescription() == "A setting used for testing.");

    setting.setValue(100);
    assert(setting.getValue() == 100);
}

//testTemplateSetting();

