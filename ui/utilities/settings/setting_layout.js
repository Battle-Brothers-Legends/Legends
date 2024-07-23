/**
 * LayoutSetting Class
 * 
 * Handles the creation and management of layout settings, including Title, Divider, and Spacer settings.
 */
class LayoutSetting {
    /**
     * Constructor for the LayoutSetting class.
     * @param {object} mod - The mod object.
     * @param {object} page - The page object.
     * @param {object} setting - The setting object containing the layout data.
     * @param {object} parentDiv - The parent HTML element to which the setting is appended.
     */
    constructor(mod, page, setting, parentDiv) {
        this.data = setting;

        switch (setting.type) {
            case "Title":
                this.createTitle(mod, parentDiv);
                break;
            case "Divider":
                this.createDivider(parentDiv);
                break;
            case "Spacer":
                this.createSpacer(parentDiv);
                break;
            default:
                console.error("Invalid LayoutSetting type.");
        }
    }

    /**
     * Creates a title element.
     * @param {object} mod - The mod object.
     * @param {object} parentDiv - The parent HTML element.
     */
    createTitle(mod, parentDiv) {
        this.layout = $('<div class="title-container"/>');
        parentDiv.append(this.layout);
        this.title = $('<div class="title title-font-big font-bold font-color-title">' + this.data.name + '</div>');
        this.layout.append(this.title);
        this.bindTooltip(mod);
    }

    /**
     * Creates a divider element.
     * @param {object} parentDiv - The parent HTML element.
     */
    createDivider(parentDiv) {
        this.layout = $('<div class="divider"/>');
        parentDiv.append(this.layout);
    }

    /**
     * Creates a spacer element.
     * @param {object} parentDiv - The parent HTML element.
     */
    createSpacer(parentDiv) {
        this.layout = $('<div class="spacer"/>');
        parentDiv.append(this.layout);
        this.layout.css("width", this.data.data.Width);
        this.layout.css("height", this.data.data.Height);
    }

    /**
     * Binds a tooltip to the title element.
     * @param {object} mod - The mod object.
     */
    bindTooltip(mod) {
        this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: mod.id, settingsElementId: this.data.id });
    }

    /**
     * Unbinds tooltips from the title element.
     */
    unbindTooltip() {
        if (this.title) {
            this.title.unbindTooltip();
        }
    }
}


function DividerSetting(mod, page, setting, parentDiv) {
    setting.type = "Divider";
    return new LayoutSetting(mod, page, setting, parentDiv);
}

function SpacerSetting(mod, page, setting, parentDiv) {
    setting.type = "Spacer";
    return new LayoutSetting(mod, page, setting, parentDiv);
}

TitleSetting.prototype.unbindTooltip = function () {
    this.unbindTooltip();
};

DividerSetting.prototype.unbindTooltip = function () {
};

SpacerSetting.prototype.unbindTooltip = function () {
};

// Example usage
const mod = { id: "exampleMod" };
const page = { id: "examplePage" };
const titleSetting = {
    name: "Example Title",
    type: "Title",
    id: "exampleTitle"
};
const dividerSetting = {
    name: "Example Divider",
    type: "Divider",
    id: "exampleDivider"
};
const spacerSetting = {
    name: "Example Spacer",
    type: "Spacer",
    id: "exampleSpacer",
    data: { Width: "100px", Height: "20px" }
};
const parentDiv = $('<div/>');  // Replace with actual parent div

const titleLayoutSetting = new LayoutSetting(mod, page, titleSetting, parentDiv);
const dividerLayoutSetting = new LayoutSetting(mod, page, dividerSetting, parentDiv);
const spacerLayoutSetting = new LayoutSetting(mod, page, spacerSetting, parentDiv);

const oldTitleSetting = TitleSetting(mod, page, titleSetting, parentDiv);
const oldDividerSetting = DividerSetting(mod, page, dividerSetting, parentDiv);
const oldSpacerSetting = SpacerSetting(mod, page, spacerSetting, parentDiv);

