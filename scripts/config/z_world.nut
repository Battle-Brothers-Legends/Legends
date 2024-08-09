local gt = this.getroottable();

gt.Const.World.settingsUpdate <- function ()
{

//this.logInfo("Legends exists: " + ("Legends" in getroottable()));
//this.logInfo("Legends.Mod exists: " + (::Legends.Mod != null));
//this.logInfo("Legends.Mod.ModSettings exists: " + (::Legends.Mod.ModSettings != null));
//this.logInfo("LegendsMod exists: " + ("LegendsMod" in getroottable()));
//this.logInfo("LegendsMod.Mod exists: " + (::LegendsMod.Mod != null));
//this.logInfo("LegendsMod.Mod.ModSettings exists: " + (::LegendsMod.Mod.ModSettings != null));

//	this.Const.World.Settings.LandMassMult = 1.0 + (::Legends.Mod.ModSettings.getSetting("LandRatio").getValue() / 100.0);
//	this.Const.World.Settings.WaterConnectivity = ::Legends.Mod.ModSettings.getSetting("Water").getValue();
//	this.Const.World.Settings.Snowline = ::Legends.Mod.ModSettings.getSetting("Snowline").getValue() / 100.0;
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
