local gt = this.getroottable();
gt.Const.Sound <- {
	Channel = {
		Master = -1,
		Music = 0,
		Effects = 1,
		Ambience = 2
	},
	ActorEvent = {
		DamageReceived = 0,
		NoDamageReceived = 1,
		Death = 2,
		Resurrect = 3,
		Flee = 4,
		Idle = 5,
		Attack = 6,
		Move = 7,
		Fatigue = 8,
		Other1 = 9,
		Other2 = 10,
		COUNT = 11
	},
	ChannelName = [
		"Music",
		"Effects",
		"Ambience"
	],
	Volume = {
		Skill = 1.0,
		Actor = 1.0,
		ActorIdle = 1.0,
		ActorArmorHit = 1.0,
		ActorNoDamage = 0.349999994,
		TacticalMovement = 0.75,
		Tactical = 1.0,
		Inventory = 0.699999988,
		RacialEffect = 0.75,
		Ambience = 0.5,
		AmbienceTerrain = 0.800000012,
		AmbienceOutsideSettlement = 0.400000006,
		AmbienceInSettlement = 1.29999995,
		AmbienceTerrainInSettlement = 0.400000006,
		AmbienceInTactical = 0.400000006,
		AmbienceInBuilding = 0.5
	},
	DefaultWeaponEquip = [
		"sounds/combat/riposte_01.wav",
		"sounds/combat/riposte_02.wav",
		"sounds/combat/riposte_03.wav"
	],
	ClothEquip = [
		"sounds/cloth_01.wav"
	],
	ArmorLeatherImpact = [
		"sounds/combat/armor_leather_impact_01.wav",
		"sounds/combat/armor_leather_impact_02.wav",
		"sounds/combat/armor_leather_impact_03.wav"
	],
	ArmorChainmailImpact = [
		"sounds/combat/armor_chainmail_impact_01.wav",
		"sounds/combat/armor_chainmail_impact_02.wav",
		"sounds/combat/armor_chainmail_impact_03.wav"
	],
	ArmorHalfplateImpact = [
		"sounds/combat/armor_halfplate_impact_01.wav",
		"sounds/combat/armor_halfplate_impact_02.wav",
		"sounds/combat/armor_halfplate_impact_03.wav"
	],
	JesterImpact = [
		"sounds/jester_01.wav"
	],
	ShieldDestroyed = [
		"sounds/combat/shield_broken_01.wav"
	],
	ShieldHitWood = [
		"sounds/combat/shield_hit_wood_01.wav",
		"sounds/combat/shield_hit_wood_02.wav",
		"sounds/combat/shield_hit_wood_03.wav"
	],
	ShieldHitMetal = [
		"sounds/combat/shield_hit_metal_01.wav",
		"sounds/combat/shield_hit_metal_02.wav",
		"sounds/combat/shield_hit_metal_03.wav"
	],
	NewRound = [
		"sounds/new_round_01.wav",
		"sounds/new_round_02.wav",
		"sounds/new_round_03.wav"
	],
	MoneyTransaction = [
		"sounds/coins_01.wav",
		"sounds/coins_02.wav",
		"sounds/coins_03.wav"
	],
	FastTravelByShip = [
		"sounds/fast_travel_boat_01.wav"
	],
	Barber = [
		"sounds/barber_01.wav"
	],
	CraftingGeneral = [
		"sounds/crafting/crafting_general_01.wav",
		"sounds/crafting/crafting_general_02.wav",
		"sounds/crafting/crafting_general_03.wav"
	],
	CraftingPotion = [
		"sounds/crafting/crafting_potion_01.wav",
		"sounds/crafting/crafting_potion_02.wav",
		"sounds/crafting/crafting_potion_03.wav",
		"sounds/crafting/crafting_potion_04.wav"
	],
	TavernRound = [
		"sounds/tavern_round_01.wav"
	],
	TavernRumor = [
		"sounds/tavern_rumor_01.wav"
	],
	DiceThrow = [
		"sounds/dice_01.wav",
		"sounds/dice_02.wav",
		"sounds/dice_03.wav"
	],
	EnemyDiscoveredOnWorldmap = [
		"sounds/enemy_sighted_02.wav",
		"sounds/enemy_sighted_03.wav"
	],
	CrossFadeTime = 4000,
	DefaultOnDeathSound = "sounds/body_fall_01.wav",
	OnEnemyDiscovered = "",
	IdleSoundBaseDelay = 60.0,
	IdleSoundReducedDelay = 5.0,
	IdleSoundMinDelay = 5.0,
	AmbienceMinDelay = 2500,
	AmbienceMinDelayAtNight = 7000,
	AmbienceOutsideDelay = 5000
};
gt.Const.Music <- {
	CrossFadeTime = 4000,
	MenuTracks = [
		"music/title.ogg"
	],
	CreditsTracks = [
		"music/credits.ogg"
	],
	Retirement1Tracks = [
		"music/retirement_01.ogg"
	],
	Retirement2Tracks = [
		"music/retirement_02.ogg"
	],
	Retirement3Tracks = [
		"music/retirement_03.ogg"
	],
	Retirement4Tracks = [
		"music/credits.ogg"
	],
	IntroTracks = [
		"music/worldmap_02.ogg"
	],
	WorldmapTracks = [
		"music/worldmap_03.ogg",
		"music/worldmap_04.ogg",
		"music/worldmap_05.ogg",
		"music/worldmap_06.ogg",
		"music/worldmap_07.ogg",
		"music/worldmap_08.ogg",
		"music/worldmap_09.ogg",
		"music/worldmap_11.ogg",
		"music/worldmap_12.ogg"
	],
	WorldmapTracksGreaterEvil = [
		"music/worldmap_03.ogg",
		"music/worldmap_04.ogg",
		"music/worldmap_05.ogg",
		"music/worldmap_06.ogg",
		"music/worldmap_07.ogg",
		"music/worldmap_08.ogg",
		"music/worldmap_09.ogg"
	],
	VillageTracks = [
		"music/village_01.ogg",
		"music/village_02.ogg",
		"music/village_03.ogg",
		"music/retirement_01.ogg"
	],
	CityTracks = [
		"music/city_01.ogg",
		"music/city_02.ogg",
		"music/city_03.ogg",
	],
	StrongholdTracks = [
		"music/stronghold_01.ogg"
	],
	VictoryTracks = [
		"music/victory_01.ogg"
	],
	DefeatTracks = [
		"music/defeat_01.ogg"
	],
	BanditTracks = [
		"music/bandits_01.ogg",
		"music/bandits_02.ogg"
	],
	NobleTracks = [
		"music/noble_01.ogg",
		"music/noble_02.ogg"
	],
	CivilianTracks = [
		"music/civilians_01.ogg",
		"music/civilians_02.ogg"
	],
	UndeadTracks = [
		"music/undead_01.ogg",
		"music/undead_02.ogg",
		"music/undead_03.ogg",
		"music/undead_04.ogg",
		"music/undead_05.ogg"
	],
	BeastsTracks = [
		"music/beasts_01.ogg",
		"music/beasts_02.ogg",
		"music/beasts_03.ogg"
	],
	OrcsTracks = [
		"music/orcs_01.ogg",
		"music/orcs_02.ogg",
		"music/orcs_03.ogg",
		"music/orcs_04.ogg",
		"music/orcs_05.ogg"
	],
	GoblinsTracks = [
		"music/goblins_01.ogg",
		"music/goblins_02.ogg"
	],
	BattleTracks = [
		[],
		[],
		[],
		[],
		[
			"music/civilians_01.ogg"
		],
		[
			"music/noble_01.ogg",
			"music/noble_02.ogg"
		],
		[
			"music/bandits_01.ogg",
			"music/bandits_02.ogg"
		],
		[
			"music/beasts_01.ogg",
			"music/beasts_02.ogg"
		],
		[
			"music/undead_01.ogg",
			"music/undead_02.ogg",
			"music/undead_03.ogg",
			"music/undead_04.ogg",
			"music/undead_05.ogg"
		],
		[
			"music/undead_01.ogg",
			"music/undead_02.ogg"
		],
		[
			"music/orcs_01.ogg",
			"music/orcs_02.ogg",
			"music/orcs_03.ogg"
		],
		[
			"music/goblins_01.ogg",
			"music/goblins_02.ogg"
		]
	]
};
gt.Const.SoundAmbience <- {
	Rain = [
		{
			File = "atmosphere/rain_01.wav",
			Volume = 3.0,
			Pitch = 1.0,
			Pan = false,
			RandomVolume = false
		}
	],
	RainLight = [
		{
			File = "atmosphere/rain_02.wav",
			Volume = 3.0,
			Pitch = 1.0,
			Pan = false,
			RandomVolume = false
		}
	],
	Blizzard = [
		{
			File = "atmosphere/blizzard_01.wav",
			Volume = 1.60000002,
			Pitch = 1.0,
			Pan = false,
			RandomVolume = false
		}
	],
	GeneralSettlement = [
		{
			File = "ambience/settlement/settlement_carts_people_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/temple_wounded_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/temple_wounded_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/temple_wounded_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/blacksmith_hammering_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/blacksmith_hammering_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_08.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_09.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_10.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_11.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_12.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_saw_00.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_saw_01.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_saw_02.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/goat_pens_02.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_sweeping_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_sweeping_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_sweeping_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_rooster_00.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_rooster_01.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_rooster_02.wav",
			Volume = 0.75,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_geese_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_geese_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_geese_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_people_whistle_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_people_whistle_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_people_whistle_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_people_whistle_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_19.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_20.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_21.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_22.wav",
			Volume = 1.0,
			Pitch = 1.0
		}
	],
	GeneralSettlementAtNight = [
		{
			File = "ambience/settlement/settlement_dog_00.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_01.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_02.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_03.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_dog_04.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_00.wav",
			Volume = 0.400000006,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_01.wav",
			Volume = 0.400000006,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_02.wav",
			Volume = 0.400000006,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_03.wav",
			Volume = 0.400000006,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_cat_04.wav",
			Volume = 0.400000006,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/temple_wounded_01.wav",
			Volume = 0.5,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/temple_wounded_02.wav",
			Volume = 0.5,
			Pitch = 1.0
		}
	],
	LargeSettlement = [
		{
			File = "ambience/settlement/market_people_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_08.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_09.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_10.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_11.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_12.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_13.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_14.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_15.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_16.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_17.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_18.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_08.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_09.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_10.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_11.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_12.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_wagon_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_cart_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_cart_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/market_cart_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_neighing_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_19.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_20.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_21.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_22.wav",
			Volume = 1.0,
			Pitch = 1.0
		}
	],
	VeryLargeSettlement = [
		{
			File = "ambience/settlement/market_people_00.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_01.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_02.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_03.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_04.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_05.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_06.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_07.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_08.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_09.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_10.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_11.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_12.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_13.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_14.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_15.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_16.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_17.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_18.wav",
			Volume = 1.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_08.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_09.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_10.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_11.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_people_12.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_stone_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_stone_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_stone_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/buildings/caravan_horse_hooves_stone_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_carts_people_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_19.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_20.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_21.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/market_people_22.wav",
			Volume = 1.0,
			Pitch = 1.0
		}
	],
	CivilianSettlement = [
		{
			File = "ambience/settlement/settlement_children_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_06.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/settlement_children_07.wav",
			Volume = 1.0,
			Pitch = 1.0
		}
	],
	GeneralMilitary = [
		{
			File = "ambience/settlement/fortification_marching_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_marching_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_marching_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_marching_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_yelling_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_yelling_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_yelling_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_yelling_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_00.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_01.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_02.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_03.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_04.wav",
			Volume = 1.0,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_armor_weapons_05.wav",
			Volume = 1.0,
			Pitch = 1.0
		}
	],
	GeneralMilitaryAtNight = [
		{
			File = "ambience/settlement/fortification_yelling_02.wav",
			Volume = 0.25,
			Pitch = 1.0
		},
		{
			File = "ambience/settlement/fortification_yelling_03.wav",
			Volume = 0.25,
			Pitch = 1.0
		}
	],
	Terrain = [
		[],
		[
			{
				File = "ambience/terrain/coast_seagull_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_03.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_04.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_05.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_06.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			}
		],
		[
			{
				File = "ambience/terrain/grasslands_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_03.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_04.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_05.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_06.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_07.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_08.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_09.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_10.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_11.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_12.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_13.wav",
				Volume = 0.75,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_13.wav",
				Volume = 0.75,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_14.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_15.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_16.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_17.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_18.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/swamp_frog_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_frog_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_frog_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_frog_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_insect_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/forest_bird_02.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_05.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_08.wav",
				Volume = 0.75,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_13.wav",
				Volume = 0.75,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_03.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_04.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_05.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_06.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/grasslands_bird_07.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_00.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/forest_woodpecker_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_03.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_04.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_05.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_06.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_07.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_08.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_bird_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_bird_08.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_bird_13.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/hill_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/forest_woodpecker_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_03.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_05.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_06.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_07.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_08.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/forest_woodpecker_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_woodpecker_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_03.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_05.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_06.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_07.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/forest_bird_08.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/mountain_rocks_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_eagle_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/mountain_eagle_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/mountain_eagle_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/mountain_eagle_03.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_00.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[],
		[],
		[
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			}
		],
		[],
		[
			{
				File = "ambience/terrain/tundra_buzzard_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_10.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_11.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_12.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_buzzard_12.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_04.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_05.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_06.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_07.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_08.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/hill_bird_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/hill_bird_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/grasslands_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_insect_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_bird_00.wav",
				Volume = 0.899999976,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_01.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_02.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_03.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_04.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_05.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_06.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_07.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_08.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_09.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			},
			{
				File = "ambience/terrain/steppe_bird_10.wav",
				Volume = 0.699999988,
				Pitch = 1.0,
				RandomPitch = true
			}
		],
		[
			{
				File = "ambience/terrain/coast_seagull_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			}
		]
	],
	TerrainAtNight = [
		[],
		[
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			}
		],
		[
			{
				File = "ambience/terrain/grasslands_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_frog_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_frog_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_frog_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/swamp_mud_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/forest_leaves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_leaves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/forest_branch_crack_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_owl_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/mountain_rocks_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_07.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_08.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_rocks_09.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/mountain_wind_06.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[],
		[
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_00.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_wind_01.wav",
				Volume = 1.10000002,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/snow_snow_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			}
		],
		[],
		[
			{
				File = "ambience/terrain/dark_forest_wolf_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/dark_forest_wolf_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_00.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_01.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_02.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_03.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_04.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_05.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_06.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_07.wav",
				Volume = 0.75,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/tundra_wind_08.wav",
				Volume = 0.75,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/grasslands_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/grasslands_rustle_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_rustle_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/nighttime_cricket_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_coyote_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_coyote_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_coyote_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/steppe_coyote_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		],
		[
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			},
			{
				File = "ambience/terrain/coast_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0,
				Pan = false
			}
		]
	]
};
gt.Const.SoundPartyAmbience <- [
	[],
	[
		"sounds/enemies/orc_idle_01.wav",
		"sounds/enemies/orc_idle_02.wav",
		"sounds/enemies/orc_idle_03.wav",
		"sounds/enemies/orc_idle_04.wav",
		"sounds/enemies/orc_idle_05.wav",
		"sounds/enemies/orc_idle_06.wav",
		"sounds/enemies/orc_idle_07.wav",
		"sounds/enemies/orc_idle_08.wav",
		"sounds/enemies/orc_idle_09.wav",
		"sounds/enemies/orc_idle_10.wav",
		"sounds/enemies/orc_idle_11.wav",
		"sounds/enemies/orc_idle_12.wav",
		"sounds/enemies/orc_idle_13.wav",
		"sounds/enemies/orc_idle_14.wav",
		"sounds/enemies/orc_idle_15.wav",
		"sounds/enemies/orc_idle_16.wav",
		"sounds/enemies/orc_idle_17.wav",
		"sounds/enemies/orc_idle_18.wav",
		"sounds/enemies/orc_idle_19.wav",
		"sounds/enemies/orc_idle_20.wav",
		"sounds/enemies/orc_idle_21.wav",
		"sounds/enemies/orc_idle_22.wav",
		"sounds/enemies/orc_idle_23.wav",
		"sounds/enemies/orc_idle_24.wav",
		"sounds/enemies/orc_idle_25.wav",
		"sounds/enemies/orc_idle_26.wav",
		"sounds/enemies/orc_idle_27.wav",
		"sounds/enemies/orc_idle_28.wav",
		"sounds/enemies/orc_idle_29.wav",
		"sounds/enemies/orc_fatigue_01.wav",
		"sounds/enemies/orc_fatigue_02.wav",
		"sounds/enemies/orc_fatigue_03.wav"
	],
	[
		"sounds/enemies/goblin_idle_00.wav",
		"sounds/enemies/goblin_idle_01.wav",
		"sounds/enemies/goblin_idle_02.wav",
		"sounds/enemies/goblin_idle_03.wav",
		"sounds/enemies/goblin_idle_04.wav",
		"sounds/enemies/goblin_idle_05.wav",
		"sounds/enemies/goblin_idle_06.wav",
		"sounds/enemies/goblin_idle_07.wav",
		"sounds/enemies/goblin_idle_08.wav",
		"sounds/enemies/goblin_idle_09.wav",
		"sounds/enemies/goblin_idle_10.wav",
		"sounds/enemies/goblin_idle_11.wav",
		"sounds/enemies/goblin_idle_12.wav",
		"sounds/enemies/goblin_idle_13.wav",
		"sounds/enemies/goblin_idle_14.wav"
	],
	[
		"sounds/enemies/skeleton_idle_01.wav",
		"sounds/enemies/skeleton_idle_02.wav",
		"sounds/enemies/skeleton_idle_03.wav",
		"sounds/enemies/skeleton_idle_04.wav",
		"sounds/enemies/skeleton_idle_05.wav",
		"sounds/enemies/skeleton_idle_06.wav"
	],
	[
		"sounds/enemies/zombie_idle_01.wav",
		"sounds/enemies/zombie_idle_02.wav",
		"sounds/enemies/zombie_idle_03.wav",
		"sounds/enemies/zombie_idle_04.wav",
		"sounds/enemies/zombie_idle_05.wav",
		"sounds/enemies/zombie_idle_06.wav",
		"sounds/enemies/zombie_idle_07.wav",
		"sounds/enemies/zombie_idle_08.wav",
		"sounds/enemies/zombie_idle_09.wav",
		"sounds/enemies/zombie_idle_10.wav",
		"sounds/enemies/zombie_idle_11.wav",
		"sounds/enemies/zombie_idle_12.wav",
		"sounds/enemies/zombie_idle_13.wav",
		"sounds/enemies/zombie_idle_14.wav",
		"sounds/enemies/zombie_idle_15.wav",
		"sounds/enemies/zombie_idle_16.wav"
	],
	[
		"sounds/enemies/werewolf_idle_01.wav",
		"sounds/enemies/werewolf_idle_02.wav",
		"sounds/enemies/werewolf_idle_03.wav",
		"sounds/enemies/werewolf_idle_04.wav",
		"sounds/enemies/werewolf_idle_05.wav",
		"sounds/enemies/werewolf_idle_06.wav",
		"sounds/enemies/werewolf_idle_07.wav",
		"sounds/enemies/werewolf_idle_08.wav",
		"sounds/enemies/werewolf_idle_09.wav",
		"sounds/enemies/werewolf_idle_10.wav",
		"sounds/enemies/werewolf_idle_11.wav",
		"sounds/enemies/werewolf_idle_12.wav",
		"sounds/enemies/werewolf_idle_13.wav",
		"sounds/enemies/werewolf_idle_14.wav",
		"sounds/enemies/werewolf_idle_15.wav",
		"sounds/enemies/werewolf_idle_16.wav",
		"sounds/enemies/werewolf_idle_17.wav",
		"sounds/enemies/werewolf_idle_18.wav",
		"sounds/enemies/werewolf_idle_19.wav",
		"sounds/enemies/werewolf_idle_20.wav",
		"sounds/enemies/werewolf_idle_21.wav"
	],
	[
		"sounds/enemies/ghoul_idle_01.wav",
		"sounds/enemies/ghoul_idle_02.wav",
		"sounds/enemies/ghoul_idle_03.wav",
		"sounds/enemies/ghoul_idle_04.wav",
		"sounds/enemies/ghoul_idle_05.wav",
		"sounds/enemies/ghoul_idle_06.wav",
		"sounds/enemies/ghoul_idle_07.wav",
		"sounds/enemies/ghoul_idle_08.wav",
		"sounds/enemies/ghoul_idle_09.wav",
		"sounds/enemies/ghoul_idle_10.wav",
		"sounds/enemies/ghoul_idle_11.wav",
		"sounds/enemies/ghoul_idle_12.wav",
		"sounds/enemies/ghoul_idle_13.wav",
		"sounds/enemies/ghoul_idle_14.wav",
		"sounds/enemies/ghoul_idle_15.wav",
		"sounds/enemies/ghoul_idle_16.wav",
		"sounds/enemies/ghoul_idle_17.wav",
		"sounds/enemies/ghoul_idle_18.wav",
		"sounds/enemies/ghoul_idle_19.wav",
		"sounds/enemies/ghoul_idle_20.wav",
		"sounds/enemies/ghoul_idle_21.wav",
		"sounds/enemies/ghoul_idle_22.wav",
		"sounds/enemies/ghoul_idle_23.wav",
		"sounds/enemies/ghoul_idle_24.wav",
		"sounds/enemies/ghoul_idle_25.wav",
		"sounds/enemies/ghoul_idle_26.wav",
		"sounds/enemies/ghoul_idle_27.wav"
	],
	[
		"sounds/enemies/unhold_idle_01.wav",
		"sounds/enemies/unhold_idle_02.wav",
		"sounds/enemies/unhold_idle_03.wav",
		"sounds/enemies/unhold_idle_04.wav",
		"sounds/enemies/unhold_idle_05.wav",
		"sounds/enemies/unhold_idle_06.wav",
		"sounds/enemies/unhold_idle_07.wav"
	],
	[
		"sounds/enemies/giant_spider_idle_01.wav",
		"sounds/enemies/giant_spider_idle_02.wav",
		"sounds/enemies/giant_spider_idle_03.wav",
		"sounds/enemies/giant_spider_idle_04.wav",
		"sounds/enemies/giant_spider_idle_05.wav",
		"sounds/enemies/giant_spider_idle_06.wav",
		"sounds/enemies/giant_spider_idle_07.wav",
		"sounds/enemies/giant_spider_idle_08.wav",
		"sounds/enemies/giant_spider_idle_09.wav",
		"sounds/enemies/giant_spider_idle_10.wav",
		"sounds/enemies/giant_spider_idle_11.wav",
		"sounds/enemies/giant_spider_idle_12.wav",
		"sounds/enemies/giant_spider_idle_13.wav",
		"sounds/enemies/giant_spider_idle_14.wav",
		"sounds/enemies/giant_spider_idle_15.wav",
		"sounds/enemies/giant_spider_idle_16.wav"
	],
	[
		"sounds/enemies/schrat_idle_01.wav",
		"sounds/enemies/schrat_idle_02.wav",
		"sounds/enemies/schrat_idle_03.wav",
		"sounds/enemies/schrat_idle_04.wav",
		"sounds/enemies/schrat_idle_05.wav",
		"sounds/enemies/schrat_idle_06.wav",
		"sounds/enemies/schrat_idle_07.wav",
		"sounds/enemies/schrat_idle_08.wav",
		"sounds/enemies/schrat_idle_09.wav",
		"sounds/ambience/terrain/forest_branch_crack_00.wav",
		"sounds/ambience/terrain/forest_branch_crack_01.wav",
		"sounds/ambience/terrain/forest_branch_crack_02.wav",
		"sounds/ambience/terrain/forest_branch_crack_03.wav",
		"sounds/ambience/terrain/forest_branch_crack_04.wav",
		"sounds/ambience/terrain/forest_branch_crack_05.wav"
	],
	[
		"sounds/enemies/lindwurm_idle_01.wav",
		"sounds/enemies/lindwurm_idle_02.wav",
		"sounds/enemies/lindwurm_idle_03.wav",
		"sounds/enemies/lindwurm_idle_04.wav",
		"sounds/enemies/lindwurm_idle_05.wav",
		"sounds/enemies/lindwurm_idle_06.wav",
		"sounds/enemies/lindwurm_idle_07.wav",
		"sounds/enemies/lindwurm_idle_08.wav",
		"sounds/enemies/lindwurm_idle_09.wav",
		"sounds/enemies/lindwurm_idle_10.wav",
		"sounds/enemies/lindwurm_idle_11.wav"
	]
];
