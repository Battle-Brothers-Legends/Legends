this.world_town_screen <- {
	m = {
		JSHandle = null,
		MainDialogModule = null,
		HireDialogModule = null,
		ShopDialogModule = null,
		TravelDialogModule = null,
		BarberDialogModule = null,
		BlackmarketDialogModule = null,
		TempleDialogModule = null,
		TavernDialogModule = null,
		TrainingDialogModule = null,
		TaxidermistDialogModule = null,
		StablesDialogModule = null,
		Visible = null,
		Animating = null,
		LastActiveModule = null,
		Town = null,
		OnConnectedListener = null,
		OnDisconnectedListener = null,
		OnBrothersButtonPressedListener = null,
		OnModuleClosedListener = null
	},
	function isVisible()
	{
		return this.m.Visible != null && this.m.Visible == true;
	}

	function isAnimating()
	{
		if (this.m.Animating != null && this.m.MainDialogModule != null && this.m.HireDialogModule != null && this.m.ShopDialogModule != null && this.m.StablesDialogModule != null)
		{
			return this.m.Animating == true || this.m.MainDialogModule.isAnimating() || this.m.HireDialogModule.isAnimating() || this.m.ShopDialogModule.isAnimating() || this.m.TrainingDialogModule.isAnimating() || this.m.BarberDialogModule.isAnimating() || this.m.StablesDialogModule.isAnimating();
		}
		else
		{
			return false;
		}
	}

	function getMainDialogModule()
	{
		return this.m.MainDialogModule;
	}

	function getHireDialogModule()
	{
		return this.m.HireDialogModule;
	}

	function getStablesDialogModule()
	{
		return this.m.StablesDialogModule;
	}

	function getShopDialogModule()
	{
		return this.m.ShopDialogModule;
	}

	function getTravelDialogModule()
	{
		return this.m.TravelDialogModule;
	}

	function getBarberDialogModule()
	{
		return this.m.BarberDialogModule;
	}

	function getBlackmarketDialogModule()
	{
		return this.m.BlackmarketDialogModule;
	}

	function getTavernDialogModule()
	{
		return this.m.TavernDialogModule;
	}

	function getTempleDialogModule()
	{
		return this.m.TempleDialogModule;
	}

	function getTrainingDialogModule()
	{
		return this.m.TrainingDialogModule;
	}

	function getTaxidermistDialogModule()
	{
		return this.m.TaxidermistDialogModule;
	}

	function setTown( _t )
	{
		this.m.Town = _t;
	}

	function getTown()
	{
		return this.m.Town;
	}

	function setOnConnectedListener( _listener )
	{
		this.m.OnConnectedListener = _listener;
	}

	function setOnDisconnectedListener( _listener )
	{
		this.m.OnDisconnectedListener = _listener;
	}

	function setOnBrothersPressedListener( _listener )
	{
		this.m.OnBrothersButtonPressedListener = _listener;
	}

	function setOnModuleClosedListener( _listener )
	{
		this.m.OnModuleClosedListener = _listener;
	}

	function clearEventListener()
	{
		this.m.OnConnectedListener = null;
		this.m.OnDisconnectedListener = null;
		this.m.OnBrothersButtonPressedListener = null;
		this.m.OnModuleClosedListener = null;
	}

	function create()
	{
		this.m.Visible = false;
		this.m.Animating = false;
		this.m.JSHandle = this.UI.connect("WorldTownScreen", this);
		this.m.MainDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_main_dialog_module");
		this.m.MainDialogModule.setParent(this);
		this.m.MainDialogModule.connectUI(this.m.JSHandle);
		this.m.HireDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_hire_dialog_module");
		this.m.HireDialogModule.setParent(this);
		this.m.HireDialogModule.connectUI(this.m.JSHandle);
		this.m.ShopDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_shop_dialog_module");
		this.m.ShopDialogModule.setParent(this);
		this.m.ShopDialogModule.connectUI(this.m.JSHandle);
		this.m.TravelDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_travel_dialog_module");
		this.m.TravelDialogModule.setParent(this);
		this.m.TravelDialogModule.connectUI(this.m.JSHandle);
		this.m.BarberDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_barber_dialog_module");
		this.m.BarberDialogModule.setParent(this);
		this.m.BarberDialogModule.connectUI(this.m.JSHandle);
		this.m.TavernDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_tavern_dialog_module");
		this.m.TavernDialogModule.setParent(this);
		this.m.TavernDialogModule.connectUI(this.m.JSHandle);
		this.m.TempleDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_temple_dialog_module");
		this.m.TempleDialogModule.setParent(this);
		this.m.TempleDialogModule.connectUI(this.m.JSHandle);
		this.m.TrainingDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_training_dialog_module");
		this.m.TrainingDialogModule.setParent(this);
		this.m.TrainingDialogModule.connectUI(this.m.JSHandle);
		this.m.TaxidermistDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_taxidermist_dialog_module");
		this.m.TaxidermistDialogModule.setParent(this);
		this.m.TaxidermistDialogModule.connectUI(this.m.JSHandle);
		this.m.StablesDialogModule = this.new("scripts/ui/screens/world/modules/world_town_screen/town_stables_dialog_module");
		this.m.StablesDialogModule.setParent(this);
		this.m.StablesDialogModule.connectUI(this.m.JSHandle);
	}

	function destroy()
	{
		this.clearEventListener();
		this.m.ShopDialogModule.destroy();
		this.m.ShopDialogModule = null;
		this.m.HireDialogModule.destroy();
		this.m.HireDialogModule = null;
		this.m.TravelDialogModule.destroy();
		this.m.TravelDialogModule = null;
		this.m.BarberDialogModule.destroy();
		this.m.BarberDialogModule = null;
		this.m.TavernDialogModule.destroy();
		this.m.TavernDialogModule = null;
		this.m.TempleDialogModule.destroy();
		this.m.TempleDialogModule = null;
		this.m.TrainingDialogModule.destroy();
		this.m.TrainingDialogModule = null;
		this.m.TaxidermistDialogModule.destroy();
		this.m.TaxidermistDialogModule = null;
		this.m.StablesDialogModule.destroy();
		this.m.StablesDialogModule = null;
		this.m.MainDialogModule.destroy();
		this.m.MainDialogModule = null;
		this.m.JSHandle = this.UI.disconnect(this.m.JSHandle);
	}

	function clear()
	{
		this.m.Town = null;
		this.m.ShopDialogModule.clear();
		this.m.HireDialogModule.clear();
		this.m.TravelDialogModule.clear();
		this.m.BarberDialogModule.clear();
		this.m.TavernDialogModule.clear();
		this.m.TempleDialogModule.clear();
		this.m.TrainingDialogModule.clear();
		this.m.TaxidermistDialogModule.clear();
		this.m.StablesDialogModule.clear();
		this.m.MainDialogModule.clear();
	}

	function show()
	{
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("show", this.queryTownInformation());
		}
	}

	function hide()
	{
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.m.JSHandle.asyncCall("hide", null);
			this.Tooltip.hide();
		}
	}

	function hideAllDialogs()
	{
		if (this.m.JSHandle != null)
		{
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("hideAllDialogs", null);
		}
	}

	function refresh()
	{
		if (this.m.JSHandle != null)
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("refresh", this.queryTownInformation());
		}
	}

	function showLastActiveDialog()
	{
		if (this.m.LastActiveModule == this.m.HireDialogModule)
		{
			this.showHireDialog();
		}
		else if (this.m.LastActiveModule == this.m.ShopDialogModule)
		{
			this.showShopDialog();
		}
		else if (this.m.LastActiveModule == this.m.TravelDialogModule)
		{
			this.showTravelDialog();
		}
		else if (this.m.LastActiveModule == this.m.BarberDialogModule)
		{
			this.showBarberDialog();
		}
		else if (this.m.LastActiveModule == this.m.TavernDialogModule)
		{
			this.showTavernDialog();
		}
		else if (this.m.LastActiveModule == this.m.TempleDialogModule)
		{
			this.showTempleDialog();
		}
		else if (this.m.LastActiveModule == this.m.TrainingDialogModule)
		{
			this.showTrainingDialog();
		}
		else if (this.m.LastActiveModule == this.m.TaxidermistDialogModule)
		{
			this.showTaxidermistDialog();
		}
		else if (this.m.LastActiveModule == this.m.StablesDialogModule)
		{
			this.showStablesDialog();
		}
		else
		{
			this.showMainDialog();
		}
	}

	function showMainDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = null;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showMainDialog", this.queryAssetsInformation());

			if (this.World.Assets.isIronman())
			{
				this.World.presave();
			}
		}
	}

	function showHireDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.HireDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showHireDialog", this.m.HireDialogModule.queryHireInformation());
		}
	}

	function showStablesDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.StablesDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showStablesDialog", this.m.StablesDialogModule.queryHireInformation());
		}
	}

	function showShopDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.ShopDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showShopDialog", this.m.ShopDialogModule.queryShopInformation());
		}
	}

	function showTravelDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TravelDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTravelDialog", this.m.TravelDialogModule.queryTravelInformation());
		}
	}

	function showBarberDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.BarberDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showBarberDialog", this.m.BarberDialogModule.queryRosterInformation());
		}
	}

	function showBlackmarketDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.BlackmarketDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showBlackmarketDialog", this.m.BlackmarketDialogModule.queryRosterInformation());
		}
	}

	function showTempleDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TempleDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTempleDialog", this.m.TempleDialogModule.queryRosterInformation());
		}
	}

	function showTrainingDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TrainingDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTrainingDialog", this.m.TrainingDialogModule.queryRosterInformation());
		}
	}

	function showTaxidermistDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TaxidermistDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTaxidermistDialog", this.m.TaxidermistDialogModule.queryBlueprints());
		}
	}

	function showTavernDialog()
	{
		if (this.m.JSHandle != null && this.isVisible())
		{
			this.m.LastActiveModule = this.m.TavernDialogModule;
			this.Tooltip.hide();
			this.m.JSHandle.asyncCall("showTavernDialog", this.m.TavernDialogModule.queryData());
		}
	}

	function updateContracts()
	{
		if (this.m.Town == null)
		{
			return;
		}

		this.m.JSHandle.asyncCall("updateContracts", this.m.Town.getUIContractInformation());
	}

	function updateAssets()
	{
		this.m.JSHandle.asyncCall("loadAssetData", this.queryAssetsInformation());
	}

	function onScreenConnected()
	{
		if (this.m.OnConnectedListener != null)
		{
			this.m.OnConnectedListener();
		}
	}

	function onScreenDisconnected()
	{
		if (this.m.OnDisconnectedListener != null)
		{
			this.m.OnDisconnectedListener();
		}
	}

	function onScreenShown()
	{
		this.m.Visible = true;
		this.m.Animating = false;
	}

	function onScreenHidden()
	{
		this.m.Visible = false;
		this.m.Animating = false;
	}

	function onScreenAnimating()
	{
		this.m.Animating = true;
	}

	function onBrothersButtonPressed()
	{
		if (this.m.OnBrothersButtonPressedListener != null)
		{
			this.m.OnBrothersButtonPressedListener();
		}
	}

	function onModuleClosed()
	{
		if (this.m.OnModuleClosedListener != null)
		{
			this.m.OnModuleClosedListener();
		}
	}

	function onSlotClicked( _data )
	{
		if (this.isAnimating())
		{
			return;
		}

		if (this.m.Town != null)
		{
			this.m.Town.onSlotClicked(_data, this);
		}
	}

	function onContractClicked( _data )
	{
		if (this.isAnimating())
		{
			return;
		}

		this.World.Contracts.showContractByID(_data);
	}

	function queryTownInformation()
	{
		if (this.m.Town == null)
		{
			return;
		}

		return this.m.Town.getUIInformation();
	}

	function queryAssetsInformation()
	{
		return this.UIDataHelper.convertAssetsInformationToUIData();
	}

};

