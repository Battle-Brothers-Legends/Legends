local gt = this.getroottable();
gt.Const.Serialization <- {
	Version = 66
};
gt.Const.DLC <- {
	Mask = 0,
	Info = [],
	Fangshire = false,
	Lindwurm = false,
	Unhold = false,
	UnholdSupporter = false,
	Wildmen = false,
	WildmenSupporter = false,
	Desert = false,
	DesertSupporter = false,
	function isCompatible( _meta )
	{
		local maskInSave = _meta.getInt("dlc");

		for( local i = 0; i != 32; i = ++i )
		{
			if ((maskInSave & 1 << i) != 0 && (this.Const.DLC.Mask & 1 << i) == 0)
			{
				return false;
			}
		}

		return true;
	}

};
this.Const.DLC.Info.resize(32, null);
this.Const.DLC.Info[1] = {
	Announce = true,
	Icon = "ui/images/dlc_1.png",
	IconDisabled = "ui/images/dlc_1_sw.png",
	URL = this.isSteamBuild() ? "https://store.steampowered.com/app/732460/Battle_Brothers__Lindwurm/" : "https://www.gog.com/game/battle_brothers"
};
this.Const.DLC.Info[2] = {
	Announce = true,
	Icon = "ui/images/dlc_2.png",
	IconDisabled = "ui/images/dlc_2_sw.png",
	URL = this.isSteamBuild() ? "https://store.steampowered.com/app/961930/Battle_Brothers__Beasts__Exploration/" : "https://www.gog.com/game/battle_brothers_beasts_exploration"
};
this.Const.DLC.Info[4] = {
	Announce = true,
	Icon = "ui/images/dlc_4.png",
	IconDisabled = "ui/images/dlc_4_sw.png",
	URL = this.isSteamBuild() ? "https://store.steampowered.com/app/1067690/Battle_Brothers__Warriors_of_the_North" : "https://www.gog.com/game/battle_brothers_warriors_of_the_north"
};
this.Const.DLC.Info[6] = {
	Announce = true,
	Icon = "ui/images/dlc_6.png",
	IconDisabled = "ui/images/dlc_6_sw.png",
	URL = this.isSteamBuild() ? "https://store.steampowered.com/app/1361280/Battle_Brothers__Blazing_Deserts" : "https://www.gog.com/game/battle_brothers_blazing_deserts"
};
gt.Const.Direction <- {
	N = 0,
	NE = 1,
	SE = 2,
	S = 3,
	SW = 4,
	NW = 5,
	COUNT = 6
};
gt.Const.DirectionAsBit <- {
	N = 1,
	NE = 2,
	SE = 4,
	S = 8,
	SW = 16,
	NW = 32
};
gt.Const.DirectionBit <- [
	1,
	2,
	4,
	8,
	16,
	32,
	0
];
gt.Const.getNumDirectionBits <- function ( _dir )
{
	local n = 0;

	if ((_dir & 1) != 0)
	{
		n = ++n;
	}

	if ((_dir & 2) != 0)
	{
		n = ++n;
	}

	if ((_dir & 4) != 0)
	{
		n = ++n;
	}

	if ((_dir & 8) != 0)
	{
		n = ++n;
	}

	if ((_dir & 16) != 0)
	{
		n = ++n;
	}

	if ((_dir & 32) != 0)
	{
		n = ++n;
	}

	return n;
};
gt.Const.DirectionStep <- [
	[
		0,
		1
	],
	[
		1,
		0
	],
	[
		1,
		-1
	],
	[
		0,
		-1
	],
	[
		-1,
		0
	],
	[
		-1,
		1
	]
];
gt.Const.DirectionAngle <- [
	0,
	315,
	225,
	180,
	135,
	45
];
gt.Const.Direction8 <- {
	N = 0,
	NE = 1,
	E = 2,
	SE = 3,
	S = 4,
	SW = 5,
	W = 6,
	NW = 7,
	COUNT = 8
};
gt.Const.Difficulty <- {
	Easy = 0,
	Normal = 1,
	Hard = 2,
	Legendary = 3,
	BuyPriceMult = [
		0.95,
		1.0,
		1.05,
		1.1
	],
	SellPriceMult = [
		1.05,
		1.0,
		0.95,
		0.9
	],
	EnemyMult = [
		0.85,
		1.0,
		1.15,
		1.0
	],
	PaymentMult = [
		1.1,
		1.0,
		0.95,
		0.9
	],
	MinPayments = [
		100,
		50,
		30,
		10
	],
	MinHeadPayments = [
		15,
		10,
		5,
		1
	],
	HealMult = [
		1.0,
		0.66,
		0.33,
		0.1
	],
	RepairMult = [
		1.0,
		0.66,
		0.33,
		0.1
	],
	RetreatDefenseBonus = [
		30,
		20,
		10,
		0
	],
	MaxResources = [
		{
			Food = 300,
			Ammo = 250,
			Medicine = 100,
			ArmorParts = 100
		},
		{
			Food = 250,
			Ammo = 150,
			Medicine = 75,
			ArmorParts = 75
		},
		{
			Food = 200,
			Ammo = 100,
			Medicine = 50,
			ArmorParts = 75
		},
		{
			Food = 100,
			Ammo = 75,
			Medicine = 30,
			ArmorParts = 50
		}
	]
};
gt.Const.Camera <- {
	MouseMoveThreshold = 5,
	MouseScrollThreshold = 50,
	MouseScrollFactor = 14
};
gt.Const.EntityType <- {
	Player = -1,
	Necromancer = 0,
	Zombie = 1,
	ZombieYeoman = 2,
	ZombieKnight = 3,
	ZombieBoss = 4,
	SkeletonLight = 5,
	SkeletonMedium = 6,
	SkeletonHeavy = 7,
	SkeletonPriest = 8,
	SkeletonBoss = 9,
	Vampire = 10,
	Ghost = 11,
	Ghoul = 12,
	OrcYoung = 13,
	OrcBerserker = 14,
	OrcWarrior = 15,
	OrcWarlord = 16,
	Militia = 17,
	MilitiaRanged = 18,
	MilitiaVeteran = 19,
	MilitiaCaptain = 20,
	BountyHunter = 21,
	Peasant = 22,
	CaravanHand = 23,
	CaravanGuard = 24,
	CaravanDonkey = 25,
	Footman = 26,
	Greatsword = 27,
	Billman = 28,
	Arbalester = 29,
	StandardBearer = 30,
	Sergeant = 31,
	Knight = 32,
	MilitaryDonkey = 33,
	BanditThug = 34,
	BanditPoacher = 35,
	BanditMarksman = 36,
	BanditRaider = 37,
	BanditLeader = 38,
	GoblinAmbusher = 39,
	GoblinFighter = 40,
	GoblinLeader = 41,
	GoblinShaman = 42,
	GoblinWolfrider = 43,
	Wolf = 44,
	Wardog = 45,
	ArmoredWardog = 46,
	Mercenary = 47,
	MercenaryRanged = 48,
	Swordmaster = 49,
	HedgeKnight = 50,
	MasterArcher = 51,
	GreenskinCatapult = 52,
	Cultist = 53,
	Direwolf = 54,
	Lindwurm = 55,
	Unhold = 56,
	UnholdFrost = 57,
	UnholdBog = 58,
	Spider = 59,
	SpiderEggs = 60,
	Alp = 61,
	Hexe = 62,
	Schrat = 63,
	SchratSmall = 64,
	Wildman = 65,
	Kraken = 66,
	KrakenTentacle = 67,
	ZombieBetrayer = 68,
	AlpShadow = 69,
	BarbarianThrall = 70,
	BarbarianMarauder = 71,
	BarbarianChampion = 72,
	BarbarianDrummer = 73,
	BarbarianBeastmaster = 74,
	BarbarianUnhold = 75,
	BarbarianUnholdFrost = 76,
	BarbarianChosen = 77,
	Warhound = 78,
	TricksterGod = 79,
	BarbarianMadman = 80,
	Serpent = 81,
	SandGolem = 82,
	Hyena = 83,
	Conscript = 84,
	Gunner = 85,
	Officer = 86,
	Engineer = 87,
	Assassin = 88,
	Slave = 89,
	Gladiator = 90,
	Mortar = 91,
	NomadCutthroat = 92,
	NomadOutlaw = 93,
	NomadSlinger = 94,
	NomadArcher = 95,
	NomadLeader = 96,
	DesertStalker = 97,
	Executioner = 98,
	DesertDevil = 99,
	PeasantSouthern = 100,
	SkeletonLich = 101,
	SkeletonLichMirrorImage = 102,
	SkeletonPhylactery = 103,
	ZombieTreasureHunter = 104,
	FlyingSkull = 105,
	BanditRabble = 106,
	LegendCat = 107,
	LegendOrcElite = 108,
	LegendOrcBehemoth = 109,
	LegendWhiteDirewolf = 110,
	LegendSkinGhoul = 111,
	LegendStollwurm = 112,
	LegendRockUnhold = 113,
	LegendRedbackSpider = 114,
	LegendDemonAlp = 115,
	LegendHexeLeader = 116,
	LegendGreenwoodSchrat = 117,
	LegendGreenwoodSchratSmall = 118,
	LegendWhiteWarwolf = 119,
	LegendBanshee = 120,
	LegendDemonHound = 121,
	LegendVampireLord = 122,
	BanditVeteran = 123,
	BanditWarlord = 124,
	LegendPeasantButcher = 125,
	LegendPeasantBlacksmith = 126,
	LegendPeasantMonk = 127,
	LegendPeasantFarmhand = 128,
	LegendPeasantMinstrel = 129,
	LegendPeasantPoacher = 130,
	LegendPeasantWoodsman = 131,
	LegendPeasantMiner = 132,
	LegendPeasantSquire = 133,
	LegendPeasantWitchHunter = 134,
	LegendHalberdier = 135,
	LegendSlinger = 136,
	LegendFencer = 137,
	BanditOutrider = 138,
	LegendBear = 139,
	LegendCatapult = 140,
    LegendHorse = 141,
	SkeletonGladiator = 142,

	BanditRabblePoacher = 143,
	BanditVermes = 144,

	SatoManhunter = 145,
	SatoManhunterVeteran = 146,

	LegendMummyLight = 147,
	LegendMummyMedium = 148,
	LegendMummyHeavy = 149,
	LegendMummyQueen = 150,
	KoboldFighter = 151,
	KoboldWolfrider = 152,

	function convertOldToNew( _id )
	{
		switch(_id)
		{
		case 4:
			return this.Const.EntityType.SkeletonLight;

		case 5:
			return this.Const.EntityType.SkeletonMedium;

		case 6:
			return this.Const.EntityType.SkeletonHeavy;

		case 7:
			return this.Const.EntityType.SkeletonPriest;

		case 8:
			return this.Const.EntityType.Vampire;

		case 9:
			return this.Const.EntityType.Ghost;

		case 10:
			return this.Const.EntityType.Ghoul;

		case 11:
			return this.Const.EntityType.OrcYoung;

		case 12:
			return this.Const.EntityType.OrcBerserker;

		case 13:
			return this.Const.EntityType.OrcWarrior;

		case 14:
			return this.Const.EntityType.OrcWarlord;

		case 15:
			return this.Const.EntityType.Direwolf;

		case 16:
			return this.Const.EntityType.Militia;

		case 17:
			return this.Const.EntityType.MilitiaRanged;

		case 18:
			return this.Const.EntityType.MilitiaVeteran;

		case 19:
			return this.Const.EntityType.MilitiaCaptain;

		case 20:
			return this.Const.EntityType.BountyHunter;

		case 21:
			return this.Const.EntityType.Peasant;

		case 22:
			return this.Const.EntityType.CaravanHand;

		case 23:
			return this.Const.EntityType.CaravanGuard;

		case 24:
			return this.Const.EntityType.CaravanDonkey;

		case 25:
			return this.Const.EntityType.Footman;

		case 26:
			return this.Const.EntityType.Greatsword;

		case 27:
			return this.Const.EntityType.Billman;

		case 28:
			return this.Const.EntityType.Arbalester;

		case 29:
			return this.Const.EntityType.StandardBearer;

		case 30:
			return this.Const.EntityType.Sergeant;

		case 31:
			return this.Const.EntityType.Knight;

		case 32:
			return this.Const.EntityType.MilitaryDonkey;

		case 33:
			return this.Const.EntityType.BanditThug;

		case 34:
			return this.Const.EntityType.BanditPoacher;

		case 35:
			return this.Const.EntityType.BanditMarksman;

		case 36:
			return this.Const.EntityType.BanditRaider;

		case 37:
			return this.Const.EntityType.BanditLeader;

		case 38:
			return this.Const.EntityType.GoblinAmbusher;

		case 39:
			return this.Const.EntityType.GoblinFighter;

		case 40:
			return this.Const.EntityType.GoblinLeader;

		case 41:
			return this.Const.EntityType.GoblinShaman;

		case 42:
			return this.Const.EntityType.GoblinWolfrider;

		case 43:
			return this.Const.EntityType.Wolf;

		case 44:
			return this.Const.EntityType.Wardog;

		case 45:
			return this.Const.EntityType.ArmoredWardog;

		case 46:
			return this.Const.EntityType.Mercenary;

		case 47:
			return this.Const.EntityType.MercenaryRanged;

		case 48:
			return this.Const.EntityType.Swordmaster;

		case 49:
			return this.Const.EntityType.HedgeKnight;

		case 50:
			return this.Const.EntityType.MasterArcher;

		case 51:
			return this.Const.EntityType.GreenskinCatapult;

		case 52:
			return this.Const.EntityType.Cultist;

		case 53:
			return this.Const.EntityType.Lindwurm;
		}

		return _id;
	}

};
gt.Const.EntityIcon <- [
	"human_01_orientation",
	"zombie_01_orientation",
	"zombie_02_orientation",
	"zombie_03_orientation",
	"zombie_03_orientation",
	"skeleton_01_orientation",
	"skeleton_02_orientation",
	"skeleton_03_orientation",
	"skeleton_04_orientation",
	"skeleton_05_orientation",
	"vampire_01_orientation",
	"ghost_01_orientation",
	"ghoul_01_orientation",
	"orc_04_orientation",
	"orc_03_orientation",
	"orc_02_orientation",
	"orc_01_orientation",
	"militia_orientation",
	"militia_ranged_orientation",
	"militia_veteran_orientation",
	"militia_captain_orientation",
	"bandit_raider_orientation",
	"peasant_orientation",
	"caravan_hand_orientation",
	"caravan_guard_orientation",
	"donkey_orientation",
	"footman_veteran_orientation",
	"greatsword_orientation",
	"billman_orientation",
	"arbalester_orientation",
	"standard_bearer_orientation",
	"sergeant_orientation",
	"knight_orientation",
	"donkey_orientation",
	"bandit_thug_orientation",
	"bandit_poacher_orientation",
	"bandit_marksman_orientation",
	"bandit_raider_orientation",
	"bandit_leader_orientation",
	"goblin_04_orientation",
	"goblin_01_orientation",
	"goblin_03_orientation",
	"goblin_02_orientation",
	"goblin_05_orientation",
	"goblin_06_orientation",
	"dog_01_orientation",
	"dog_01_orientation",
	"mercenary_orientation",
	"mercenary_orientation",
	"swordmaster_orientation",
	"hedge_knight_orientation",
	"mercenary_orientation",
	"catapult_01_orientation",
	"cultist_orientation",
	"direwolf_01_orientation",
	"lindwurm_orientation",
	"unhold_01_orientation",
	"unhold_02_orientation",
	"unhold_03_orientation",
	"spider_01_orientation",
	"spider_02_orientation",
	"alp_01_orientation",
	"hexe_01_orientation",
	"schrat_01_orientation",
	"schrat_02_orientation",
	"wildman_01_orientation",
	"kraken_01_orientation",
	"kraken_02_orientation",
	"zombie_03_orientation",
	"alp_02_orientation",
	"wildman_01_orientation",
	"wildman_02_orientation",
	"wildman_03_orientation",
	"wildman_05_orientation",
	"wildman_04_orientation",
	"unhold_01_orientation",
	"unhold_02_orientation",
	"wildman_06_orientation",
	"dog_02_orientation",
	"thing_orientation",
	"wildman_06_orientation",
	"serpent_orientation",
	"sand_golem_orientation",
	"hyena_orientation",
	"conscript_orientation",
	"gunner_orientation",
	"officer_orientation",
	"orientation_engineer",
	"assassin_orientation",
	"slave_orientation",
	"gladiator_orientation",
	"mortar_orientation",
	"nomad_01_orientation",
	"nomad_02_orientation",
	"nomad_03_orientation",
	"nomad_04_orientation",
	"nomad_05_orientation",
	"desert_stalker_orientation",
	"executioner_orientation",
	"desert_devil_orientation",
	"peasant_orientation",
	"skeleton_06_orientation",
	"skeleton_07_orientation",
	"phylactery_orientation",
	"zombie_04_orientation",
	"skeleton_08_orientation",

	"rabble_orientation",
	"cat_orientation",
	"orc_elite_orientation",
	"orc_behemoth_orientation",
	"white_direwolf_orientation",
	"skin_ghoul_orientation",
	"stollwurm_orientation",
	"rock_unhold_orientation",
	"redback_spider_orientation",
	"demonalp_orientation",
	"hexen_leader_orientation",
	"greenwood_schrat_orientation",
	"greenwood_schrat_small_orientation",
	"white_direwolf_orientation",
	"banshee_orientation_2",
	"hollenhound_orientation",
	"vampire_lord_orientation",
	"banditveteran_orientation",
	"banditwarlord_orientation",
	"butcher_orientation",
	"blacksmith_orientation",
	"monk_orientation",
	"farmhand_orientation",
	"minstrel_orientation",
	"poacher_orientation",
	"woodcutter_orientation",
	"miner_orientation",
	"squire_orientation",
	"witchhunter_orientation",
	"halberdier_orientation",
	"slinger_orientation",
	"fencer_orientation",
	"banditoutrider_orientation",
	"bear_orientation",
	"catapult_01_orientation",
	"horse_orientation",
	"gladiator_orientation",

	"rabble_poacher_orientation",
	"bandit_raider_orientation",

	"poacher_orientation",
	"officer_orientation",

	"mummy_light_orientation",
	"mummy_medium_orientation",
	"mummy_heavy_orientation",
	"mummy_queen_orientation",
	"kobold_fighter_orientation",
	"kobold_wolfrider_orientation"
];

