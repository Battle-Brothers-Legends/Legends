local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

if (!("ArmorObjs" in gt.Const.LegendMod))
{
    gt.Const.LegendMod.ArmorObjs <- [];
}

gt.Const.LegendMod.ArmorObjs.extend([
{
    ID = "oriental/assassin_robe", // 120
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25
            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/cloth_sash", // 20
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/gladiator_harness", // 40
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/leather_nomad_robe", // 65
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/linothorax", // 75
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/mail_and_lamellar_plating", // 135
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/nomad_robe", // 30
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/padded_mail_and_lamellar_hauberk", // 290
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/padded_vest", // 60
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/plated_nomad_mail", // 105
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/southern_long_mail_with_padding", // 200
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35
            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/southern_mail_shirt", // 110
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35
            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/stitched_nomad_armor", // 80
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron_butcher"], // 30
            [1, "cloth/legend_apron"], // 35

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/thick_nomad_robe", // 50
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron"], // 30
            [1, "cloth/legend_apron_butcher"], // 40

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "oriental/vizier_gear", // 10
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_apron"], // 30
            [1, "cloth/legend_apron_butcher"], // 40

            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_gambeson_common_color"], // 65
            [1, "cloth/legend_gambeson_named"], // 70
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_rare_color"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_peasant_dress"], // 25
            [1, "cloth/legend_robes"], // 25

            [1, "cloth/legend_robes_magic"], // 40
            [1, "cloth/legend_robes_nun"], // 22
            [1, "cloth/legend_robes_wizard"], // 40
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
            [1, "cloth/legend_thick_tunic"], // 30
            [1, "cloth/legend_tunic"], // 20
            [1, "cloth/legend_tunic_noble"], // 40
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_double_mail"], // 80
            [1, "chain/legend_armor_ancient_mail"], // 35
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_hauberk_full_named"], // 120
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_mail"], // 110
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
            [1, "plate/legend_armor_leather_brigandine"], // 65
            [1, "plate/legend_armor_leather_brigandine_hardened"], // 110
            [1, "plate/legend_armor_leather_brigandine_hardened_full"], // 140
            [1, "plate/legend_armor_leather_brigandine_named"], // 75
            [1, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
            [1, "plate/legend_armor_leather_jacket_simple"], // 15
            [1, "plate/legend_armor_leather_lamellar"], // 50
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], // 130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], // 150
            [1, "plate/legend_armor_leather_lamellar_heavy"], // 165
            [1, "plate/legend_armor_leather_lamellar_heavy_named"], // 140
            [1, "plate/legend_armor_leather_lamellar_reinforced"], // 55
            [1, "plate/legend_armor_leather_noble"], // 65
            [1, "plate/legend_armor_leather_padded"], // 40
            [1, "plate/legend_armor_leather_riveted"], // 95
            [1, "plate/legend_armor_leather_riveted_light"], // 80
            [1, "plate/legend_armor_leather_scale"], // 70

            [1, "plate/legend_armor_plate_chest"], // 125
            [1, "plate/legend_armor_plate_chest_rotten"], // 100
            [1, "plate/legend_armor_plate_cuirass"], // 150
            [1, "plate/legend_armor_plate_full"], // 160
            [1, "plate/legend_armor_plate_full_greaves"], // 170
            [1, "plate/legend_armor_plate_full_greaves_named"], // 170
            [1, "plate/legend_armor_plate_full_greaves_painted"], // 170
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
            [1, "plate/legend_armor_scale_coat_named"], // 160
            [1, "plate/legend_armor_scale_coat_rotten"], // 60
            [1, "plate/legend_armor_scale_shirt"], // 85
            [1, "plate/legend_heavy_iron_armor"], // 120
            [1, "plate/legend_hide_and_bone_armor"], // 80
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
            [1, "plate/legend_rugged_scale_armor"], // 95
            [1, "plate/legend_scrap_metal_armor"], // 65
            [1, "plate/legend_thick_furs_armor"], // 10
            [1, "plate/legend_thick_plated_barbarian_armor"], // 155
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
}
])