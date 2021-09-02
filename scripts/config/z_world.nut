local gt = this.getroottable();

gt.Const.World.SettingsUpdate <- function (_settings)
{
	local water = _settings.WaterConnectivity
	local landmass =  1.0 + _settings.LandMassMult / 100.0;
	local connectivity =  _settings.WaterConnectivity;
	local landwaterratio = 1.6;
	local desert = 2000

	// switch (water)
	// {
	// 	case 10:
	// 		landmass = 1.5;
	// 		connectivity = 43;
	// 		landwaterratio = 1.30;
	// 		desert = 1000
	// 		break;
	// 	case 9:
	// 		landmass = 1.5;
	// 		connectivity = 42;
	// 		landwaterratio = 1.35;
	// 		desert = 1200
	// 		break;
	// 	case 8:
	// 		landmass = 1.5;
	// 		connectivity = 41;
	// 		landwaterratio = 1.4;
	// 		desert = 1300
	// 		break;
	// 	case 7:
	// 		landmass = 1.5;
	// 		connectivity = 40;
	// 		landwaterratio = 1.5;
	// 		desert = 1600
	// 		break;
	// 	case 6:
	// 		landmass = 1.5;
	// 		connectivity = 39;
	// 		landwaterratio = 1.55;
	// 		desert = 1800
	// 		break;
	// 	case 5:
	// 		landmass = 1.5;
	// 		connectivity = 38;
	// 		landwaterratio = 1.6;
	// 		desert = 2000
	// 		break;
	// 	case 4:
	// 		landmass = 1.55;
	// 		connectivity = 35;
	// 		landwaterratio = 1.63;
	// 		desert = 2100
	// 		break;
	// 	case 3:
	// 		landmass = 1.60;
	// 		connectivity = 33;
	// 		landwaterratio = 1.65;
	// 		desert = 2200
	// 		break;
	// 	case 2:
	// 		landmass = 1.65;
	// 		connectivity = 31;
	// 		landwaterratio = 1.68;
	// 		desert = 2300
	// 		break;
	// 	case 1:
	// 		landmass = 1.7;
	// 		connectivity = 29;
	// 		landwaterratio = 1.7;
	// 		desert = 2400
	// 		break;
	// }
	this.Const.World.Settings.LandMassMult = landmass;
	this.Const.World.Settings.WaterConnectivity = connectivity;
	this.Const.World.Settings.MinLandToWaterRatio = landwaterratio
	this.Const.World.Settings.MinDesertTiles = desert
	this.Const.World.Settings.Snowline = _settings.Snowline;

	this.Const.World.Settings.SizeX = _settings.Width;
	this.Const.World.Settings.SizeY = _settings.Height;
	// if ( _settings.LandMassMult < 1.1) {
	// 	this.Const.World.Settings.MinLandToWaterRatio = 1.0;
	// } else if  ( _settings.LandMassMult < 1.2 ) {
	// 	this.Const.World.Settings.MinLandToWaterRatio = 1.2;
	// } else if  ( _settings.LandMassMult < 1.3 ) {
	// 	this.Const.World.Settings.MinLandToWaterRatio = 1.3;
	// } else if  ( _settings.LandMassMult < 1.4 ) {
	// 	this.Const.World.Settings.MinLandToWaterRatio = 1.4;
	// }
	// this.Const.World.Settings.ForestsMult <- _settings.ForestsMult;
	// this.Const.World.Settings.SwampsMult <- _settings.SwampsMult;
	// this.Const.World.Settings.MountainsMult <- _settings.MountainsMult;
	// this.Const.World.Settings.Vision = _settings.Vision
	//Vision = 500.0
};


gt.Const.World.SettlementsUpdate <- function (_val)
{
	local total = 0.0
	foreach(s in gt.Const.World.Settlements.Master)
	{
		total = total + s.Amount;
	}

	foreach(s in gt.Const.World.Settlements.Master)
	{
		s.Percentage <- s.Amount / total;
		s.Amount = Math.ceil(_val * (s.Amount / total));
	}
};


gt.Const.World.Settlements.LegendsWorldMaster <- [
	{
		Ratio = 0.20,
		Types = this.Const.World.Settlements.Legends_villages_coast,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2
			},
			{
				Ratio = 2,
				MinAmount = 1,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.50,
		Types = Const.World.Settlements.Legends_villages,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2,
			},
			{
				Ratio = 2,
				MinAmount = 2,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.30,
		Types = Const.World.Settlements.Legends_fortifications,
		Sizes = [
			{
				Ratio = 5,
				MinAmount = 1,
				Size = 1
			},
			{
				Ratio = 3,
				MinAmount = 1,
				Size = 2
			},
			{
				Ratio = 2,
				MinAmount = 2,
				Size = 3
			}
		]
	},
	{
		Ratio = 0.0,
		Types = Const.World.Settlements.Legends_citystates,
		IgnoreSide = true,
		AdditionalSpace = 13,
		Sizes = [
			{
				Ratio = 10,
				MinAmount = 3,
				Size = 3
			}
		]
	}
];

gt.Const.World.NewCampaignOpts <- function ()
{
	return {
		Width = this.Const.World.Settings.SizeX,
		WidthMin = this.Const.World.Settings.SizeX,
		WidthMax = this.Const.World.Settings.SizeX,
		Height = this.Const.World.Settings.SizeY,
		HeightMin = this.Const.World.Settings.SizeY,
		HeightMax = this.Const.World.Settings.SizeY,
		LandMassMult = 50, //this.Const.World.Settings.LandMassMult * 100 - 100,
		LandMassMultMin = 45,
		LandMassMultMax = 80,
		WaterConnectivity = 38, //this.Const.World.Settings.WaterConnectivity - 36,
		WaterConnectivityMin = 28,
		WaterConnectivityMax = 48,
		MinLandToWaterRatio = 7, //this.Const.World.Settings.MinLandToWaterRatio * 10,
		MinLandToWaterRatioMin = 5,
		MinLandToWaterRatioMax = 9,
		Snowline = 0.85 * 100,
		SnowlineMin = 75,
		SnowlineMax = 95,
		NumSettlements = 27,
		NumSettlementsMax = 50,
		NumSettlementsMin = 19,
		NumFactions = 3,
		NumFactionsMin = 1,
		NumFactionsMax = 6//Math.min(11, this.Const.GetFactionArchetypesList().len()),
		FOW = true,
		ForestsMult = 50,
		ForestsMultMax = 100,
		ForestsMultMin = 1
		SwampsMult = 50,
		SwampsMultMax = 100,
		SwampsMultMin = 1,
		MountainsMult = 50,
		MountainsMultMax = 100,
		MountainsMultMin = 1,
		Debug = false,
		StackCitadels = false,
		AllTradeLocations = false
	}
}

gt.Const.World.LegendaryContract <-
{
	WhiteWolf = 0,
	RedSpider = 0,
	GreenSchrat = 0,
	DemonAlp = 0,
	BossHexe = 0,
	RockUnhold = 0,
	Stollwurm = 0,
	SkinGhoul = 0,
	BarbPrison = 0,
	BanditArmy = 0
}

gt.Const.World.ContractCost <-
{
	WhiteWolf = 200,
	RedSpider = 200,
	GreenSchrat = 200,
	DemonAlp = 200,
	BossHexe = 200,
	RockUnhold = 200,
	StollWurm = 200,
	SkinGhoul = 200,
	BarbPrison = 200,
	BanditArmy = 200
};