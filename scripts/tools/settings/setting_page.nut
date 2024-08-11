/**
 * Class representing a  settings page.
 * We add all our settings from here
 */

::FU.Class.SettingsPage <- class
{
	Name = null;
	ID = null;
	Components = null; 
	Screen = null;

	/**
	 * Constructor for SettingsPage.
	 * @param _id {string} - The unique identifier for the settings page.
	 * @param _name {string} - The name of the settings page.
	 */
	constructor(_id, _name = null)
	{
		this.ID = _id;	
		this.Name = _name == null ? _id : _name;
		this.Components = ::FU.Class.OrderedMap(); 
	}

	/**
	 * Adds a setting to the settings page.
	 * @param _component {PageComponent} - The component to add.
	 * @returns {PageComponent} - The added component.
	 */

	
	function addSetting(_setting)
	{
		if (!(_setting instanceof ::FU.Class.TemplateSetting))
		{
			this.logError("Setting is invalid, it should extend TemplateSetting");
		}
		_setting.setPage(this);
		this.Components[_setting.getID()] <- _setting;
		return _setting;
	}
	/**
	 * Adds a divider component to the settings page.
	 * @param _id {string} - The unique identifier for the divider.
	 * @returns {PageComponent} - The added divider component.
	 */
	function addDivider(_id)
	{
		return this.addSetting(::FU.Class.SettingsDivider(_id));
	}

	/**
	 * Adds a heading component to the settings page.
	 * @param _id {string} - The unique identifier for the heading.
	 * @param _name {string} - The name of the heading.
	 * @param _description {string} - The description of the heading.
	 * @returns {PageComponent} - The added heading component.
	 */
	function addHeading(_id, _name, _description = null)
	{
		return this.addSetting(::FU.Class.SettingHeading(_id, _name, _description));
	}

	/**
	 * Adds a spacer component to the settings page.
	 * @param _id {string} - The unique identifier for the spacer.
	 * @param _width {integer} - The width of the spacer.
	 * @param _height {integer} - The height of the spacer.
	 * @returns {PageComponent} - The added spacer component.
	 */
	function addSpacer(_id, _width, _height)
	{
		return this.addSetting(::FU.Class.SettingsSpacer(_id, _width, _height));
	}

	/**
	 * Adds a toggle setting component to the settings page.
	 * @param _id {string} - The unique identifier for the toggle setting.
	 * @param _value {boolean} - The value of the toggle setting.
	 * @param _name {string} - The name of the toggle setting.
	 * @param _description {string} - The description of the toggle setting.
	 * @returns {PageComponent} - The added toggle setting component.
	 */
	function addToggleSetting(_id, _value, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.ToggleSetting(_id, _value, _name, _description));
	}

	/**
	 * Adds a button setting component to the settings page.
	 * @param _id {string} - The unique identifier for the button setting.
	 * @param _name {string} - The name of the button setting.
	 * @param _description {string} - The description of the button setting.
	 * @returns {PageComponent} - The added button setting component.
	 */
	function addButtonSetting(_id, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.ButtonSetting(_id, _name, _description));
	}

	/**
	 * Adds a dropdown setting component to the settings page.
	 * @param _id {string} - The unique identifier for the dropdown setting.
	 * @param _value {variant} - The value of the dropdown setting.
	 * @param _array {array} - The array of possible values for the dropdown setting.
	 * @param _name {string} - The name of the dropdown setting.
	 * @param _description {string} - The description of the dropdown setting.
	 * @returns {PageComponent} - The added dropdown setting component.
	 */
	function addDropdownSetting(_id, _value, _array, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.DropdownSetting(_id, _value, _array, _name, _description));
	}

	/**
	 * Adds a slider setting component to the settings page.
	 * @param _id {string} - The unique identifier for the slider setting.
	 * @param _value {integer|float} - The value of the slider setting.
	 * @param _min {integer|float} - The minimum value for the slider.
	 * @param _max {integer|float} - The maximum value for the slider.
	 * @param _step {integer|float} - The step value for the slider.
	 * @param _name {string} - The name of the slider setting.
	 * @param _description {string} - The description of the slider setting.
	 * @returns {PageComponent} - The added slider setting component.
	 */
	function addSliderSetting(_id, _value, _min, _max, _step, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.SliderSetting(_id, _value, _min, _max, _step, _name, _description));
	}

	/**
	 * Adds a text input setting component to the settings page.
	 * @param _id {string} - The unique identifier for the text input setting.
	 * @param _value {string|integer|float} - The value of the text input setting.
	 * @param _name {string} - The name of the text input setting.
	 * @param _description {string} - The description of the text input setting.
	 * @returns {PageComponent} - The added text input setting component.
	 */
	function addTextInputSetting(_id, _value, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.TextInputSetting(_id, _value, _name, _description));
	}

	/**
	 * Adds a color picker setting component to the settings page.
	 * @param _id {string} - The unique identifier for the color picker setting.
	 * @param _value {string} - The value of the color picker setting in RGBA format.
	 * @param _name {string} - The name of the color picker setting.
	 * @param _description {string} - The description of the color picker setting.
	 * @returns {PageComponent} - The added color picker setting component.
	 */
	function addColorPickerSetting(_id, _value, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.ColorPickerSetting(_id, _value, _name, _description));
	}

	/**
	 * Adds a multiselect setting component to the settings page.
	 * @param _id {string} - The unique identifier for the multiselect setting.
	 * @param _value {array} - The value of the multiselect setting.
	 * @param _name {string} - The name of the multiselect setting.
	 * @param _description {string} - The description of the multiselect setting.
	 * @returns {PageComponent} - The added multiselect setting component.
	 */
	function addMultiselectSetting(_id, _value, _name = null, _description = null)
	{
		return this.addSetting(::FU.Class.MultiselectSetting(_id, _value, _name, _description));
	}

	/**
	 * Sets the screen for the settings page.
	 * @param _screen {Object} - The panel object.
	 */
	function setScreen(_screen)
	{
		this.Screen = _screen.weakref();
	}

	/**
	 * Gets the screen for the settings page.
	 * @returns {Object} - The panel object.
	 */
	function getScreen()
	{
		return this.Screen;
	}

	/**
	 * Gets the screen ID for the settings page.
	 * @returns {string} - The panel ID.
	 */
	function getScreenID()
	{
		return this.getScreen().getID();
	}

	/**
	 * Gets the mod for the settings page.
	 * @returns {Object} - The mod object.
	 */
	function getMod()
	{
		return this.getScreen().getMod();
	}

	/**
	 * Gets the ID of the settings page.
	 * @returns {string} - The ID of the settings page.
	 */
	function getID()
	{
		return this.ID;
	}

	/**
	 * Gets the name of the settings page.
	 * @returns {string} - The name of the settings page.
	 */
	function getName()
	{
		return this.Name;
	}

	/**
	 * Gets the components of the settings page.
	 * @returns {OrderedMap} - The components of the settings page.
	 */
	function getComponents()
	{
		return this.Components;
	}

	/**
	 * Gets all components as an array, with an optional filter.
	 * @param _filter {function|class} - The filter function or class.
	 * @returns {array} - The array of components.
	 */
	function getAllComponentsAsArray(_filter = null)
	{
		local ret = this.getComponents().values();
		if (_filter != null)
		{
			if (typeof _filter == "function")
			{
				ret = ret.filter(_filter);
			}
			else if (typeof _filter == "class")
			{
				ret = ret.filter(@(_idx, _component) _component instanceof _filter);
			}
			else
			{
				::logError("_filter must be of type function or class (not class instance!)");
				throw ::FU.Exception.InvalidType(_filter);
			}
		}

		return ret;
	}

	/**
	 * Resets the settings of the settings page.
	 */
	function resetSettings()
	{
		foreach (setting in this.getAllComponentsAsArray(::FU.Class.TemplateSetting))
		{
			setting.reset();
		}
	}

	/**
	 * Gets a component by its ID.
	 * @param _settingID {string} - The ID of the component.
	 * @returns {PageComponent} - The component object.
	 */
	function get(_settingID)
	{
		return this.Components[_settingID];
	}

	/**
	 * Verifies the flags for the settings page.
	 * @param _flags {array} - The flags to verify.
	 * @returns {boolean} - True if the flags are verified, false otherwise.
	 */
	function verifyFlags(_flags)
	{
		foreach (setting in this.Components)
		{
			if (setting.verifyFlags(_flags))
			{
				return true;
			}
		}
		return false;
	}

	/**
	 * Gets the UI data for the settings page.
	 * @param _flags {array} - The flags to verify.
	 * @returns {object} - The UI data for the settings page.
	 */
	function getUIData(_flags = [])
	{
		local ret = {
			name = this.getName(),
			id = this.getID(),
			settings = [],
			hidden = !this.verifyFlags(_flags)
		};

		foreach (setting in this.Components)
		{
			ret.settings.push(setting.getUIData(_flags));
		}
		return ret;
	}

	/**
	 * Converts the settings page to a string representation.
	 * @returns {string} - A string representation of the settings page.
	 */
	function tostring()
	{
		local ret = "Name: " + this.getName() + " | ID: " + this.getID() + " | Settings:\n";

		foreach (setting in this.Components)
		{
			ret += " " + setting;
		}
	}

	/**
	 * Alias for tostring.
	 * @returns {string} - A string representation of the settings page.
	 */
	function _tostring()
	{
		return this.tostring();
	}
        /**
         * Provides backwards compatibility
         * @param _panel {Panel} - The panel(screen) to set.
         */
         function setPanel(_panel) {
            this.Screen = _panel.weakref();
         }

         /**
         * Provides backwards compatibility
         * @returns {Panel} - Gets the panel (screen)
         */
         function getPanel() {
            return this.Screen;
           }    
   	 /**
	 * Provides backwards compatibility
	 * @returns {string} - The panel ID.
	 */
	function getPanelID()
	{
		return this.getScreen().getID();
	}    
 	/**
	 *  Compatability functions
	 *  Adds settings using their alternate names
	 */   

	function addTitle(_id, _name, _description = null)
	{
		::FU.Class.SettingsPage.AddHeading(_id, _name, _description = null);
	}
	function addBooleanSetting(_id, _value, _name = null, _description = null)
	{
		::FU.Class.SettingsPage.addToggleSetting(_id, _value, _name = null, _description = null)
	}
	function addRangeSetting(_id, _value, _min, _max, _step, _name = null, _description = null)
	{
		::FU.Class.SettingsPage.addSliderSetting(_id, _value, _min, _max, _step, _name = null, _description = null)
	}
	function addArraySetting(_id, _value, _name = null, _description = null)
	{
		::FU.Class.SettingsPage.addMultiselectSetting(_id, _value, _name = null, _description = null)
	}
	function addEnumSetting(_id, _value, _array, _name = null, _description = null)
	{
		::FU.Class.SettingsPage.addDropdownSetting(_id, _value, _array, _name = null, _description = null)
	}	
	function addComponent(_component)
	{
		if (!(_setting instanceof ::FU.Class.TemplateSetting))
		{
			this.logError("Setting is invalid, it should extend TemplateSetting");
		}
		_component.setPage(this);
		this.Components[_component.getID()] <- _component;
		return _component;
	}	
}

// Helper function for backward compatibility
::FU.Class.SettingsPage.addElement <- ::FU.Class.SettingsPage.addSetting;

