/*
*
*  Extends existing main menu to add in our mod settings 
*
*/



// Function to show the main menu module
MainMenuScreen.prototype.showMainMenuModule = function () {
    this.mMainMenuModule.show();
};

// Function to hide the main menu module
MainMenuScreen.prototype.hideMainMenuModule = function () {
    this.mMainMenuModule.hide();
};

// Function to hide the new campaign module
MainMenuScreen.prototype.hideNewCampaignModule = function () {
    this.mNewCampaignModule.hide();
};

// Function to show the new campaign module
MainMenuScreen.prototype.showNewCampaignModule = function () {
    this.mNewCampaignModule.show();
    this.mNewCampaignModule.mFirstPanel.removeClass('display-block').addClass('display-none');
    this.mNewCampaignModule.mSecondPanel.removeClass('display-block').addClass('display-none');
    this.mNewCampaignModule.mThirdPanel.addClass('display-block').removeClass('display-none');
    this.mNewCampaignModule.mCancelButton.changeButtonText("Previous");
    this.mNewCampaignModule.mStartButton.changeButtonText("Next");
};

