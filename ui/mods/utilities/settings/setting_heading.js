var HeadingSetting = function (_mod, _page, _setting, _parentDiv) {
    this.data = _setting;
    this.layout = $('<div class="heading-container"/>');
    _parentDiv.append(this.layout);

    // Determine the size class based on the provided size
    var sizeClass;
    switch (_setting.size) {
        case "extra-small":
            sizeClass = "heading-size-xs";
            break;
        case "small":
            sizeClass = "heading-size-sm";
            break;
        case "large":
            sizeClass = "heading-size-lg";
            break;
        case "extra-large":
            sizeClass = "heading-size-xl";
            break;
        case "normal":
        default:
            sizeClass = "heading-size-normal";
            break;
    }

    // Determine the color class based on the provided color
    var colorClass;
    switch (_setting.color) {
        case "secondary":
            colorClass = "heading-color-secondary";
            break;
        case "tertiary":
            colorClass = "heading-color-tertiary";
            break;
        case "primary":
        default:
            colorClass = "heading-color-primary";
            break;
    }

    this.title = $('<div class="heading ' + sizeClass + ' ' + colorClass + '">' + _setting.name + '</div>');
    this.layout.append(this.title);
    this.title.bindTooltip({ contentType: 'FU-generic', modId: FU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

HeadingSetting.prototype.unbindTooltip = function () {
    this.title.unbindTooltip();
};


// Compatibility function for the old TitleSetting
var TitleSetting = function (_mod, _page, _setting, _parentDiv) {
    // Redirect to the new HeadingSetting with default size and color
    var headingSetting = new HeadingSetting(_mod, _page, {
        id: _setting.id,
        name: _setting.name,
        size: "normal", // Default size
        color: "primary" // Default color
    }, _parentDiv);
};

TitleSetting.prototype.unbindTooltip = function () {
    this.title.unbindTooltip();
};

// Register the new HeadingSetting and the old TitleSetting to maintain compatibility
window.HeadingSetting = HeadingSetting;
window.TitleSetting = TitleSetting;

function testHeadingSetting() {
    var testParentDiv = $('<div></div>');
    var testSetting = {
        name: "Test Heading",
        size: "extra-small",
        color: "tertiary",
        id: "testHeading"
    };

    var headingSetting = new HeadingSetting(null, null, testSetting, testParentDiv);
    console.assert(headingSetting.title.hasClass('heading-size-xs'), "Heading size class is incorrect.");
    console.assert(headingSetting.title.hasClass('heading-color-tertiary'), "Heading color class is incorrect.");
    console.log("HeadingSetting test passed.");
}

// testHeadingSetting();
