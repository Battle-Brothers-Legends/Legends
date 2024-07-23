/**
 * 
 * The main settings screen for each mod 
 *
 */

::FU.Class.SettingsScreen <- class
{
	Pages = null;
	ID = null;
	Name = null;
	Mod = null;
	Order = 1;

	/**
	 * Constructor for SettingsScreen.
	 * @param _id {string} - The unique identifier for the settings screen.
	 * @param _name {string} - The name of the settings screen.
	 */
	constructor(_id, _name = null)
	{
		this.ID = _id;
		this.Name = _name == null ? _id : _name;
		this.Pages = ::FU.Class.OrderedMap();
	}

	/**
	 * Gets the pages of the settings screen.
	 * @returns {OrderedMap} - The pages of the settings screen.
	 */
	function getPages()
	{
		return this.Pages;
	}

	/**
	 * Adds a page to the settings screen.
	 * @param _page {SettingsPage} - The page to add.
	 */
	function addPage(_page)
	{
		if (!(_page instanceof ::FU.Class.SettingsPage))
		{
			throw ::FU.Exception.InvalidType(_page);
		}
		_page.setScreen(this);
		local hasKeybinds = this.Pages.contains("Keybinds");
		this.Pages[_page.getID()] <- _page;
		if (hasKeybinds)
		{
			this.Pages.sort(function(_id1, _page1, _id2, _page2)
			{
				if (_id1 == "Keybinds")
				{
					return 1;
				}
				if (_id2 == "Keybinds")
				{
					return -1;
				}
				return 0;
			});
		}
	}

	/**
	 * Gets all components as an array.
	 * @param _filter {function|class} - The filter function or class.
	 * @returns {array} - The array of components.
	 */
	function getAllComponentsAsArray(_filter = null)
	{
		local ret = [];
		foreach (page in this.Pages)
		{
			ret.extend(page.getAllComponentsAsArray(_filter));
		}
		return ret;
	}

	/**
	 * Resets all settings in the screen.
	 */
	function resetSettings()
	{
		foreach (setting in this.getAllComponentsAsArray(::FU.Class.TemplateSetting))
		{
			setting.reset();
		}
	}

	/**
	 * Gets a specific setting by its ID.
	 * @param _settingID {string} - The ID of the setting.
	 * @returns {TemplateSetting} - The setting object.
	 */
	function getSetting(_settingID)
	{
		foreach (page in this.Pages)
		{
			if (page.getSettings().contains(_settingID))
			{
				return page.get(_settingID);
			}
		}

		throw ::FU.Exception.KeyNotFound(_settingID);
	}

	/**
	 * Checks if a specific setting exists.
	 * @param _settingID {string} - The ID of the setting.
	 * @returns {boolean} - True if the setting exists, false otherwise.
	 */
	function hasSetting(_settingID)
	{
		foreach (page in this.Pages)
		{
			if (page.getSettings().contains(_settingID))
			{
				return true;
			}
		}

		return false;
	}

	/**
	 * Checks if a specific page exists.
	 * @param _pageID {string} - The ID of the page.
	 * @returns {boolean} - True if the page exists, false otherwise.
	 */
	function hasPage(_pageID)
	{
		return this.getPages().contains(_pageID);
	}

	/**
	 * Gets a specific page by its ID.
	 * @param _pageID {string} - The ID of the page.
	 * @returns {SettingsPage} - The page object.
	 */
	function getPage(_pageID)
	{
		return this.Pages[_pageID];
	}

	/**
	 * Verifies flags for all pages.
	 * @param _flags {array} - The flags to verify.
	 * @returns {boolean} - True if any page verifies the flags, false otherwise.
	 */
	function verifyFlags(_flags)
	{
		foreach (page in this.Pages)
		{
			if (page.verifyFlags(_flags))
			{
				return true;
			}
		}
		return false;
	}

	/**
	 * Gets the name of the settings screen.
	 * @returns {string} - The name of the settings screen.
	 */
	function getName()
	{
		return this.Name;
	}

	/**
	 * Gets the ID of the settings screen.
	 * @returns {string} - The ID of the settings screen.
	 */
	function getID()
	{
		return this.ID;
	}

	/**
	 * Sets the mod associated with the settings screen.
	 * @param _mod {object} - The mod object.
	 */
	function setMod(_mod)
	{
		this.Mod = _mod.weakref();
	}

	/**
	 * Gets the mod associated with the settings screen.
	 * @returns {object} - The mod object.
	 */
	function getMod()
	{
		return this.Mod;
	}

	/**
	 * Gets the ID of the mod associated with the settings screen.
	 * @returns {string} - The ID of the mod.
	 */
	function getModID()
	{
		return this.Mod.getID();
	}

	/**
	 * Calls a function on all settings.
	 * @param _function {string} - The function to call.
	 * @param _argsArray {array} - The arguments to pass to the function.
	 */
	function callSettingsFunction(_function, _argsArray)
	{
		_argsArray.insert(0, null);
		foreach (page in this.Pages)
		{
			foreach (setting in page.getSettings())
			{
				if (setting instanceof ::FU.Class.TemplateSetting)
				{
					_argsArray[0] = setting;
					setting[_function].acall(_argsArray);
				}
			}
		}
	}

	/**
	 * Serializes flags for all settings.
	 * @param _out {variant} - The output object for serialization.
	 */
	function flagSerialize(_out)
	{
		this.callSettingsFunction("flagSerialize", [_out]);
	}

	/**
	 * Deserializes flags for all settings.
	 * @param _in {variant} - The input object for deserialization.
	 */
	function flagDeserialize(_in)
	{
		this.callSettingsFunction("flagDeserialize", [_in]);
	}

	/**
	 * Gets UI data for the settings screen.
	 * @param _flags {array} - The flags for filtering.
	 * @returns {object} - The UI data object.
	 */
	function getUIData(_flags = [])
	{
		local ret = {
			id = this.getID(),
			name = this.getName(),
			pages = [],
			hidden = !this.verifyFlags(_flags),
			order = this.Order
		}

		foreach (pageID, page in this.Pages)
		{
			ret.pages.push(page.getUIData(_flags));
		}

		return ret;
	}
}

// Helper alias for backward compatibility
::FU.Class.SettingsPanel <- ::FU.Class.SettingsScreen;


/**
 *
 * How to use
 * Settings screens are the highest level of the settings heirarchy 
 *
 * SettingsScreen
 *   └── SettingsPage	 
 *          └── PageComponent~
 *                  ├── SettingTemplate~
 *                  │       ├── ToggleSetting
 *                  │       ├── DropdownSetting
 *                  │       ├── SliderSetting
 *                  │       ├── TextInputSetting
 *                  │       ├── ColorPickerSetting
 *                  │       └── MultiSelectSetting
 *                  ├── DividerComponent
 *                  ├── SpacerComponent
 *                  └── HeadingComponent
 *
 *  Every mod has a settings screen. 
 *  Each settings screen has one or more pages
 *  Each page has a number of settings and components
 *  So at the Screen level we just define what its called and which mod its for
 *  All the actual settings are defined further down 
 *
 */


