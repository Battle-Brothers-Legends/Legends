local gt = this.getroottable();

if (!("Strings" in gt.Const))
{
	gt.Const.Strings <- {};
}

gt.Const.Strings.CharacterNames <- [
	"Sigurd",
	"Siegfried",
	"Hilmar",
	"Harald",
	"Sigbold",
	"Siegward",
	"Ulfert",
	"Kalle",
	"Espen",
	"Hagen",
	"Ewald",
	"Wenzel",
	"Ejnar",
	"Gunther",
	"Ivar",
	"Jannold",
	"Bertel",
	"Ingolf",
	"Wiedekind",
	"Egon",
	"Casimir",
	"Hilderich",
	"Friedrich",
	"Wendel",
	"Hasso",
	"Wilreich",
	"Hans",
	"Torhelm",
	"Fritz",
	"Mattis",
	"Birk",
	"Arnold",
	"Knut",
	"Adler",
	"Niels",
	"Elmer",
	"Ulfert",
	"Jost",
	"Tostig",
	"Bertram",
	"Albrecht",
	"Kunold",
	"Baldomar",
	"Dietmar",
	"Donbert",
	"Erwin",
	"Caspar",
	"Arne",
	"Edmund",
	"Kunibert",
	"Arnulf",
	"Eduard",
	"Meinolf",
	"Oskar",
	"Giselherr",
	"Reimar",
	"Wernhard",
	"Vander",
	"Werner",
	"Wigald",
	"Willibald",
	"Bjarne",
	"Henrik",
	"Ruthard",
	"Alrik",
	"Hubert",
	"Ernst",
	"Rudolf",
	"Hartbert",
	"Asgeir",
	"Horik",
	"Konrad",
	"Gerhard",
	"Hanke",
	"Guido",
	"Till",
	"Geralt",
	"Hartwig",
	"Thorben",
	"Gisbert",
	"Bruno",
	"Wigmar",
	"Gottfried",
	"Hakon",
	"Goswin",
	"Guntbert",
	"Eckbert",
	"Roger",
	"Gebhard",
	"Ralf",
	"Bernfried",
	"Guntram",
	"Ferdinand",
	"Leonhard",
	"Gerlach",
	"Helmer",
	"Gustav",
	"Gerold",
	"Gero",
	"Gerulf",
	"Emmerich",
	"Karl",
	"Dirk",
	"Falk",
	"Anselm",
	"Diethelm",
	"Alvar",
	"Eberecht",
	"Wilhelm",
	"Hildebert",
	"Erik",
	"Theudobald",
	"Havard",
	"Hakon",
	"Wolfgang",
	"Erling",
	"Kori",
	"Randolf",
	"Rollo",
	"Leif",
	"Lars",
	"Torsten",
	"Ingmar",
	"Asbjorn",
	"Steinar",
	"Reynhart",
	"Baldur",
	"Olaf",
	"Egil",
	"Magnus",
	"Gunnar",
	"Svein",
	"Carsten",
	"Eugen",
	"Anton",
	"Torvald",
	"Bernhard",
	"Einar",
	"Leberecht",
	"Ragnar",
	"Ottmar",
	"Otwin",
	"Balon",
	"Eberold",
	"Bertwin",
	"Oswald",
	"Rabe",
	"Reimund",
	"Wolf",
	"Eberhard",
	"Grimwald",
	"Hugo",
	"Hallstein",
	"Helfrich",
	"Haribert",
	"Balduin",
	"Waldemar",
	"Engelbert",
	"Tobjoern",
	"Erland",
	"Torkel",
	"Horst",
	"Thorismund",
	"Torleif",
	"Erhard",
	"Ulf",
	"Otto",
	"Hermann",
	"Heinrich",
	"Halsten",
	"Kettilmund",
	"Alfgeir",
	"Sorrel",
	"Hartmut",
	"Lothar",
	"Manfred",
	"Reinhold",
	"Alfred",
	"Dietrich",
	"Rupert",
	"Heimrad",
	"Sigmar",
	"Friso",
	"Landrich",
	"Lienhard",
	"Sigmund",
	"Reinhardt",
	"Kurt",
	"Bodo",
	"Volmar",
	"Liebwin",
	"Dieter",
	"Ulrich",
	"Eike",
	"Walram",
	"Malte",
	"Grimald",
	"Berthold",
	"Alberich",
	"Raban",
	"Rumold",
	"Witold",
	"Volker",
	"Volkhart",
	"Bertolf",
	"Walter",
	"Ortwin",
	"Humbert",
	"Adelmar",
	"Konrad",
	"Gernot",
	"Radulf",
	"Ludolf",
	"Giselher",
	"Adelbert",
	"Hjalmar",
	"Reiner",
	"Burkhard",
	"Winrich",
	"Wilderich",
	"Wilfried",
	"Robert",
	"Wolfram",
	"Raimund",
	"Thilmann",
	"Norman",
	"Ludger",
	"Alwin",
	"Markward",
	"Markolf",
	"Hadebrand",
	"Roderick",
	"Rambert",
	"Meinrad"
];
gt.Const.Strings.CharacterNamesFemale <- [
	"Ingrid",
	"Helga",
	"Irma",
	"Adela",
	"Birgit",
	"Bertha",
	"Borghild",
	"Brunhild",
	"Frida",
	"Gudrun",
	"Hilda",
	"Sigrid",
	"Mathilda",
	"Gerhild"
];
gt.Const.Strings.NobleTitles <- [
	"Count",
	"Count",
	"Baron",
	"Baron",
	"Duke"
];
gt.Const.Strings.SellswordTitles <- [
	"the Butcher",
	"the Berserker",
	"the Dog",
	"the Hound",
	"the Bloody",
	"the Wolf",
	"the Blade",
	"the Impaler",
	"the Younger",
	"the Older",
	"the Merciless",
	"the Red",
	"the Black",
	"Orcbane",
	"the Knightslayer",
	"the Falcon"
];
gt.Const.Strings.SwordmasterTitles <- [
	"the Legend",
	"the Old Guard",
	"the Master"
];
gt.Const.Strings.HedgeKnightTitles <- [
	"the Lone Wolf",
	"the Wolf",
	"the Hound",
	"Steelwielder",
	"the Slayer",
	"the Jouster",
	"the Giant",
	"the Mountain",
	"Strongface",
	"the Defiler",
	"the Knightslayer",
	"the Hedge Knight"
];
gt.Const.Strings.MasonTitles <- [
	"the Builder",
	"Bricklayer",
	"the Architect",
	"the Artisan"
];
gt.Const.Strings.MilitiaTitles <- [
	"the Conscript",
	"the Militiaman",
	"the Footman"
];
gt.Const.Strings.BrawlerTitles <- [
	"Hamfisted",
	"the Mauler",
	"the Rock",
	"the Stallion",
	"Ironjaw",
	"the Brawler"
];
gt.Const.Strings.PeddlerTitles <- [
	"the Snake",
	"the Weasel",
	"Silver-Tongue",
	"the Sutler",
	"the Peddler",
	"the Merchant"
];
gt.Const.Strings.WitchhunterTitles <- [
	"the Nighthunter",
	"the Witchhunter",
	"the Exorciser",
	"the Torturer"
];
gt.Const.Strings.GravediggerTitles <- [
	"the Gravedigger",
	"the Shoveler",
	"Gravespotter",
	"the Odd"
];
gt.Const.Strings.RatcatcherTitles <- [
	"Longnose",
	"the Rat",
	"the Ratcatcher",
	"the Tepid"
];
gt.Const.Strings.BastardTitles <- [
	"the Bastard",
	"the Mistake",
	"Cuckchild",
	"the Secret Son",
	"Whoreson",
	"the Tarnish"
];
gt.Const.Strings.PilgrimTitles <- [
	"the Believer",
	"the Seeker",
	"the Thaumaturge",
	"the Pure",
	"the Flagellant",
	"the Pilgrim"
];
gt.Const.Strings.KnightNames <- [
	"Sir Roderick",
	"Sir Egidius",
	"Sir Henrik",
	"Sir Dankwart",
	"Sir Eisenherz",
	"Sir Geofram",
	"Sir Baranor",
	"Sir Wilhelm",
	"Sir Hildebrand",
	"Sir Hilmar",
	"Sir Severin",
	"Sir Starkwart",
	"Sir Elgast",
	"Sir Magnus",
	"Sir Burkhard",
	"Sir Silvan",
	"Sir Lambert",
	"Sir Kuno",
	"Sir Wenzel",
	"Sir Donatus",
	"Sir Albrecht",
	"Sir Hilderich",
	"Sir Sigmund",
	"Sir Steinhart",
	"Sir Hermann",
	"Sir Eckhart",
	"Sir Guidobald",
	"Sir Theo",
	"Sir Eswig",
	"Sir Walram",
	"Sir Casimir",
	"Sir Magnus",
	"Sir Wighart",
	"Sir Otto",
	"Sir Sigismund",
	"Sir Erland",
	"Sir Erkenbrand",
	"Sir Theoderich",
	"Sir Lothar",
	"Sir Wolfhart",
	"Sir Balon",
	"Sir Valdemar",
	"Sir Giselherr",
	"Sir Engelbert",
	"Sir Lancel",
	"Sir Humbert",
	"Sir Emmerich",
	"Sir Grimm",
	"Sir Donbert",
	"Sir Robert",
	"Sir Wolfgang",
	"Sir Kettilmund",
	"Sir Konrad",
	"Sir Rupert",
	"Sir Harald",
	"Sir Roland",
	"Sir Rabe",
	"Sir Siegfried",
	"Sir Kunibert",
	"Sir Dankrad",
	"Sir Leberecht"
];
gt.Const.Strings.OrcWarlordNames <- [
	"Illska Ghul",
	"Skabskra",
	"Urosh",
	"Kushtrum",
	"Goth Na Ari",
	"Obrokk",
	"Blok Sapat",
	"Gorash",
	"Mogtul",
	"Thraktar",
	"Gorgash-Ghul",
	"Maruk",
	"Warak Na Borash",
	"Urgat",
	"Durgash",
	"Skalleklyfta",
	"Margash Borash",
	"Borgash",
	"Goruk Sapat",
	"Karosh Urgat",
	"Horgash Ghul",
	"Naguk",
	"Shadok",
	"Bakh Lob",
	"Corgat",
	"Urmuk Ghul",
	"Mug Nadar",
	"Vras Ushtar",
	"Brulk Zogtar",
	"Sapat Blok",
	"Mosh Shagit",
	"Gajit Bukol",
	"Blot Kakok",
	"Thrak Talun",
	"Drod Kazan",
	"Oxshak",
	"Urdanog",
	"Trok Oborr",
	"Bolvag Shrub",
	"Ug Shatup",
	"Shatratog",
	"Buruk Skag",
	"Ilska Sapat",
	"Grug Zartum",
	"Grommok",
	"Ogrul",
	"Shura Nak"
];
gt.Const.Strings.BanditLeaderNames <- [
	"The Butcher",
	"%randomname% the Knife",
	"%randomname% the Slaughterer",
	"King %randomname%",
	"%randomname% the Ox",
	"The Wolf",
	"%randomname% the Marauder",
	"%randomname% the Snake",
	"%randomname% Four Fingers",
	"Barabas Brimstone",
	"Rotor Ravensblack",
	"Black Crow Balthasar",
	"The Bull of %randomtown%",
	"%randomname% Bloodbeard",
	"Mead Jar %randomname%",
	"Bloody %randomname%",
	"Dreaded %randomname%",
	"The Swine",
	"%randomname% the Cruel",
	"%randomname% the Outcast",
	"The Robber Baron",
	"Red Viper",
	"%randomname% the Brigand",
	"%randomname% the Scourge",
	"The Raiding Lord",
	"The Manhunter",
	"Big %randomname%",
	"%randomname% the Savage",
	"Infamous %randomname%",
	"The Menace of %randomtown%",
	"%randomname% the Red",
	"Gunther the Grinning",
	"%randomname% the Hyena",
	"%randomname% the Hawk",
	"%randomname% the Mad",
	"%randomname% the Brute",
	"%randomname% the Pillager",
	"Lars the Lunatic",
	"%randomname% the Free",
	"Black Eyes Einhart",
	"Oswall the Odd",
	"Brokk Mad Eyes",
	"%randomname% the Ashen Prince",
	"The Scourge of %randomtown%",
	"%randomname% the Bleak",
	"Bleak Blade Ingram",
	"%randomname% the Pickpocket",
	"Mickel Copperheart",
	"Casper the Cutpurse",
	"Ottel Bleakheart",
	"Joost Crowntaker",
	"Baltasar the Toothless",
	"Walter the Spider",
	"August the Gravedigger",
	"Urban Goodman"
];
gt.Const.Strings.KrakenNames <- [
	"Ogg-Sattoth the Grand Devourer",
	"Kha-Athlu the All-Ender",
	"Shaggaruth the Unending",
	"Gla-Oth the Endless Maw",
	"Gu-Shogg the Thousand-Armed Thresher",
	"Chtan-Nahitil the Gorger of All",
	"Xa-Shutar the Eater of Worlds",
	"Thohochoth the All-Ender",
	"Naccorath the Eternal",
	"Xapocathlu the All-Reaching"
];
gt.Const.Strings.CharacterNamesFemaleNorse <- [
	"Agata",
	"Alfhilda",
	"Arnlaug",
	"Birna",
	"Brunhild",
	"Bylgja",
	"Dagrun",
	"Drifa",
	"Edda",
	"Eir",
	"Elli",
	"Embla",
	"Fenja",
	"Frigg",
	"Gigja",
	"Groa",
	"Gudrun",
	"Gullveig",
	"Halla",
	"Heidrun",
	"Helga",
	"Hrefna",
	"Hulda",
	"Ida",
	"Inga",
	"Ingrid",
	"Ingunn",
	"Johanna",
	"Jorunn",
	"Katla",
	"Kolbrun",
	"Kristin",
	"Laufey",
	"Magdalena",
	"Magna",
	"Marta",
	"Mette",
	"Nanna",
	"Oda",
	"Ragna",
	"Runa",
	"Sif",
	"Signy",
	"Sigrid",
	"Sigrun",
	"Solveig",
	"Svana",
	"Tekla",
	"Tora",
	"Torunn",
	"Una",
	"Valborg",
	"Valdis",
	"Yrsa"
];
gt.Const.Strings.InventorTitles <- [
	"the Inventor",
	"the Curious",
	"the Peculiar",
	"the Inquisitive",
	"the Utilitarian",
	"the Serendipitous",
	"the Eclectic",
	"the Tinkerer"
];