local gt = this.getroottable();

if (!("Items" in gt.Const))
{
	gt.Const.Items <- {};
}

gt.Const.Items.Default <- {
	PlayerQuiver = "bust_quiver_01",
	PlayerNakedBody = "bust_naked_body_01",
	PlayerCorpse = "bust_naked_body_01_dead",
	ShieldDecal = "broken_shield_01",
	GenericItemName = "Generic Item",
	GenericItemIcon = "skills/passive_03.png",
	RaiseShieldOffset = this.createVec(0, 10),
	RaiseShieldDuration = 0.15,
	LowerShieldDuration = 0.4,
	RaiseWeaponDuration = 0.25,
	LowerWeaponDuration = 0.2
};
gt.Const.Items.ItemType <- {
	None = 0,
	Legendary = 1,
	Named = 2,
	Armor = 4,
	Helmet = 8,
	Shield = 16,
	Defensive = 32,
	Weapon = 64,
	OneHanded = 128,
	TwoHanded = 256,
	MeleeWeapon = 512,
	RangedWeapon = 1024,
	Ammo = 2048,
	Tool = 4096,
	Accessory = 8192,
	Usable = 16384,
	Misc = 32768,
	Loot = 65536,
	Crafting = 131072,
	Supply = 262144,
	Food = 524288,
	TradeGood = 1048576,
	MagicStaff = 2097152,
	HorseArmor = 4194304,
	HorseHelmet = 8388608
};
gt.Const.Items.ItemFilter <- {
	Weapons = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.Accessory | this.Const.Items.ItemType.Tool | this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.MagicStaff,
	Armor = this.Const.Items.ItemType.Armor | this.Const.Items.ItemType.Helmet | this.Const.Items.ItemType.Shield,
	Misc = this.Const.Items.ItemType.Supply | this.Const.Items.ItemType.Food | this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.TradeGood | this.Const.Items.ItemType.Loot | this.Const.Items.ItemType.Crafting,
	Usable = this.Const.Items.ItemType.Usable,
	HorseArmor = this.Const.Items.ItemType.HorseArmor,
	All = 1 | 2 | 4 | 8 | 16 | 32 | 64 | 128 | 256 | 512 | 1024 | 2048 | 4096 | 8192 | 16384 | 32768 | 65536 | 131072 | 262144 | 524288 | 1048576 | 2097152
};
gt.Const.Items.AmmoType <- {
	None = 0,
	Arrows = 1,
	Bolts = 2,
	Spears = 4,
	Powder = 8,
	Pebbles = 16,
	Rocks = 32,
	Darts = 64
};
gt.Const.Items.Property <- {
	None = 0,
	IgnoresShieldwall = 8
};
gt.Const.Items.InventoryEventType <- {
	None = 0,
	Equipped = 1,
	PlacedInBag = 2,
	PlacedInStash = 3,
	PlacedOnGround = 4
};
gt.Const.Items.Paint <- {
	None = 0,
	Black = 1,
	WhiteBlue = 2,
	WhiteGreenYellow = 3,
	OrangeRed = 4,
	Red = 5
};
gt.Const.Items.ConditionColor <- [
	"#ff1e00",
	"#ff8400",
	"#ffea00",
	"#c0ff00",
	"#ffffff"
];
gt.Const.Items.NamedArmors <- [
	"armor/named/black_leather_armor",
	"armor/named/blue_studded_mail_armor",
	"armor/named/brown_coat_of_plates_armor",
	"armor/named/golden_scale_armor",
	"armor/named/green_coat_of_plates_armor",
	"armor/named/heraldic_mail_armor",
	"armor/named/named_sellswords_armor"
];

gt.Const.Items.LegendNamedClothLayers <- [
	"legend_armor/cloth/legend_gambeson_named",
	"legend_armor/cloth/legend_tunic_noble_named"
];

gt.Const.Items.LegendNamedChainLayers <- [
	"legend_armor/chain/legend_armor_hauberk_full_named",
];

gt.Const.Items.LegendNamedPlateLayers <- [
	"legend_armor/plate/legend_armor_plate_full_greaves_painted",
	"legend_armor/plate/legend_armor_plate_full_greaves_named",
	"legend_armor/plate/legend_armor_leather_jacket_named",
	"legend_armor/plate/legend_armor_leather_studded_jacket_named",
	"legend_armor/plate/legend_armor_leather_lamellar_heavy_named",
	"legend_armor/plate/legend_armor_leather_brigandine_named",
	"legend_armor/plate/legend_armor_scale_coat_named",
	"legend_armor/plate/legend_southern_named_golden_plates",
	"legend_armor/plate/legend_southern_named_plates"
];

gt.Const.Items.LegendNamedTabardLayers <- [
	"legend_armor/named/legend_armor_named_tabard",
];

gt.Const.Items.LegendNamedCloakLayers <- [
	"legend_armor/named/legend_armor_cloak_rich",
	"legend_armor/named/legend_armor_cloak_emperors"
];

gt.Const.Items.LegendNamedSouthernArmorLayers <- [
	"legend_armor/plate/legend_southern_named_golden_plates",
	"legend_armor/plate/legend_southern_named_plates"
]


gt.Const.Items.LegendNamedHoodLayers <- [
];

gt.Const.Items.LegendNamedHelmLayers <- [
	"legend_helmets/helm/legend_helmet_italo_norman_helm_named",
	"legend_helmets/helm/legend_helmet_barbute_named",
	"legend_helmets/helm/legend_helmet_bascinet_named",
	"legend_helmets/helm/legend_helmet_kettle_helm_named",
	"legend_helmets/helm/legend_helmet_wallace_sallet_named",
	"legend_helmets/helm/legend_helmet_deep_sallet_named",
];

gt.Const.Items.LegendNamedTopLayers <- [
	"legend_helmets/top/legend_helmet_bascinet_visor_named",
	"legend_helmets/top/legend_helmet_wallace_sallet_visor_named"
];

gt.Const.Items.LegendNamedVanityLayers <- [
]


gt.Const.Items.LegendNamedArmorLayers <- []
gt.Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedClothLayers)
gt.Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedChainLayers)
gt.Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedPlateLayers)
gt.Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedTabardLayers)
gt.Const.Items.LegendNamedArmorLayers.extend(this.Const.Items.LegendNamedCloakLayers)


gt.Const.Items.LegendNamedHelmetLayers <- []
gt.Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedHoodLayers)
gt.Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedHelmLayers)
gt.Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedTopLayers)
gt.Const.Items.LegendNamedHelmetLayers.extend(this.Const.Items.LegendNamedVanityLayers)

gt.Const.Items.NamedHelmets <- [
	// "helmets/named/golden_feathers_helmet",
	"helmets/named/heraldic_mail_helmet",
	"helmets/named/nasal_feather_helmet",
	"helmets/named/sallet_green_helmet",
	"helmets/named/wolf_helmet",
	"helmets/named/legend_frogmouth_helm_crested_painted",
	"helmets/named/legend_frogmouth_helm_decorated",
	"helmets/named/wallace_sallet_named",
	"helmets/named/barbute_named",
	"helmets/named/bascinet_named",
	"helmets/named/kettle_helm_named",
	"helmets/named/italo_norman_helm_named"
];


gt.Const.Items.NamedShields <- [
	"shields/named/named_dragon_shield",
	"shields/named/named_full_metal_heater_shield",
	"shields/named/named_golden_round_shield",
	"shields/named/named_red_white_shield",
	"shields/named/named_rider_on_horse_shield",
	"shields/named/named_wing_shield"
];
gt.Const.Items.NamedBanditShields <- [
	"shields/named/named_bandit_kite_shield",
	"shields/named/named_bandit_heater_shield",
	"weapons/named/legend_named_parrying_dagger"
];
gt.Const.Items.NamedUndeadShields <- [
	"shields/named/named_undead_heater_shield",
	"shields/named/named_undead_kite_shield"
];
gt.Const.Items.NamedOrcShields <- [
	"shields/named/named_orc_heavy_shield"
];
gt.Const.Items.NamedSouthernShields <- [];
gt.Const.Items.NamedOrcWeapons <- [
	"weapons/named/named_orc_axe",
	"weapons/named/named_orc_axe_2h",
	"weapons/named/named_orc_flail_2h",
	"weapons/named/named_orc_cleaver"
];
gt.Const.Items.NamedGoblinWeapons <- [
	"weapons/named/named_goblin_falchion",
	"weapons/named/named_goblin_heavy_bow",
	"weapons/named/named_goblin_pike",
	"weapons/named/named_goblin_spear"
];
gt.Const.Items.NamedMeleeWeapons <- [
	"weapons/named/named_axe",
	"weapons/named/named_billhook",
	"weapons/named/named_cleaver",
	"weapons/named/named_dagger",
	"weapons/named/named_flail",
	"weapons/named/named_greataxe",
	"weapons/named/named_greatsword",
	"weapons/named/named_longaxe",
	"weapons/named/named_mace",
	"weapons/named/named_spear",
	"weapons/named/named_sword",
	"weapons/named/named_longsword",
	"weapons/named/named_two_handed_hammer",
	"weapons/named/named_warbrand",
	"weapons/named/named_warhammer",
	"weapons/named/named_pike",
	"weapons/named/named_fencing_sword",
	"weapons/named/legend_named_bastardsword",
	"weapons/named/legend_named_estoc",
	"weapons/named/legend_named_glaive",
	"weapons/named/legend_named_swordstaff",
	"weapons/named/legend_named_halberd",
	"weapons/named/legend_named_voulge",
	"weapons/named/legend_named_blacksmith_hammer",
	"weapons/named/legend_named_sickle",
	"weapons/named/legend_named_shovel",
	"weapons/named/legend_named_flail",
	"weapons/named/legend_named_infantry_axe",
	"weapons/named/legend_named_warhammer",
	"weapons/named/legend_named_gladius",
	"weapons/named/legend_named_military_goedendag"
];
gt.Const.Items.NamedRangedWeapons <- [
	"weapons/named/named_crossbow",
	"weapons/named/named_javelin",
	"weapons/named/named_throwing_axe",
	"weapons/named/named_warbow"
];
gt.Const.Items.NamedWeapons <- clone this.Const.Items.NamedMeleeWeapons;
gt.Const.Items.NamedWeapons.extend(this.Const.Items.NamedRangedWeapons);
gt.Const.Items.NamedBarbarianWeapons <- [];
gt.Const.Items.NamedBarbarianHelmets <- [];
gt.Const.Items.NamedBarbarianArmors <- [];
gt.Const.Items.NamedSouthernWeapons <- [
	"weapons/named/named_heavy_southern_mace"
];
gt.Const.Items.NamedSouthernMeleeWeapons <- [];
gt.Const.Items.NamedSouthernHelmets <- [];
gt.Const.Items.NamedSouthernArmors <- [];
gt.Const.Items.NamedUndeadWeapons <- [
	"weapons/named/named_bladed_pike",
	"weapons/named/named_crypt_cleaver",
	"weapons/named/named_warscythe",
	"weapons/named/named_khopesh",
	"weapons/named/named_legend_great_khopesh"
];
gt.Const.Items.ArmorUpgrades <- {
	Chain = 0,
	Plate = 1,
	Tabbard = 2,
	Cloak = 3,
	Attachment = 4,
	Rune = 5
	COUNT = 6
}

gt.Const.Items.HelmetUpgrades <- {
	Helm = 0,
	Top = 1,
	Vanity = 2,
	Rune = 3,
	ExtraVanity = 4,
	//Extra spot for second vanity
	COUNT = 5
}