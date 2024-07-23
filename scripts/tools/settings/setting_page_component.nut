/**
 * Class representing the components that make up a page.
 * Titles, spacers, dividers and the SettingsTemplate are all types of PageComponent 
 */
class PageComponent {
    Name = null;
    ID = null;
    static Type = "Component";
    Data = null;
    Description = null;
    Page = null;

    /**
     * Constructor for PageComponent.
     * @param _id {string} - The unique identifier for the component.
     * @param _name {string} - The name of the component.
     * @param _description {string} - The description of the component.
     */
    constructor(_id, _name = null, _description = null) {
        if (_id.find(" ") != null) {
            logError("The ID of a PageComponent must not have spaces");
            throw Exception.InvalidValue(_id);
        }
        this.Name = _name == null ? _id : _name;
        this.ID = _id;
        this.Data = {};
        this.Description = _description == null ? "" : _description;
    }

    /**
     * Gets the type of the component.
     * @returns {string} - The type of the component.
     */
    function getType() {
        return this.Type;
    }

    /**
     * Sets the page for the component.
     * @param _page {Page} - The page to set.
     */
    function setPage(_page) {
        this.Page = _page.weakref();
    }

    /**
     * Gets the page of the component.
     * @returns {Page} - The page of the component.
     */
    function getPage() {
        return this.Page;
    }
    /**
     * Gets the screen ID of the component.
     * @returns {string} - The screen ID.
     */
    function getScreenID() {
        return this.getPage().getScreenID();
    }
    /**
     * Provides backwards compatibility.
     * Gets the panel ID of the component.
     * @returns {string} - The panel ID.
     */
    function getPanelID() {
        return this.getPage().getScreenID();
    }

    /**
     * Gets the mod of the component.
     * @returns {Mod} - The mod.
     */
    function getMod() {
        return this.getPage().getMod();
    }

    /**
     * Sets the description of the component.
     * @param _description {string} - The description to set.
     */
    function setDescription(_description) {
        this.Description = _description;
    }

    /**
     * Gets the description of the component.
     * @returns {string} - The description of the component.
     */
    function getDescription() {
        return this.Description;
    }

    /**
     * Gets the name of the component.
     * @returns {string} - The name of the component.
     */
    function getName() {
        return this.Name;
    }

    /**
     * Gets the ID of the component.
     * @returns {string} - The ID of the component.
     */
    function getID() {
        return this.ID;
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
    function getTooltip(_data) {
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
     * Verifies the flags for the component.
     * @param _flags {table} - The flags to verify.
     * @returns {boolean} - Whether the flags are verified.
     */
    function verifyFlags(_flags) {
        if (_flags != null) {
            if ("required" in _flags) {
                foreach (required in _flags.required) {
                    if (!(required in this.Data)) {
                        return false;
                    }
                }
            }
            if ("excluded" in _flags) {
                foreach (excluded in _flags.excluded) {
                    if (excluded in this.Data) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * Gets the UI data for the component.
     * @param _flags {table} - The flags to consider.
     * @returns {table} - The UI data.
     */
    function getUIData(_flags = []) {
        local ret = {
            type = this.getType(),
            id = this.getID(),
            name = this.getName(),
            data = this.Data,
            panel = this.getPanelID(),
            mod = this.getMod().getID(),
            hidden = !this.verifyFlags(_flags)
        };
        return ret;
    }
}

// Create an alias for backward compatibility
::FU.Class.SettingsElement <- PageComponent;

