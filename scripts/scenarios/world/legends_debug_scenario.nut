this.legends_debug_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_debug_party";
		this.m.Name = "(Developer Debug)";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p]Debug mode for legends developers";
		this.m.Difficulty = 2;
		this.m.Order = 999;
		this.m.StashModifier = 1000;
	}

	function isValid()
	{
		return true //this.Const.LegendMod.DebugMode;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local partysize = 1;
		local broLevelMax = 11;

		for( local i = 0; i < partysize; i = ++i )
		{
			local broLevel = broLevelMax
			local broPerks = broLevel - 1;
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.setStartValuesEx(["legend_blacksmith_background"])//this.Const.CharacterBackgroundsRandom);
			bro.m.Level = broLevel;
			bro.m.LevelUps = broPerks;
			bro.m.PerkPoints = broPerks;
			bro.setVeteranPerks(2);
		}

		 local horsesize = 0;
		 for( local i = 0; i < horsesize; i = ++i )
		 {
		 	local broLevel = broLevelMax
		 	local broPerks = broLevel - 1;
		 	local bro;
		 	bro = roster.create("scripts/entity/tactical/player");
		 	bro.m.HireTime = this.Time.getVirtualTimeF();
		 	bro.setStartValuesEx(this.Const.HorseBackgrounds);
		 	bro.m.Level = broLevel;
		 	bro.m.LevelUps = broPerks;
		 	bro.m.PerkPoints = broPerks;
		 	bro.setVeteranPerks(2);
		 }

		this.World.Assets.getStash().resize(2000);

		local bros = roster.getAll();

		this.World.Assets.m.Money = 50000;
		this.World.Assets.m.ArmorParts = 200;
		this.World.Assets.m.Medicine = 200;
		this.World.Assets.m.Ammo = 200;
		this.World.Assets.m.Food = 200;
		this.World.Assets.m.BusinessReputation = 1000;

		local banner = this.new("scripts/items/tools/player_banner");
		banner.setVariant(2);
		this.World.Assets.getStash().add(banner);
		local rune =  this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		rune.setRuneVariant(5);
		rune.updateRuneSigilToken();
		this.World.Assets.getStash().add(rune);

		local stashitems = [
			"accessory/bandage_item",
			"accessory/wardog_item",
			"accessory/armored_wardog_item",
			"accessory/warhound_item",
			"accessory/armored_warhound_item",
			"accessory/wolf_item",
			"accessory/falcon_item",
			"accessory/legend_white_wolf_item",
			"accessory/legend_warbear_item",
			"supplies/roots_and_berries_item",
			"supplies/legend_fresh_fruit_item",
			"supplies/legend_cooking_spices_item",
			"supplies/ground_grains_item",
			"ammo/large_quiver_of_bolts",
			"ammo/legend_large_broad_head_bolts",
			"ammo/legend_large_broad_head_arrows",
			"ammo/legend_large_armor_piercing_bolts",
			"ammo/legend_large_armor_piercing_arrows"
		]

		foreach (si in stashitems)
		{
			local pla = this.new("scripts/items/" + si);
			this.World.Assets.getStash().add(pla);
		}

		local armors = [
			"cloth/legend_ancient_cloth",
			"cloth/legend_ancient_cloth_restored",
			"cloth/legend_apron_butcher",
			"cloth/legend_apron",
			"cloth/legend_gambeson",
			"cloth/legend_gambeson_plain",
			"cloth/legend_gambeson_wolf",
			"cloth/legend_gambeson_named",
			"cloth/legend_padded_surcoat",
			"cloth/legend_padded_surcoat_plain",
			"cloth/legend_peasant_dress",
			"cloth/legend_robes",
			"cloth/legend_robes_magic",
			"cloth/legend_robes_wizard",
			"cloth/legend_robes_nun",
			"cloth/legend_sackcloth_tattered",
			"cloth/legend_sackcloth",
			"cloth/legend_sackcloth_patched",
			"cloth/legend_thick_tunic",
			"cloth/legend_tunic",
			"cloth/legend_tunic_wrap",
			"cloth/legend_tunic_collar_thin",
			"cloth/legend_tunic_collar_deep",
			"cloth/legend_dark_tunic",
			"cloth/legend_tunic_noble",
			"cloth/legend_tunic_noble_named",
			"cloth/legend_southern_robe",
			"cloth/legend_southern_gambeson",
			"cloth/legend_southern_split_gambeson",
			"cloth/legend_southern_tunic",
			"cloth/legend_southern_noble_surcoat",
			"chain/legend_armor_ancient_double_mail",
			"chain/legend_armor_ancient_mail",
			"chain/legend_armor_basic_mail",
			"chain/legend_armor_hauberk",
			"chain/legend_armor_hauberk_full",
			"chain/legend_armor_hauberk_full_named",
			"chain/legend_armor_hauberk_sleevless",
			"chain/legend_armor_mail_shirt",
			"chain/legend_armor_mail_shirt_simple",
			"chain/legend_armor_reinforced_mail",
			"chain/legend_armor_reinforced_mail_shirt",
			"chain/legend_armor_reinforced_rotten_mail_shirt",
			"chain/legend_armor_reinforced_worn_mail",
			"chain/legend_armor_reinforced_worn_mail_shirt",
			"chain/legend_armor_rusty_mail_shirt",
			"chain/legend_armor_short_mail",
			"chain/legend_southern_cloth",
			"chain/legend_southern_padded_chest",
			"chain/legend_southern_mail",
			"plate/legend_armor_leather_brigandine",
			"plate/legend_armor_leather_brigandine_hardened",
			"plate/legend_armor_leather_brigandine_hardened_full",
			"plate/legend_armor_leather_brigandine_named",
			"plate/legend_armor_leather_jacket",
			"plate/legend_armor_leather_jacket_named",
			"plate/legend_armor_leather_studded_jacket_named",
			"plate/legend_armor_leather_jacket_simple",
			"plate/legend_armor_leather_lamellar",
			"plate/legend_armor_leather_lamellar_harness_heavy",
			"plate/legend_armor_leather_lamellar_harness_reinforced",
			"plate/legend_armor_leather_lamellar_heavy",
			"plate/legend_armor_leather_lamellar_heavy_named",
			"plate/legend_armor_leather_lamellar_reinforced",
			"plate/legend_armor_leather_noble",
			"plate/legend_armor_leather_padded",
			"plate/legend_armor_leather_riveted",
			"plate/legend_armor_leather_riveted_light",
			"plate/legend_armor_leather_scale",
			"plate/legend_armor_plate_ancient_chest",
			"plate/legend_armor_plate_ancient_chest_restored",
			"plate/legend_armor_plate_ancient_gladiator",
			"plate/legend_armor_plate_ancient_harness",
			"plate/legend_armor_plate_ancient_mail",
			"plate/legend_armor_plate_ancient_scale",
			"plate/legend_armor_plate_ancient_scale_coat",
			"plate/legend_armor_plate_ancient_scale_harness",
			"plate/legend_armor_plate_chest",
			"plate/legend_armor_plate_chest_rotten",
			"plate/legend_armor_plate_cuirass",
			"plate/legend_armor_plate_full",
			"plate/legend_armor_plate_full_greaves",
			"plate/legend_armor_plate_full_greaves_named",
			"plate/legend_armor_plate_full_greaves_painted",
			"plate/legend_armor_scale",
			"plate/legend_armor_scale_coat",
			"plate/legend_armor_scale_coat_named",
			"plate/legend_armor_scale_coat_rotten",
			"plate/legend_armor_scale_shirt",
			"plate/legend_animal_hide_armor",
			"plate/legend_heavy_iron_armor",
			"plate/legend_hide_and_bone_armor",
			"plate/legend_reinforced_animal_hide_armor",
			"plate/legend_rugged_scale_armor",
			"plate/legend_scrap_metal_armor",
			"plate/legend_thick_furs_armor",
			"plate/legend_thick_plated_barbarian_armor",
			"plate/legend_southern_named_golden_plates",
			"plate/legend_southern_named_plates",
			"plate/legend_southern_plate_full",
			"plate/legend_southern_plate",
			"plate/legend_southern_padded",
			"plate/legend_southern_arm_guards",
			"plate/legend_southern_strips",
			"plate/legend_southern_leather_jacket",
			"plate/legend_southern_leather_plates",
			"plate/legend_southern_leather_scale",
			"plate/legend_southern_scale",
			"plate/legend_southern_leather_plates",
			"cloak/legend_shoulder_cloth",
			"cloak/legend_noble_shawl",
			"cloak/legend_dark_wooly_cloak",
			"cloak/legend_armor_cloak_common",
			"cloak/legend_armor_cloak_heavy",
			"cloak/legend_armor_cloak_crusader",
			"cloak/legend_armor_cloak_noble",
			"cloak/legend_sash",
			"cloak/legend_southern_scarf",
			"cloak/legend_animal_pelt",
			"cloak/legend_southern_scarf_wrap",
			"tabard/legend_common_tabard",
			"tabard/legend_noble_tabard",
			"tabard/legend_southern_wrap_right",
			"tabard/legend_southern_wrap_left",
			"tabard/legend_southern_wide_belt",
			"tabard/legend_noble_vest",
			"tabard/legend_southern_wrap",
			"tabard/legend_southern_shoulder_cloth",
			"tabard/legend_southern_overcloth",
			"tabard/legend_southern_tabard",

			"armor_upgrades/legend_additional_padding_upgrade",
			"armor_upgrades/legend_armor_stollwurm_scales_upgrade",
			"armor_upgrades/legend_armor_white_wolf_pelt_upgrade",
			"armor_upgrades/legend_barbarian_horn_upgrade",
			"armor_upgrades/legend_bone_platings_upgrade",
			"armor_upgrades/legend_direwolf_pelt_upgrade",
			"armor_upgrades/legend_double_mail_upgrade",
			"armor_upgrades/legend_heraldic_plates_upgrade",
			"armor_upgrades/legend_horn_plate_upgrade",
			"armor_upgrades/legend_joint_cover_upgrade",
			"armor_upgrades/legend_leather_neckguard_upgrade",
			"armor_upgrades/legend_leather_shoulderguards_upgrade",
			"armor_upgrades/legend_light_padding_replacement_upgrade",
			"armor_upgrades/legend_lindwurm_scales_upgrade",
			"armor_upgrades/legend_mail_patch_upgrade",
			"armor_upgrades/legend_metal_pauldrons_upgrade",
			"armor_upgrades/legend_metal_plating_upgrade",
			"armor_upgrades/legend_protective_runes_upgrade",
			"armor_upgrades/legend_unhold_fur_upgrade",

			"runes/legend_rune_endurance",
			"runes/legend_rune_resilience",
			"runes/legend_rune_safety",

			"armor/legend_armor_crusader",
			"armor/legend_armor_rabble_fur",
			"armor/legend_armor_ranger",
			"armor/legend_armor_robes_cultist",
			"armor/legend_armor_seer_robes",
			"armor/legend_armor_vala_cloak",
			"armor/legend_armor_vala_dress",
			"armor/legend_armor_warlock_cloak",
			"armor/legend_armor_werewolf_mail",

			"legendary/legend_armor_mountain",
			"legendary/legend_armor_of_davkul",
			"legendary/legend_armor_skin",
			"legendary/legend_emperors_armor",
			"legendary/legend_emperors_armor_fake",
			"legendary/legend_ijirok_armor",
			"legendary/legend_armor_named_warlock_cloak",
			"legendary/legend_lindwurm_armor",

			"named/legend_black_leather_armor",
			"named/legend_armor_named_tabard",
			"named/legend_armor_cloak_rich",
			"named/legend_armor_cloak_emperors",
			"named/legend_blue_studded_mail_armor",
			"named/legend_brown_coat_of_plates_armor",
			"named/legend_golden_scale_armor",
			"named/legend_green_coat_of_plates_armor",
			"named/legend_heraldic_mail_armor",
			"named/legend_named_bronze_armor",
			"named/legend_named_golden_lamellar_armor",
			"named/legend_named_noble_mail_armor",
			"named/legend_named_plated_fur_armor",
			"named/legend_named_sellswords_armor",
			"named/legend_named_skull_and_chain_armor"

		];

		foreach(a in armors)
		{
			local item = this.new("scripts/items/legend_armor/" + a);
			if (item.m.Variants.len() == 0)
			{
				this.logInfo("Adding " + a);
				this.World.Assets.getStash().add(item);
				continue;
			}

			for( local i = 0; i < item.m.Variants.len(); i = ++i )
			{
				this.logInfo("Adding " + a + " :: " + i);
				local vitem =  this.new("scripts/items/legend_armor/" + a);
				vitem.setVariant(item.m.Variants[i]);
				this.World.Assets.getStash().add(vitem);
			}
		}

		// local weapons = [
		// 	"legend_halberd",
		// 	"legend_military_voulge",
		// 	"legend_ranged_flail",
		// 	"legend_ranged_wooden_flail",
		// 	"legend_voulge",
		// 	"named/legend_named_voulge",
		// 	"named/legend_named_halberd",
		// 	"named/named_lute",
		// 	"named/legend_named_flail",
		// 	"named/legend_named_estoc",
		// 	"light_crossbow",
		// 	"war_bow"
		// ]

		// foreach(w in weapons)
		// {
		// 	this.logInfo("Adding " + w);
		// 	local pla = this.new("scripts/items/weapons/" + w);
		// 	this.World.Assets.getStash().add(pla);
		// }

		// for (local i = 1; i < 10; i = ++i)
		// {
		// 	local item = this.new("scripts/items/legend_armor/armor/legend_armor_heraldic");
		// 	item.setupArmor(i);
		// 	this.World.Assets.getStash().add(item);
		// }


		// local shields = [
		// 	"legend_faction_tower_shield"
		// ]

		// foreach(w in shields)
		// {
		// 	this.logInfo("Adding " + w);
		// 	local pla = this.new("scripts/items/shields/" + w);
		// 	this.World.Assets.getStash().add(pla);
		// }

		// local helmets = [
		// 	"hood/legend_helmet_barb_chain_scarf",
		// 	"hood/legend_helmet_chain_hood",
		// 	"hood/legend_helmet_chain_hood_full",
		// 	"hood/legend_helmet_chain_scarf",
		// 	"hood/legend_helmet_cloth_scarf",
		// 	"hood/legend_helmet_goblin_scarf",
		// 	"hood/legend_helmet_leather_hood",
		// 	"hood/legend_helmet_padded_hood",
		// 	"hood/legend_helmet_patched_hood",
		// 	"hood/legend_helmet_rotten_chain_scarf",
		// 	"hood/legend_helmet_simple_hood",
		// 	"hood/legend_helmet_padded_cap",
		// 	"hood/legend_helmet_hood_cloth_round",
		// 	"hood/legend_helmet_hood_cloth_square",
		// 	"hood/legend_helmet_hood_cloth_wide",
		// 	"hood/legend_helmet_cloth_long_hood",
		// 	"hood/legend_helmet_cloth_bandana",
		// 	"hood/legend_helmet_leather_cap",
		// 	"hood/legend_helmet_bronze_chain",
		// 	"helm/legend_helmet_ancient_beard_mask",
		// 	"helm/legend_helmet_ancient_conic_helm",
		// 	"helm/legend_helmet_ancient_crested",
		// 	"helm/legend_helmet_ancient_dome",
		// 	"helm/legend_helmet_ancient_dome_tailed",
		// 	"helm/legend_helmet_ancient_face_helm",
		// 	"helm/legend_helmet_ancient_face_plate",
		// 	"helm/legend_helmet_ancient_kettle",
		// 	"helm/legend_helmet_ancient_legionaire",
		// 	"helm/legend_helmet_ancient_lion_mask",
		// 	"helm/legend_helmet_ancient_mask",
		// 	"helm/legend_helmet_ancient_side_hawk",
		// 	"helm/legend_helmet_ancient_tailed_conic_helm",
		// 	"helm/legend_helmet_barbute",
		// 	"helm/legend_helmet_basinet",
		// 	"helm/legend_helmet_carthaginian",
		// 	"helm/legend_helmet_conic_helm",
		// 	"helm/legend_helmet_crude_cylinder_helm",
		// 	"helm/legend_helmet_crude_metal_helm",
		// 	"helm/legend_helmet_crude_skull_helm",
		// 	"helm/legend_helmet_flat_top_face_plate",
		// 	"helm/legend_helmet_flat_top_helm",
		// 	"helm/legend_helmet_goblin_chain_helm",
		// 	"helm/legend_helmet_goblin_leather_helm",
		// 	"helm/legend_helmet_goblin_leather_mask",
		// 	"helm/legend_helmet_goblin_spiked_helm",
		// 	"helm/legend_helmet_great_helm",
		// 	"helm/legend_helmet_heavy_plate_helm",
		// 	"helm/legend_helmet_heavy_spiked_helm",
		// 	"helm/legend_helmet_horsetail",
		// 	"helm/legend_helmet_kettle_helm",
		// 	"helm/legend_helmet_legend_ancient_gladiator",
		// 	"helm/legend_helmet_legend_ancient_legionaire_restored",
		// 	"helm/legend_helmet_legend_frogmouth",
		// 	"helm/legend_helmet_nordic_helm",
		// 	"helm/legend_helmet_norman_helm",
		// 	"helm/legend_helmet_orc_double_helm",
		// 	"helm/legend_helmet_orc_great_helm",
		// 	"helm/legend_helmet_orc_horn_mask",
		// 	"helm/legend_helmet_orc_leather_mask",
		// 	"helm/legend_helmet_orc_metal_mask",
		// 	"helm/legend_helmet_orc_strapped_helm",
		// 	"helm/legend_helmet_cult_hood",
		// 	"helm/legend_helmet_rotten_flat_top_face_mask",
		// 	"helm/legend_helmet_rotten_great_helm",
		// 	"helm/legend_helmet_sallet",
		// 	"helm/legend_helmet_skin_helm",
		// 	"helm/legend_helmet_stag_helm",
		// 	"helm/legend_helmet_swan_helm",
		// 	"helm/legend_helmet_tailed_conic",
		// 	"helm/legend_helmet_viking_helm",
		// 	"helm/legend_helmet_sack",
		// 	"helm/legend_helmet_leather_hood_barb",
		// 	"helm/legend_helmet_bronze_helm",
		// 	"helm/legend_helmet_dentist_helmet",
		// 	"top/legend_helmet_golden_helm",
		// 	"top/legend_helmet_ancient_crown",
		// 	"top/legend_helmet_goblin_leaf_helm",
		// 	"top/legend_helmet_vampire_crown",
		// 	"top/legend_helmet_chain_attachment",
		// 	"top/legend_helmet_eyemask",
		// 	"top/legend_helmet_facemask",
		// 	"top/legend_helmet_faceplate_full",
		// 	"top/legend_helmet_faceplate_gold",
		// 	"top/legend_helmet_faceplate_long",
		// 	"top/legend_helmet_faceplate_pointed",
		// 	"top/legend_helmet_faceplate_raised",
		// 	"top/legend_helmet_faceplate_short",
		// 	"top/legend_helmet_faceplate_snub_nose",
		// 	"top/legend_helmet_faceplate_winged",
		// 	"top/legend_helmet_goblin_gillie",
		// 	"top/legend_helmet_goblin_leaves",
		// 	"top/legend_helmet_headband_nose",
		// 	"top/legend_helmet_headband_side",
		// 	"top/legend_helmet_nose_plate",
		// 	"vanity/legend_helmet_antler",
		// 	"vanity/legend_helmet_bear_head",
		// 	"vanity/legend_helmet_beret",
		// 	"vanity/legend_helmet_bull_horns",
		// 	"vanity/legend_helmet_crown",
		// 	"vanity/legend_helmet_faction_helmet",
		// 	"vanity/legend_helmet_faction_helmet_2",
		// 	"vanity/legend_helmet_feather_band",
		// 	"vanity/legend_helmet_feathered_hat",
		// 	"vanity/legend_helmet_fencer_hat",
		// 	"vanity/legend_helmet_goat_horns",
		// 	"vanity/legend_helmet_headband",
		// 	"vanity/legend_helmet_horn_decorations",
		// 	"vanity/legend_helmet_hunter_cap",
		// 	"vanity/legend_helmet_impaled_head",
		// 	"vanity/legend_helmet_jester_hat",
		// 	"vanity/legend_helmet_metal_bird",
		// 	"vanity/legend_helmet_noble_buckle",
		// 	"vanity/legend_helmet_noble_feather",
		// 	"vanity/legend_helmet_noble_floppy_hat",
		// 	"vanity/legend_helmet_noble_hat",
		// 	"vanity/legend_helmet_noble_hood",
		// 	"vanity/legend_helmet_wreath",
		// 	"vanity/legend_helmet_orc_bones",
		// 	"vanity/legend_helmet_plait",
		// 	"vanity/legend_helmet_ponytail",
		// 	"vanity/legend_helmet_ram_horns",
		// 	"vanity/legend_helmet_side_feather",
		// 	"vanity/legend_helmet_straw_hat",
		// 	"vanity/legend_helmet_top_feather",
		// 	"vanity/legend_helmet_witchhunter_helm",
		// 	"vanity/legend_helmet_wizard_cowl",
		// 	"vanity/legend_helmet_wolf_helm",
		// 	"vanity_lower/legend_helmet_back_crest",
		// 	"vanity_lower/legend_helmet_back_feathers",
		// 	"vanity_lower/legend_helmet_feather_crest",
		// 	"vanity_lower/legend_helmet_knotted_tail",
		// 	"vanity_lower/legend_helmet_orc_tail",
		// 	"vanity_lower/legend_helmet_wings",
		// 	"top/legend_helmet_faceplate_curved",
		// 	"top/legend_helmet_faceplate_flat",
		// 	"top/legend_helmet_faceplate_full_gold",
		// 	"top/legend_helmet_faceplate_pointed_slit",
		// 	"top/legend_helmet_faceplate_sharp",
		// 	"top/legend_helmet_faceplate_snub_slit",
		// 	"top/legend_helmet_golden_mask",
		// 	"top/legend_helmet_warlock_skull",
		// 	"vanity/legend_helmet_white_wolf_helm",
		// 	"vanity/legend_helmet_royal_hood",
		// 	"vanity/legend_helmet_lindwurm_helm",
		// 	"vanity/legend_helmet_redback_helm",
		// 	"vanity/legend_helmet_nun_habit",
		// 	"vanity/legend_helmet_nach_helm",
		// 	"vanity/legend_helmet_mountain_helm",
		// 	"vanity/legend_helmet_demon_alp_helm",
		// 	"vanity/legend_helmet_warlock_hood",
		// ]

		// foreach(h in helmets)
		// {
		// 	local item = this.new("scripts/items/legend_helmets/" + h);

		// 	if (item.m.Variants.len() == 0)
		// 	{
		// 		this.logInfo("Adding " + h);
		// 		this.World.Assets.getStash().add(item);
		// 		continue;
		// 	}

		// 	for( local i = 0; i < item.m.Variants.len(); i = ++i )
		// 	{
		// 		this.logInfo("Adding " + h + " :: " + i);
		// 		local vitem =  this.new("scripts/items/legend_helmets/" + h);
		// 		vitem.setVariant(item.m.Variants[i]);
		// 		this.World.Assets.getStash().add(vitem);
		// 	}
		// }

	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 2), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 2), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_random_party_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.starting_scenario.onInit();
		this.World.State.getPlayer().m.BaseMovementSpeed = 500;
	}

	function onBuildPerkTree( _tree)
	{
		if (_tree == null)
		{
			return;
		}

		// _tree[0].push(this.Const.Perks.PerkDefs.LegendPiercingShot);
		// _tree[0].push(this.Const.Perks.PerkDefs.LegendMedIngredients);
		// _tree[0].push(this.Const.Perks.PerkDefs.LegendCampCook);

		foreach (i, row in this.Const.Perks.HoundmasterClassTree.Tree)
		{
			foreach (p in row)
			{
				_tree[i].push(p)
			}
		}
	}

});

