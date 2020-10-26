local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Desert" in gt.Const.DLC) || !this.Const.DLC.Desert)
{
	this.Const.DLC.Desert <- this.hasDLC(1361280) && this.Const.Serialization.Version >= 63;

	if (this.Const.DLC.Desert)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 64;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_06.jpg");
		local tips = [
			"The southern city states have made unparalleled advancements in medicine, astrology and alchemy.",
			"The southerners call themselves \'Gilded\' after their god, in whose shine they bask day in and out.",
			"The \'indebted\' are a social caste of de-facto slaves in the city states.",
			"The southern city states are built on the ruins of the Ancient Empire.",
			"Nomads are a southern people that are not subject to the rule of a city state.",
			"Nomads are experts in desert warfare and using the environment to their advantage - including throwing it in your face.",
			"An Ifrit is a demonic entity possessing rocks, stone and shifting sands.",
			"A Qatal Dagger is best used in combination with other weapons that can stun or daze opponents.",
			"The Handgonne takes a whole turn to reload - unless your character has the \'Crossbows & Firearms Mastery\' perk.",
			"The Handgonne is a ranged weapon that can hit up to 6 targets with a single attack, but has less range than either bows or crossbows.",
			"The Fire Lance is reloaded after every battle just like throwing weapons are.",
			"Arena matches offer a quick way to earn coin - but you can\'t retreat during matches or loot afterwards.",
			"Arena tournaments are special events with different rules. Fight with five men over three consecutive rounds and win a famed item!",
			"Every fifth arena match offers the chance to win a piece of gladiator equipment that can\'t be bought otherwise.",
			"Fire Pots can be used not just to inflict damage on your opponents, but also to deny them access to tiles and delay them.",
			"Smoke Pots can be used for a safe retreat even if your men are already locked in melee.",
			"Mortars of the city states can only fire if an engineer is next to them to operate them.",
			"With the \'Manhunters\' origin you can make prisoners after every battle against humans and force them to fight for you.",
			"With the \'Gladiators\' origin you start with three powerful characters, but losing all three will end your campaign.",
			"Hire non-combat followers for your retinue to customize your campaign to your playstyle.",
			"Losing named shields to orcs? Hire a blacksmith for your retinue and repair any item, even if its durability reaches zero.",
			"Training your new recruits takes too long? Hire a drill sergeant to have them gain experience faster.",
			"Facing too few enemy champions? Hire a bounty hunter to find more and even earn a bounty for every one you kill.",
			"Paying too much in wages? Hire a paymaster to reduce the wages you have to pay.",
			"Wondering who went there? Hire a Lookout and get more information on any footprints on the world map.",
			"Always out of ammo and tools? Hire a scavenger to reclaim ammo you spent and gather tools from armor you destroyed.",
			"Inventory full? Buy carts and wagons for your company in the Retinue screen.",
			"You unlock slots for your retinue of non-combat followers by gaining Renown.",
			"Ferocious hyenas roam the southern deserts, with strong jaws that can crush even metal armor und inflict bleeding wounds.",
			"Try out different retinue followers to find those that complement your playstyle and chosen company origin."
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.Music.BeastsTracksSouth.push("music/beasts_04.ogg");
		this.Const.Music.ArenaTracks.push("music/beasts_04.ogg");
		this.Const.Music.WorldmapTracksSouth.push("music/worldmap_11.ogg");
		this.Const.Music.WorldmapTracksGreaterEvilSouth.push("music/worldmap_11.ogg");
		this.Const.PlayerBanners.push("banner_28");
		this.Const.PlayerBanners.push("banner_29");
		this.Const.PlayerBanners.push("banner_30");
		this.Const.Items.NamedWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedWeapons.push("weapons/named/named_handgonne");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_spear");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_handgonne");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_spear");
		this.Const.Items.NamedShields.push("shields/named/named_sipar_shield");
		this.Const.Items.NamedSouthernShields.push("shields/named/named_sipar_shield");
		this.Const.Items.NamedSouthernArmors.push("armor/named/black_and_gold_armor");
		this.Const.Items.NamedSouthernArmors.push("armor/named/leopard_armor");
		this.Const.Items.NamedArmors.push("armor/named/black_and_gold_armor");
		this.Const.Items.NamedArmors.push("armor/named/leopard_armor");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/red_and_gold_band_helmet");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/gold_and_black_turban");
		this.Const.Items.NamedHelmets.push("helmets/named/red_and_gold_band_helmet");
		this.Const.Items.NamedHelmets.push("helmets/named/gold_and_black_turban");
		this.Const.World.Settings.SizeY = 170;
		this.Const.World.Settlements.Master.push({
			Amount = 3,
			List = this.Const.World.Settlements.CityStates,
			IgnoreSide = true,
			AdditionalSpace = 13
		});
		this.Const.Faces.Barber.extend(this.Const.Faces.SouthernMale);
		this.Const.Bodies.Barber.extend(this.Const.Bodies.SouthernMale);
		this.Const.Hair.Barber.extend(this.Const.Hair.SouthernMaleOnly);
		this.Const.Beards.Barber.extend(this.Const.Beards.SouthernOnly);
	}
}

