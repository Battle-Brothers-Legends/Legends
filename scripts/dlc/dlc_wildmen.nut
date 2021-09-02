local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Wildmen" in gt.Const.DLC) || !this.Const.DLC.Wildmen)
{
	this.Const.DLC.Wildmen <- this.hasDLC(1067690) && this.Const.Serialization.Version >= 48;

	if (this.Const.DLC.Wildmen)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 16;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_06.jpg");
		this.Const.LoadingScreens.push("ui/screens/loading_screen_09.jpg");
		local tips = [
			"The north is inhabited by fierce barbarian tribes.",
			"Barbarians often overwhelm their opponents at the start of battle, but quickly become fatigued.",
			"Northern warhounds are sturdier than southern wardogs, but not as quick and agile.",
			"The rhythmic tribal beats of drummers reduce the fatigue of all barbarians on the field by a small amount each round.",
			"Beastmasters can not crack the whip to direct their beastly warmachines when adjacent to an enemy.",
			"Barbarians look forward to meeting their ancestors in the afterlife.",
			"Try different origins to tailor your campaign to your play style.",
			"With the \'Lone Wolf\' origin you\'ll have a player character in the world. If you die, the campaign ends.",
			"With the \'Peasant Militia\' origin you can take up to 25 men into battle at once.",
			"With the \'Cultists\' origin your god will demand sacrifices from you, but also bestow boons upon those loyal to him.",
			"With the \'Band of Poachers\' origin you\'ll move faster on the worldmap.",
			"With the \'Trading Caravan\' origin you\'ll get better prices for both buying and selling.",
			"Slings inflict the \'Daze\' status effect on a hit to the head.",
			"With stones abundant everywhere, Slings will never run out of ammunition.",
			"Battle Whips can temporarily disarm opponents, preventing them from using weapon skills.",
			"Battle Whips can inflict bleeding wounds, but perform dismally against armor.",
			"Scimitars and Shamshirs are more likely to inflict debilitating injuries when hitting a target."
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.PlayerBanners.push("banner_24");
		this.Const.PlayerBanners.push("banner_25");
		this.Const.Tattoos.All.push("warpaint_02");
		this.Const.Tattoos.All.push("warpaint_03");
		this.Const.Tattoos.All.push("tattoo_02");
		this.Const.Tattoos.All.push("tattoo_03");
		this.Const.Tattoos.All.push("tattoo_04");
		this.Const.Tattoos.All.push("tattoo_05");
		this.Const.Tattoos.All.push("tattoo_06");
		this.Const.Items.NamedWeapons.push("weapons/named/named_bardiche");
		this.Const.Items.NamedWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedWeapons.push("weapons/named/named_battle_whip");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_bardiche");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_battle_whip");
		this.Const.Items.NamedHelmets.push("helmets/named/norse_helmet");
		this.Const.Items.NamedHelmets.push("helmets/named/named_conic_helmet_with_faceguard");
		this.Const.Items.NamedHelmets.push("helmets/named/named_nordic_helmet_with_closed_mail");
		this.Const.Items.NamedHelmets.push("helmets/named/named_steppe_helmet_with_mail");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/named_steppe_helmet_with_mail");
		this.Const.Items.NamedArmors.push("armor/named/named_golden_lamellar_armor");
		this.Const.Items.NamedArmors.push("armor/named/named_noble_mail_armor");
		this.Const.Items.NamedArmors.push("armor/named/named_sellswords_armor");
		this.Const.Items.NamedSouthernArmors.push("armor/named/named_golden_lamellar_armor");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_bull_helmet");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_nose_horn_helmet");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_skull_helmet");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_bronze_armor");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_plated_fur_armor");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_skull_and_chain_armor");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_rusty_warblade");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_skullhammer");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_heavy_rusty_axe");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_two_handed_spiked_mace");
	}
}

