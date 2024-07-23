/*
*
*  Extends existing menus to add in our mod settings 
*
*/

// Preserve the original createMainMenuButtons function and extend it
var createMainMenuButtons = MainMenuModule.prototype.createMainMenuButtons;
MainMenuModule.prototype.createMainMenuButtons = function () {
    createMainMenuButtons.call(this);
    this.addModOptionsButton();
};

// Function to add a "Mod Options" button to the main menu
MainMenuModule.prototype.addModOptionsButton = function () {
    var self = this;

    // Create a new row for the button
    var row = $('<div class="row"></div>');
    var temp = this.mButtonContainer.find('.divider');
    temp.before(row);

    // Create and append the button
    var buttonLayout = $('<div class="l-center"></div>');
    row.append(buttonLayout);
    buttonLayout.createTextButton("Game Options", function () {
        self.notifyBackendModOptionsButtonPressed();
    }, '', 4);
};

// Add the "Mod Options" button to the MainMenuScreen module
Screens.MainMenuScreen.getModule("MainMenuModule").addModOptionsButton();

// Function to notify the backend when the "Mod Options" button is pressed
MainMenuModule.prototype.notifyBackendModOptionsButtonPressed = function() {
    SQ.call(this.mSQHandle, 'onModOptionsButtonPressed');
};

// Preserve and extend the createWorldMapMenuButtons function
var createWorldMapMenuButtons = MainMenuModule.prototype.createWorldMapMenuButtons;
MainMenuModule.prototype.createWorldMapMenuButtons = function (_isSavingAllowed, _seed) {
    createWorldMapMenuButtons.call(this, _isSavingAllowed, _seed);
    this.addModOptionsButton();
};

// Preserve and extend the createTacticalMapMenuButtons function
var createTacticalMapMenuButtons = MainMenuModule.prototype.createTacticalMapMenuButtons;
MainMenuModule.prototype.createTacticalMapMenuButtons = function (_isRetreatAllowed, _isQuitAllowed, _quitText) {
    createTacticalMapMenuButtons.call(this, _isRetreatAllowed, _isQuitAllowed, _quitText);
    this.addModOptionsButton();
};




