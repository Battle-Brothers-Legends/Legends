local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Location" in gt.Const.World))
{
	gt.Const.World.LocationNames <- {};
}

gt.Const.World.LocationNames.VillageWestern <- [
	"Wiesendorf",
	"Elkshorn",
	"Dunkelwald",
	"Altdorf",
	"Wallendorf",
	"Auen",
	"Kallesheim",
	"Windau",
	"Minarken",
	"Durbach",
	"Almor",
	"Weilau",
	"Wedemark",
	"Heidemark",
	"Bogenheim",
	"Sonneberg",
	"Reusdorf",
	"Langenthal",
	"Thurgau",
	"Baden",
	"Tordorf",
	"Waldrode",
	"Rauthal",
	"Isenhagen",
	"Hagen",
	"Malmkrog",
	"Ferlangen",
	"Radeln",
	"Arbegen",
	"Hamruden",
	"Schoenberg",
	"Eisenstein",
	"Tadeln",
	"Hammererden",
	"Segeland",
	"Ulhart",
	"Felmern",
	"Weidenau",
	"Rietberg",
	"Ottendorf",
	"Thalheim",
	"Dornheim"
];
gt.Const.World.LocationNames.CityWestern <- [
	"Albstadt",
	"Almborg",
	"Dulmen",
	"Marburg",
	"Ulmen",
	"Dornen",
	"Karnstein",
	"Wallstadt",
	"Beagleburg"
];
gt.Const.World.LocationNames.GuardTower <- [
	"Old Guard Tower",
	"Watchtower",
	"Stormwatch Tower",
	"Blackwatch Tower",
	"Ironheart Tower",
	"Woodcroft Tower",
	"Foothill Keep",
	"%randomname%\'s Watch",
	"Wildlands Lookout",
	"Stonefist Tower",
	"Guardian\'s Keep",
	"Heimwart Tower",
	"Ancient Outlook",
	"Orcbane Tower"
];
gt.Const.World.LocationNames.Castle <- [
	"Seven Hills Castle",
	"Kronland Castle",
	"Sturmwind Castle",
	"Berland Castle",
	"Heimland Castle",
	"Mortham Castle",
	"Walmer Castle",
	"Hornburg Castle",
	"Reikmark Castle",
	"Starkland Castle",
	"Wallstein Citadel",
	"Dorngard Castle",
	"Kragburg Castle"
];
gt.Const.World.LocationNames.BanditCamp <- [
	"Black Fort",
	"Thousand Spears Camp",
	"Hanging Man Fort",
	"Dead Men Fort",
	"Black Hounds Camp",
	"Dread Fort",
	"Hidden Knife Camp",
	"Widow Makers Camp",
	"Outcasts Den",
	"Dagger Den",
	"Murderer\'s Hideaway",
	"Muggers\' Nest",
	"Lawless Hideout",
	"Brigands\' Lair",
	"Marauders\' Camp",
	"Pillagers\' Camp",
	"Plunderers\' Camp",
	"Viper\'s Den",
	"Red Knives Camp",
	"Red Eagles Den",
	"Bloodwolves Court",
	"Free Peoples Camp",
	"Red Moon Den",
	"Thirty Axes Encampment",
	"Raiders\' Encampment",
	"Daggercrest Cover",
	"The Bronze Nest",
	"Long Daggers\' Cave",
	"Lost Souls Harbor",
	"The Outcast\'s Burrow",
	"Bandits Lair",
	"Ashen Head Hideout",
	"Jagged Blades\' Garrison",
	"Wanted Mens\' Retreat",
	"Coldhearts\' Escape",
	"Duskfall Camp",
	"Sackcloth Garrison",
	"Retreat of the Wicked",
	"Lawmen\'s Demise",
	"Headcutter\'s Nest",
	"Manclubber\'s Hideout",
	"The Tramp Camp",
	"Brotherhood of the Knife",
	"Crimson Marauders\' Camp",
	"Outlaws\' Hideaway",
	"Reckless Brothers\' Camp",
	"Pursecutters\' Cover",
	"Highwaymen\'s Hideout",
	"Robbers\' Lair",
	"Burglers\' Encampment",
	"Black Hearts\' Den",
	"Renegades\' Bastion",
	"The Exiles\' Hideaway",
	"Bastion of the Exiled",
	"Backstabbers\' Nest",
	"Throatcutters\' Burrow",
	"Blackjack\'s Camp"
];
gt.Const.World.LocationNames.OrcCamp <- [
	"Naragash",
	"Bara Garash",
	"Bara Karagim",
	"Bara Maratuk",
	"Skallebar Turum",
	"Urogash Morat",
	"Maruk Blot",
	"Ghul Blagash",
	"Rubrokk",
	"Korashtum",
	"Skallehalden",
	"Wargash Sapat",
	"Bara Skrabsragash",
	"Obarakk",
	"Gulgash Ghul",
	"Wargasharak",
	"Rurak Barat",
	"Garagash Rotak",
	"Eregash Hartak",
	"Hurgash Ghaal",
	"Wagash Blot",
	"Morat Gragagash",
	"Urot Gash",
	"Vrek Sapat",
	"Varuk Ghul",
	"Skarsnik Blot",
	"Mogtul Garash",
	"Shagol Vrak",
	"Vargash Hartak",
	"Uratosh Turum",
	"Turbagash",
	"Toghat Blok",
	"Urug Wargash",
	"Guhlgarash",
	"Varghul Blot",
	"Glush Zugbu",
	"Uruk Zuga",
	"Grat Bogat",
	"Grug Zugar",
	"Darak Ghul",
	"Bloga Kurk",
	"Za-Zaruk",
	"Berek Wagash",
	"Graurukash",
	"Wuruk Zagash",
	"Blukat Gash",
	"Duruk Hartak"
];
gt.Const.World.LocationNames.GoblinBase <- [
	"Negex Zum",
	"Rotox Grubb",
	"Finex Thum",
	"Nul Zadux",
	"Thelox Grubb",
	"Zulim Bax",
	"Thum Niox",
	"Nexex Kadox",
	"Grubbzugat",
	"Nazatux",
	"Lazanix",
	"Shanarax",
	"Noxox",
	"Shex Shex Shex",
	"Shalax Tchech",
	"Thelox Tcharax",
	"Nul Sharax",
	"Haraz Nox",
	"Zugghat Thul",
	"Grubbox Thum",
	"Visnik Zum",
	"Thum Tux",
	"Grisnik Kadox",
	"Zugat Nazat",
	"Nozik Grubb",
	"Xin Zatox",
	"Zatox Thum",
	"Bazak Nox",
	"Zugtak",
	"Jadaz Grat",
	"Wirdlok Zum",
	"Zatak Nul",
	"Velok Kazul",
	"Nagraz Nox",
	"Thul Kazum"
];
gt.Const.World.LocationNames.Crypt <- [
	"Tomb of the Mad King",
	"Long Forgotten Tomb",
	"Tomb of Lords",
	"Hill People Tomb",
	"Derelict Crypt",
	"Ruined Tomb",
	"Hidden Temple",
	"Tomb of %randomnoble%",
	"Dead Gate Crypt",
	"Crypt of the Hound",
	"Crypt of Jal-Fargo",
	"Tomb of the Great Seer",
	"Tomb of Many Crows",
	"Tomb of %randomname% the {Great | Cruel | Tyrant}",
	"Tomb of the First Men",
	"Crypt of Ogmar",
	"Bones\' Rest",
	"Dark Vault",
	"Last Rest",
	"Ruined Temple",
	"Tomb of Tombe",
	"Eternal Tomb",
	"Greybeard\'s Crypt",
	"Hellhole Crypt",
	"Monument to Hopelessness",
	"Hollow Bones Crypt",
	"Grinning Skulls Rest",
	"Desecrated Crypt",
	"Lost Crypt",
	"Unearthed Tomb",
	"Tomb of the Old Kings",
	"Stirring Crypt",
	"Bleached Bones Tomb",
	"Tomb of the Forefathers",
	"Crypt of Midnight",
	"Grandfathers\' Tomb",
	"Crypt of the Elder",
	"Gatekeeper\'s Rest",
	"Weeping Tomb",
	"Crypt of Mourning",
	"Catacomb of the Restless",
	"Ancestors\' Sepulchre",
	"Cursed Mausoleum",
	"Cavern of the Dead",
	"Broken Bones Mortuary",
	"Sepulchre of the Restless",
	"First King\'s final rest",
	"Darkwood Tomb",
	"Desolate Mausoleum",
	"Rattling Bones Crypt",
	"Forsaken Vault",
	"The Grim Tombs"
];
gt.Const.World.LocationNames.MassGrave <- [
	"Rest of No Return",
	"Grave of the Last Fellowship",
	"Grave of Heimlands Battle",
	"Rest of Thousands",
	"Shuffling Bones Swale",
	"Opened Massgrave",
	"Disturbed Massgrave",
	"Plague Graves",
	"Ancient Burial Site",
	"Unearthed Grave Mounds",
	"Heap of Bones",
	"Rotting Bones Rest",
	"Ancient Battle Site",
	"White Bones Hollow",
	"Forgotten Massgrave",
	"Adventure\'s End",
	"Last Hope\'s End",
	"Sunken Battlefield",
	"%randomname%\'s Defeat",
	"Exposed Massgrave",
	"Excavated Heap of Bones",
	"Overflowing Grave",
	"Improvised Burial Site",
	"Field of Bones",
	"Doomed Fields",
	"Overturned Massgrave",
	"Defiled Battlefield",
	"Bone sprinkled Fields",
	"White Bones Menagerie",
	"Cursed Grave Mounds",
	"Vulture\'s Feast",
	"Withered Battlesite",
	"Last Lord\'s Demise",
	"Plundered Battlefield",
	"Hill of Bones",
	"Skeleton Mountains",
	"Ocean of Bones"
];
gt.Const.World.LocationNames.VampireCoven <- [
	"Red River Manor",
	"Black Blood Coven",
	"Bloodluster\'s Coven",
	"Coven of the Old Master",
	"Circle of the Ancient Ones",
	"Withered Duke\'s Coven",
	"Circle of the Immortals",
	"Deathless Coven",
	"House of the Immortals",
	"Hunger\'s Home",
	"Coven of Midnight",
	"Crypt of the old Rulers",
	"Coven of the Ancient",
	"Castle of the Necrosavant",
	"Nightmare Coven",
	"Circle of the Bloodbound",
	"Halls of the Wicked",
	"Dark Shrouds Coven",
	"Temple of the Undying",
	"Night Dwellers Temple",
	"Castle of the Ancient Dead",
	"Coven of the Banished",
	"Coven of No Return",
	"Circle of Eternal Darkness",
	"Full Moon\'s Covet",
	"Ghoul\'s Crave",
	"Forsaken Coven",
	"House of Nightmares",
	"Coven of the Masquerade",
	"Red Thirst\'s Home",
	"Blood Guzzlers Hideaway",
	"Nocturnal Hunger\'s Crypt",
	"Coven of the Flying Dead",
	"House of the Abyss",
	"Black Shroud Manor",
	"Death Rejecter\'s Coven",
	"Halls of the Uundying",
	"Circle of the Moonlight Army",
	"Castle of the Wicked",
	"Coven of Midnight Terror",
	"Blooddrinkers Nest",
	"Blood Spawn\'s Keep"
];
gt.Const.World.LocationNames.Ruins <- [
	"Burned Ruins",
	"Overgrown Foundations",
	"Forgotten Ruins",
	"Crumbling Ruins",
	"Abandoned Walls",
	"Collapsed Dwellings",
	"Shelter between Ruins",
	"Occupied Ruins",
	"Ruins of Fieren",
	"Ruins of Kragenheim",
	"Ruins of Borgen",
	"Collapsed Ruins",
	"Abandoned Stronghold",
	"Collapsed Fortress",
	"Ancient Ruins",
	"Ruins of Stormwatch Keep",
	"Ruins of Blackwatch Keep",
	"Ruins of Ironheart Keep",
	"Ruins of Stalwart Keep",
	"%randomname%\'s Watch",
	"Stonefist Keep Ruins",
	"Guardian\'s Keep Ruins",
	"Heimwart Castle Ruins",
	"Ancient Outlook",
	"Ruins of Orcbane Keep",
	"Tilted Stones",
	"Ruined Dwellings",
	"Worn down Fortress",
	"Crumbled Fortifications",
	"Abandoned Remains",
	"Mossy Ruins",
	"Crumbled Shelter",
	"Fortress Remnants",
	"Forgotten Fort",
	"Overgrown Stronghold",
	"Bleached out Ruins",
	"Long lost Keep",
	"Deserted Towers",
	"Forsaken Ruins",
	"Vacated Dwellings",
	"Crumbled Watchtower",
	"Fragmented Stronghold",
	"Ruins of Old",
	"Turned over Stones",
	"Tumbled Keep",
	"Fallen Keep",
	"Shattered Stronghold",
	"Toppled Watchtower",
	"Ancestral Remains",
	"Burrowed Dwellings",
	"Undone Fortress"
];
gt.Const.World.LocationNames.BuriedCastle <- [
	"Lost Palace",
	"Swallowed Castle",
	"Sunken Walls of the Markgraf",
	"Vanished Keep",
	"Cursed Citadel",
	"Buried Castle of %randomname%",
	"Drowned Fortress",
	"Abandoned Castle Ruins",
	"Black Fortress",
	"Crimson Castle",
	"Sunken Stronghold",
	"Home of the Lost Throne",
	"Palace Below",
	"Unholy Palace",
	"Underground Refuge",
	"Fortress of the Sunken King",
	"Burrowed Palace",
	"Sunless Palace",
	"City of Graves",
	"Dead City",
	"Lost King\'s Castle",
	"Necropolis",
	"Entombed Citadel",
	"Sunken City",
	"Fortress Below",
	"Sunless Keep",
	"Stronghold under the Earth",
	"Unreachable Citadel",
	"Sunken Hold of the Dead",
	"Doomed City",
	"Buried Citadel",
	"Palace under the Earth",
	"Underground Palace",
	"Lost Castle of the Doomed",
	"Labyrinth of the Dead",
	"The Whispering Fortress",
	"City of Silence",
	"The exiled Fort",
	"Castle of the mumbling Prince",
	"Burrowed Castle",
	"Stronghold of the Perished"
];
gt.Const.World.LocationNames.Hideout <- [
	"Old %randomname%\'s Hut",
	"Forgotten Woodcutter\'s Home",
	"Forester\'s Hideout",
	"Forsaken Hut",
	"Forgotten Homestead",
	"Abandoned Shelter",
	"Overgrown Homestead",
	"Ruined Farmhouse",
	"Rotten Hut",
	"Ruined Hut",
	"Hermit\'s Cottage",
	"Backstabbers Hideout",
	"Sharp Blades Ambush",
	"Overgrown Hideout",
	"Greedy Hearts Hideout",
	"Abandoned Hut",
	"Collapsed Hiding-Place",
	"Overgrown Woodcutter\'s Hut",
	"Deserted Shelter",
	"Travelers Rest",
	"Lost Mans Shelter",
	"Crumbled Homestead",
	"Forgotten Hut",
	"Deserted Farmstead",
	"Mossy Shelter",
	"Neglected Hut",
	"Run-down Cottage",
	"Ruined Abode",
	"Lost Cottage",
	"Occupied Hovel",
	"Collapsed Hovel",
	"Patched Abode",
	"Woodcutter\'s Cabin",
	"Shabby Shack",
	"Ruined Lodge",
	"Drafty Shack",
	"Brittle Hovel",
	"Rotten Lodge",
	"Crumbled Farmstead",
	"Moldy Shelter",
	"Ramshackle Cottage",
	"Improvised Shelter",
	"Poacher\'s Retreat",
	"Hunter\'s Shack",
	"Ramshackle Hiding-Place",
	"Wobbly Shelter"
];
gt.Const.World.LocationNames.GreenskinCamp <- [
	"Ten Tusks Camp",
	"Iron Shore Invaders Camp",
	"Browbreakers Camp",
	"Bloodguzzlers Camp",
	"Rotting Cranks Camp",
	"Shattered Axes Camp",
	"Boar Skull Camp",
	"Mirkwood Marauders Camp",
	"Bonebreakers Camp",
	"Meatchoppers Dump",
	"Jagged Hatchet Den",
	"Skullcracker Camp",
	"Raging Horde Camp",
	"Greenskin Raiders Camp",
	"Bone Eaters Encampment",
	"Red Knives Camp",
	"Man Eaters Den",
	"Camp of the Burning Axe",
	"Sawtooths Warcamp",
	"Plunderers Base",
	"Raiders Basecamp",
	"Shattering Roar Camp",
	"Mailcrunchers\' Camp",
	"Wallsmashers\' Encampment",
	"Iron Jaws Den",
	"Men Stomper\'s Rallyfield",
	"Rallypoint of the Ten Tribes",
	"Warcamp of the Boar Tribe",
	"Black Hands Rallyfield",
	"Headcrusher\'s Garrison",
	"Warleader\'s Encampment",
	"Gutripper\'s Camp",
	"Thousand Teeth\'s Encampment"
];
gt.Const.World.LocationNames.GoblinCamp <- [
	"Slave Drivers\' Camp",
	"Sharp Teeth Lair",
	"Skewer\'s Hideout",
	"Long Pikes Den",
	"Black Wolves Lair",
	"Pointy Ear Hideout",
	"Sharp Blades Ambush",
	"Many Knives Hideout",
	"Wolf Pack Camp",
	"Den of the Unwilling",
	"Green Menace Camp",
	"Pointy Sticks Camp",
	"Ambushers\' Hideout",
	"Grinding Knife Camp",
	"Camp of a thousand Arrows",
	"Stabbers\' Den",
	"Camp of the Senate",
	"Backstabbers\' Ambush",
	"Lair of the snickering Evil",
	"Sharpshooters\' Camp",
	"Flying Knives Camp",
	"Snickering Death\'s Camp",
	"Poison Brewer\'s Hideout",
	"Cruel Stalker\'s Garrison",
	"Shadow Lurker\'s Encampment",
	"Den of the Assassins",
	"Rallyfield of the Senate",
	"Poison Flinger\'s Garrison",
	"Slave Driver\'s Base",
	"Shaman\'s Warcamp",
	"Ranger\'s Basecamp"
];
gt.Const.World.LocationNames.NecromancerLair <- [
	"Lair of Dark Rituals",
	"Necromancer\'s Hidden Chambers",
	"Retreat of the Puppet Master",
	"Hideout of the Necromancer",
	"Cave of the Dead",
	"Lair of the Outcast",
	"Den of the Undead",
	"Necromancer\'s Refugium",
	"Sanctum of the Dark Arts",
	"Necromancer\'s Lair",
	"Refuge of the Apostate",
	"Heretic\'s Hideout",
	"Sinner\'s Den",
	"Heathen\'s Secret Circle",
	"Vile Man\'s Retreat",
	"Lair of Forbidden Rituals",
	"Puppet Master\'s Sanctum",
	"Refuge of the Outcast",
	"Lair of the Unspeakable",
	"Hideout of the Insane Master",
	"Necromancer\'s Retreat",
	"Reanimator\'s Abode",
	"Circle of the Dark Powers",
	"Secret Halls of the Occultist",
	"Forbidden Art\'s Sanctum",
	"Dark Charmer\'s Retreat",
	"Den of unnamed Horrors",
	"Abode of the Night",
	"Puppet Master\'s Cabinet",
	"Desecrated Temple",
	"Hideout of the Death-Defyer",
	"Church of the dark Priest",
	"Temple of the Unspeakable",
	"Retreat of the Apostate",
	"Apostate\'s Secret Abode",
	"Soulbinder\'s Sanctum",
	"Lair of the Power Hungry",
	"Secret Chamber\'s of Insanity",
	"Retreat of the Harvester",
	"Animator\'s Hideout",
	"Den of the Surgeon"
];
gt.Const.World.LocationNames.Graveyard <- [
	"Overgrown Tombstones",
	"Remote Graveyard",
	"Tilted Tombstones",
	"Hidden Graveyard",
	"Abandoned Cemetery",
	"Old Graveyard",
	"Ancient Cemetery",
	"Sunken Tombstones",
	"Cemetery of the Poor",
	"Improvised Burial Site",
	"Cemetery of the Restless",
	"Rattling Bones Graveyard",
	"Abandoned Graveyard",
	"Ancient Graveyard",
	"Forbidden Graveyard",
	"Forefathers Cemetery",
	"Abandoned Burial Site",
	"Crumbling Tombstones",
	"Overturned Burial Ground",
	"Ancestral Burial Grounds",
	"Hope\'s Last Rest",
	"Ancestral Cemetery",
	"Hidden Burial Site",
	"Secluded Burial Ground",
	"Secluded Cemetery",
	"Mossy Gravestones",
	"Last Rest of the Forgotten",
	"Abandoned Burial Mounds",
	"Forefather\'s Graves",
	"Ancestor\'s last Rest",
	"Cemetery of Old",
	"Tilted Gravemarkers",
	"Screaming Stones Graveyard",
	"Remote Gravestones",
	"Cemetery of the Elder",
	"Pox Victims Graves"
];
gt.Const.World.LocationNames.OrcCave <- [
	"Cave of Thousand Screams",
	"Thunderclan Hideout",
	"Stinking Cave",
	"Occupied Cave",
	"Uncharted Cave",
	"Long Tusks Den",
	"Frenzied Axes Den",
	"Blood Cleaver\'s Den",
	"Jagged Fangs Hideout",
	"Cave of the Ilskah Ghul",
	"Torturer\'s Cave",
	"Child-Snatcher\'s Cave",
	"Black Boar Lair",
	"Foul Cave",
	"Bonebreaker\'s Cavern",
	"Cavern of the Boar",
	"Greenskin\'s Den",
	"Cavern of Lost Screams",
	"Plunderer\'s Den",
	"Cave of the Flesheaters",
	"Skullsmasher\'s Grotto",
	"Grotto of the Wild Men",
	"Headchopper\'s Grotto",
	"Cavern of the Green Death",
	"Grunter\'s Grotto",
	"Orc infested Cave",
	"Flesheater\'s Cavern"
];
gt.Const.World.LocationNames.BarbarianShelter <- [
	"Barbarian Tents",
	"Free People\'s Hideout",
	"Barbarian Fur Huts",
	"Makeshift Fur Huts",
	"Thrall\'s Shelter",
	"Tribal Hovels",
	"Tribal Shacks",
	"Raider\'s Tents",
	"Tribal Jurts",
	"Jurts of the Free Folk",
	"Northern Jurts",
	"Nordic Huts",
	"Outpost of the Tribes",
	"Tribal Vanguard",
	"Barbarian Outpost"
];
gt.Const.World.LocationNames.BarbarianCamp <- [
	"Barbarian Encampment",
	"Tribal Camp",
	"Reavers\' Basecamp",
	"Pillagers\' Jurts",
	"Slavetaker\'s Rest",
	"Northern Hideout",
	"Makeshift Barbarian Camp",
	"Barbarian Hideaway",
	"Defended Barbarian Camp",
	"Reavers\' Jurts",
	"Clansmen\'s Retreat",
	"Jurts of the Ancestors",
	"Camp of the Slavetakers"
];
gt.Const.World.LocationNames.BarbarianSanctuary <- [
	"Champion\'s Rallyfield",
	"Stone of the Ancients",
	"Barbarian War Camp",
	"Ancestors\' Jurt City",
	"Rallying Stone of the Elders",
	"Forefathers\' Gathering",
	"Barbarian Place of Power",
	"Tribal Warriors Camp",
	"Barbarian\'s Ritual Site",
	"Fur Tent Encampment",
	"Camp of the Ancestors",
	"Sacrifical Altar",
	"Altar of the Ancestors",
	"Fortified Barbarian Huts"
];
gt.Const.World.LocationNames.NomadTents <- [
	"Nomad Huts",
	"Desert Tents",
	"Nomad Tents",
	"Hidden Tents",
	"Nomad Hideout",
	"Fleeting Camp",
	"Flying Tents",
	"Nomad Shelter",
	"Moving Tents",
	"Nomad Encampment",
	"Freemen Tents",
	"Golden Tents",
	"Crimson Tents",
	"Blazing Shelter",
	"Wandering Tents",
	"Sandcovered Tents"
];
gt.Const.World.LocationNames.HiddenCamp <- [
	"Nomad Hideout",
	"Nomad Hideaway",
	"Hidden Camp",
	"Nomad Camp",
	"Makeshift Camp",
	"Travelers Camp",
	"Desert Shelter",
	"Shelter Inbetween Rocks",
	"Desert Raiders Outpost",
	"Free Roamers Camp",
	"Nomad Retreat",
	"Desert Scourge Camp",
	"Raiders Retreat",
	"Red Sands Camp",
	"Burning Sands Camp",
	"White Sands Camp",
	"Free-Souls Encampment",
	"Golden Sun Hideout",
	"Shifting Sands Hideout",
	"Desert Raiders Encampment"
];
gt.Const.World.LocationNames.NomadTentCity <- [
	"Nomad City",
	"City of Tents",
	"Camp of the Morning Sun",
	"Desert Warriors\' Tent City",
	"Wandering City",
	"Blazing Sun Camp",
	"Nomad Conclave",
	"Wandering Kingdom",
	"Dead Oasis Camp",
	"City of Golden Sands"
];
gt.Const.World.LocationNames.AncientRuins <- [
	"Remnants of the Empire",
	"Remnants of Long Past",
	"Sunken Ruins",
	"Swallowed Ruins",
	"Dusty Walls",
	"Sandcovered Remnants",
	"Sandwashed Ruins",
	"Bleached Stones",
	"Scorched Ruins",
	"Ancient Ruins",
	"Ruined Empire Walls",
	"Ruins of Old",
	"Sandcovered Ruins",
	"Toppled Sandy Stones",
	"Vanishing Stones",
	"Debris of Ancient Times",
	"Devoured Settlement",
	"Buried Walls",
	"Walls under the Sands"
];

