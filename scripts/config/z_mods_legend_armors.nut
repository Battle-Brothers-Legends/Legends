local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

if (!("ArmorObjs" in gt.Const.LegendMod))
{
    gt.Const.LegendMod.ArmorObjs <- [];
}

gt.Const.LegendMod.ArmorObjs.extend([{
    ID = "apron",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron"]
        ],
        Chain = [
        ],
        Plate = [
            [12, ""],
            [1, "plate/legend_armor_leather_jacket"],
            [1, "plate/legend_armor_leather_jacket_simple"]
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "basic_mail_shirt",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_tunic_wrap"],
            [1, "cloth/legend_tunic_collar_thin"],
            [1, "cloth/legend_tunic_collar_deep"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_gambeson_plain"],
        ],
        Chain = [
            [1, "chain/legend_armor_mail_shirt"],
			[1, "chain/legend_armor_mail_shirt_simple"]
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "blotched_gambeson",
    Script = "",
    Sets = [{
        Cloth = [
            [10, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_gambeson_wolf"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "butcher_apron",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron_butcher"],
        ],
        Chain = [
        ],
        Plate = [
            [12, ""],
            [1, "plate/legend_armor_leather_jacket"],
            [1, "plate/legend_armor_leather_jacket_simple"]
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "coat_of_plates", //320 : 297 average, 65 + 110 + 170 + 10 = 355 absolute max, 240 absolute min
    Script = "",
    Sets = [{
        Cloth = [ //60
            [1, "cloth/legend_gambeson"], //65 
            [5, "cloth/legend_padded_surcoat"] //55
            // [5, "cloth/legend_tunic"]
        ],
        Chain = [ //66.25 if [2,""] removed : 44 with : 80 with commented things
            // [2, ""],
            [1, "chain/legend_armor_mail_shirt"], //50
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
            [1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"] //80
        ],
        Plate = [ //157 avg
            [1, "plate/legend_armor_plate_chest"], //125
            [0, "plate/legend_armor_plate_chest_rotten"],
            [1, "plate/legend_armor_plate_cuirass"], //150
            [1, "plate/legend_armor_plate_full"], //160
			[1, "plate/legend_armor_plate_milanese"], //170
			[1, "plate/legend_armor_plate_krastenbrust"], //170
			[1, "plate/legend_armor_plate_triangle"] //170
        ],
        Cloak = [
            [20, ""],
            [1, "cloak/legend_armor_cloak_common"]
        ],
        Tabard = [

        ],
        Attachments =[
        ]
    }]
},{
    ID = "coat_of_scales", //300 : new max of 290ish, new avg of 240 ish, 
    Script = "",
    Sets = [{
        Cloth = [ //60
            [1, "cloth/legend_gambeson"], //65
            [1, "cloth/legend_padded_surcoat"] //55
            // [1, "cloth/legend_tunic"] //20
        ],
        Chain = [ //66.25 if [2,""] removed : 44 with : 80 with commented things
            // [2, ""], //0
            [1, "chain/legend_armor_mail_shirt"], //50
			// [1, "chain/legend_armor_mail_shirt_simple"], //25
            [1, "chain/legend_armor_reinforced_mail"], //110
			[1, "chain/legend_armor_reinforced_mail_shirt"] //80
        ]
        Plate = [ //100
            [1, "plate/legend_armor_scale"],  //100
            [1, "plate/legend_armor_scale_coat"], //120
            [0, "plate/legend_armor_scale_coat_rotten"],
            [1, "plate/legend_armor_scale_shirt"] //85
        ],
        Cloak = [ //1
            [20, ""],
            [1, "cloak/legend_armor_cloak_common"],
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "cultist_leather_robe",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes"]
        ],
        Chain = [
        ],
        Plate = [
		   [1, "plate/legend_armor_cult_armor"]
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "decayed_coat_of_plates",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_sackcloth_patched"],
            [1, "cloth/legend_sackcloth_tattered"],
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_robes"],
        ],
        Chain = [
            [2, ""],
            [1, "chain/legend_armor_reinforced_worn_mail"],
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"],
            [1, "chain/legend_armor_rusty_mail_shirt"],
        ],
        Plate = [
            [1, "plate/legend_armor_scale_coat_rotten"],
            [1, "plate/legend_armor_plate_chest_rotten"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "decayed_coat_of_scales",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_sackcloth_patched"],
            [1, "cloth/legend_sackcloth_tattered"],
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_robes"],
        ],
        Chain = [
            [2, ""],
            [1, "chain/legend_armor_reinforced_worn_mail"],
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"],
            [1, "chain/legend_armor_rusty_mail_shirt"],
        ],
        Plate = [
            [1, "plate/legend_armor_scale_coat_rotten"],
            [1, "plate/legend_armor_plate_chest_rotten"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "decayed_reinforced_mail_hauberk",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_sackcloth_patched"],
            [1, "cloth/legend_sackcloth_tattered"],
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_robes"],
        ],
        Chain = [
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"],
            [1, "chain/legend_armor_reinforced_worn_mail"],
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"],
        ],
        Plate = [
            [1, ""],
            [1, "chain/legend_armor_hauberk_sleevless"],
            [1, "chain/legend_armor_hauberk"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "footman_armor",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_robes"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
            [1, "chain/legend_armor_basic_mail"],
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_mail_shirt_simple"],
            [1, "chain/legend_armor_reinforced_mail"],
            [1, "chain/legend_armor_reinforced_mail_shirt"],
            [1, "chain/legend_armor_short_mail"],
        ],
        Plate = [
            [1, "plate/legend_armor_leather_riveted_light"],
        ],
        Cloak = [
            [20, ""],
            [1, "cloak/legend_armor_cloak_common"],
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "gambeson",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "heavy_lamellar_armor", //285 ; 262 avg
    Script = "",
    Sets = [{
        Cloth = [ //avg of 60
            [1, "cloth/legend_gambeson"], // 65
            [1, "cloth/legend_padded_surcoat"] //55
        ],
        Chain = [ //77avg
            [1, "chain/legend_armor_basic_mail"], //85
            [1, "chain/legend_armor_mail_shirt"], //50
            [1, "chain/legend_armor_reinforced_mail"], //110
            [1, "chain/legend_armor_reinforced_mail_shirt"], //80
            [1, "chain/legend_armor_short_mail"] //60
        ],
        Plate = [//125
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], //130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], //150
            [1, "plate/legend_armor_leather_lamellar_heavy"], //165
            [1, "plate/legend_armor_leather_lamellar_reinforced"] //55
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "heraldic_mail",
    Script = "scripts/items/legend_armor/armor/legend_armor_heraldic", //Nothing in vanilla seems to use this?
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "lamellar_harness",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_robes"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
            [1, ""],
            [1, "chain/legend_armor_basic_mail"],
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_mail_shirt_simple"],
            [1, "chain/legend_armor_short_mail"],
        ],
        Plate = [
            [1, "plate/legend_armor_leather_lamellar"],
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"],
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"],
            [1, "plate/legend_armor_leather_lamellar_heavy"],
            [1, "plate/legend_armor_leather_lamellar_reinforced"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "leather_lamellar",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_robes"],
            [10, "cloth/legend_tunic"],
        ],
        Chain = [
            [10, ""],
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_mail_shirt_simple"],
        ],
        Plate = [
            [1, "plate/legend_armor_leather_lamellar"],
            [1, "plate/legend_armor_leather_lamellar_reinforced"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "leather_scale_armor",
    Script = "",
    Sets = [{
        Cloth = [
            [2, "cloth/legend_gambeson"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
            [4, ""],
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_mail_shirt_simple"],
        ],
        Plate = [
            [1, "plate/legend_armor_leather_scale"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "leather_tunic",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_armor_leather_jacket"],
            [1, "plate/legend_armor_leather_jacket_simple"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "leather_wraps",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
            [15, ""],
            [1, "plate/legend_armor_leather_jacket"],
            [5, "plate/legend_armor_leather_jacket_simple"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_blacksmith_apron",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron"],
        ],
        Chain = [
        ],
        Plate = [
            [15, ""],
            [1, "plate/legend_armor_leather_jacket"],
            [5, "plate/legend_armor_leather_jacket_simple"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_crusader_armor",
    Script = "scripts/items/legend_armor/armor/legend_armor_crusader",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_herbalist_robe",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "monk_robe",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_maid_apron",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron"],
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_maid_dress",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_peasant_dress"],
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_nun_robe_dark",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes_nun"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_nun_robe_light",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes_nun"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_rabble_fur",
    Script = "",
    Sets = [{
        Cloth = [
			[1, "armor/legend_armor_rabble_fur"]
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_rabble_tunic",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"],
            [1, "cloth/legend_sackcloth_patched"],
            [1, "cloth/legend_sackcloth_tattered"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_ranger_armor",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "armor/legend_armor_ranger"]
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_seer_robes",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes"],
            [1, "cloth/legend_robes_magic"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_taxidermist_apron",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_vala_cloak",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "armor/legend_armor_vala_cloak"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_vala_dress",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "armor/legend_armor_vala_dress"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_vampire_lord_armor",
    Script = "scripts/items/armor/legend_vampire_lord_armor",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "legend_warlock_cloak",
    Script = "scripts/items/armor/legend_warlock_cloak",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "light_scale_armor",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_armor_scale"],
            [1, "plate/legend_armor_scale_shirt"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "linen_tunic",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "mail_hauberk",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson"],
            [1, "cloth/legend_padded_surcoat"],
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
            [1, ""],
            [1, "chain/legend_armor_hauberk"],
            [1, "chain/legend_armor_hauberk_full"],
            [1, "chain/legend_armor_hauberk_sleevless"],
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "mail_shirt",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"],
        ],
        Chain = [
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_mail_shirt_simple"],
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "necromancer_robes",
    Script = "scripts/items/armor/necromancer_robes",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "noble_gear",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic_noble"]
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "noble_mail_armor",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic_noble"]
        ],
        Chain = [
            [1, "chain/legend_armor_hauberk_sleevless"],
            [1, "chain/legend_armor_mail_shirt"],
            [1, "chain/legend_armor_short_mail"],
        ],
        Plate = [
            [1, "plate/legend_armor_leather_noble"],
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "noble_tunic",
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic_noble"]
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "padded_leather", // 80
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_apron"], // 30
            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_padded_surcoat"], // 55
            [1, "cloth/legend_thick_tunic"], // 30
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_armor_leather_padded"], // 40
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "padded_surcoat", // 50
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "patched_mail_shirt", // 90
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_gambeson_wolf"], // 70
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "ragged_dark_surcoat", // 60
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_thick_tunic"], // 30
        ],
        Chain = [
        ],
        Plate = [
            [10, ""],
            [3, "plate/legend_animal_hide_armor"], // 30
            [3, "plate/legend_armor_leather_jacket"], // 25
            [1, "plate/legend_armor_leather_jacket_named"], // 30
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "ragged_surcoat", // 55
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"], // 20
        ],
        Chain = [
            [2, ""],
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
        ],
        Plate = [
            [1, "plate/legend_armor_leather_jacket"], // 25
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "reinforced_mail_hauberk", // 210
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
            [4, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
        ],
        Plate = [
            [1, "plate/legend_armor_leather_brigandine"], // 65
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "sackcloth", // 10
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "scale_armor", // 240
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
            [1, "plate/legend_armor_scale"], // 100
            [1, "plate/legend_armor_scale_coat"], // 120
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "sellsword_armor", // 260
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
            [1, "chain/legend_armor_hauberk"], // 95
            [1, "chain/legend_armor_hauberk_full"], // 115
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_worn_mail"], // 105
        ],
        Plate = [
             [1, "plate/legend_armor_leather_riveted"], // 95
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "tattered_sackcloth", // 5
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth_tattered"], // 5
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "thick_dark_tunic", // 35
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_dark_tunic"], // 35
            [1, "cloth/legend_thick_tunic"], // 30
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "thick_tunic", // 35
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_thick_tunic"], // 30
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "werewolf_hide_armor", // 100
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_wolf"], // 70
        ],
        Chain = [
        ],
        Plate = [
            [10, ""],
            [5, "plate/legend_animal_hide_armor"], // 30
            [4, "plate/legend_armor_leather_jacket"], // 25
            // [1, "plate/legend_armor_leather_jacket_named"], // 30
            [4, "plate/legend_armor_leather_jacket_simple"], // 15
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
            [1, "armor_upgrades/legend_direwolf_pelt_upgrade"], // 10
        ]
    }]
},{
    ID = "werewolf_mail_armor", // 140
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_wolf"], // 70
        ],
        Chain = [
            [1, "chain/legend_armor_basic_mail"], // 85
            [1, "chain/legend_armor_hauberk_sleevless"], // 65
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_reinforced_mail_shirt"], // 80
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"], // 65
            [1, "chain/legend_armor_short_mail"], // 60
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
            [1, "armor_upgrades/legend_direwolf_pelt_upgrade"], // 10
        ]
    }]
},{
    ID = "wizard_robe", // 20
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes_magic"], // 40
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "worn_mail_shirt", // 110
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"], // 65
            [1, "cloth/legend_padded_surcoat"], // 55
        ],
        Chain = [
            [1, "chain/legend_armor_mail_shirt"], // 50
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "seedmaster_noble_armor", // 110
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_robes"],
            [1, "cloth/legend_tunic_noble"]
        ],
        Chain = [
            [4, "chain/legend_armor_mail_shirt"], // 50
            [2, "chain/legend_armor_reinforced_mail"], // 50
            [4, "chain/legend_armor_reinforced_mail_shirt"]
            
        ],
        Plate = [
            [4, "plate/legend_armor_leather_riveted_light"],
            [6, "plate/legend_armor_leather_scale"],
            [6, "plate/legend_armor_scale_shirt"]
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
            [15, ""],
            [5, "armor_upgrades/legend_leather_neckguard_upgrade"],
            [5, "armor_upgrades/legend_mail_patch_upgrade"],
            [2, "armor_upgrades/legend_metal_pauldrons_upgrade"]
        ]
    }]
},{
    ID = "citreneking_noble_armor", // 110
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"],
            [1, "cloth/legend_robes"],
            [1, "cloth/legend_tunic_noble"]
        ],
        Chain = [
            [4, "chain/legend_armor_basic_mail"], // 50
            [2, "chain/legend_armor_reinforced_mail"], // 50
            [4, "chain/legend_armor_reinforced_mail_shirt"]
            
        ],
        Plate = [
            [4, ""],
            [1, "plate/legend_armor_leather_riveted"],
            [1, "plate/legend_armor_leather_riveted_light"]
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
            [15, ""],
            [5, "armor_upgrades/legend_leather_neckguard_upgrade"],
            [5, "armor_upgrades/legend_mail_patch_upgrade"],
            [2, "armor_upgrades/legend_joint_cover_upgrade"]
        ]
    }]
},{
    ID = "brown_hedgeknight_armor", // 292
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson_plain"]
        ],
        Chain = [
            [1, "chain/legend_armor_basic_mail"]
            
        ],
        Plate = [
            [1, "plate/legend_armor_plate_chest"]
        ],
        Cloak = [
        ],
        Tabard = [
            [1, "tabard/legend_southern_wrap_left", 6]
        ],
        Attachments =[
            [1, "armor_upgrades/legend_double_mail_upgrade"]
        ]
    }]
},{
    ID = "red_bandit_leader_armor", // 215
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_padded_surcoat_plain", 41],
            [1, "cloth/legend_padded_surcoat_plain", 17]
        ],
        Chain = [
            [1, "chain/legend_armor_basic_mail"]
        ],
        Plate = [
            [1, "plate/legend_armor_scale"]
        ],
        Cloak = [
        ],
        Tabard = [
            [1, "tabard/legend_southern_wrap_left", 6]
        ],
        Attachments =[
            [1, "armor_upgrades/legend_mail_patch_upgrade"]
        ]
    }]
},{
    ID = "southern_knight_armor", // 215
    Script = "",
    Sets = [{
        Cloth = [
            [10, "cloth/legend_southern_robe"],
            [10, "cloth/legend_southern_split_gambeson"],
            [10, "cloth/legend_southern_gambeson"],
            [5, "cloth/legend_southern_tunic"],
            [5, "cloth/legend_gambeson"],
            [2, "cloth/legend_gambeson_plain"],
            [2, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_southern_mail"]
        ],
        Plate = [
            [1, "plate/legend_southern_plate_full"]
        ],
        Cloak = [
            [1, ""],
            [1, "cloak/legend_southern_scarf"],
            [1, "cloak/legend_animal_pelt"],
            [1, "cloak/legend_southern_scarf_wrap"]
        ],
        Tabard = [
            [3, ""],
            [2, "tabard/legend_southern_wrap_left"],
            [1, "tabard/legend_southern_wrap"],
            [1, "tabard/legend_southern_shoulder_cloth"]
        ],
        Attachments =[
            [6, ""],
            [4, "armor_upgrades/legend_mail_patch_upgrade"]
        ]
    }]
},{
    ID = "northern_mercenary_armor_00", // heavier than 01 ~200
    Script = "",
    Sets = [{
        Cloth = [
            [2, "cloth/legend_gambeson"],
            [2, "cloth/legend_gambeson_plain"],
            [5, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_armor_hauberk"],
            [1, "chain/legend_armor_hauberk_full"]
        ],
        Plate = [
            [8, ""],
            [1, "plate/legend_armor_scale_coat_rotten"],
            [1, "plate/legend_armor_scale_shirt"]
        ],
        Cloak = [
            [1, ""],
            [2, "tabard/legend_shoulder_cloth", 2]
        ],
        Tabard = [
            
        ],
        Attachments =[
            [0, ""],
            [4, "armor_upgrades/legend_double_mail_upgrade"],
            [4, "armor_upgrades/legend_direwolf_pelt_upgrade"]
        ]
    }]
},{
    ID = "northern_mercenary_armor_01", // lighter than 00 ~170
    Script = "",
    Sets = [{
        Cloth = [
            [2, "cloth/legend_gambeson"],
            [2, "cloth/legend_gambeson_plain"],
            [5, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_armor_reinforced_mail"],
            [1, "chain/legend_armor_reinforced_mail_shirt"],
            [1, "chain/legend_armor_reinforced_worn_mail"]
        ],
        Plate = [
            [0, "plate/legend_southern_plate_full"]
        ],
        Cloak = [
            [1, ""],
            [2, "tabard/legend_shoulder_cloth", 2]
        ],
        Tabard = [
            
        ],
        Attachments =[
            [0, ""],
            [4, "armor_upgrades/legend_metal_plating_upgrade"],
            [4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
        ]
    }]
},{
    ID = "northern_mercenary_armor_02", // ~~250
    Script = "",
    Sets = [{
        Cloth = [
            [2, "cloth/legend_gambeson"],
            [2, "cloth/legend_gambeson_plain"],
            [5, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_armor_reinforced_mail"],
            [1, "chain/legend_armor_reinforced_mail_shirt"],
            [1, "chain/legend_armor_reinforced_worn_mail"]
        ],
        Plate = [
            [0, "plate/legend_southern_plate_full"]
        ],
        Cloak = [
            [1, ""],
            [2, "tabard/legend_shoulder_cloth", 2]
        ],
        Tabard = [
            
        ],
        Attachments =[
            [0, ""],
            [4, "armor_upgrades/legend_metal_plating_upgrade"],
            [4, "armor_upgrades/legend_leather_shoulderguards_upgrade"]
        ]
    }]
},{
    ID = "barbarian_chosen_armor_00", // ~~186
    Script = "",
    Sets = [{
        Cloth = [
            [2, "cloth/legend_gambeson"],
            [5, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_armor_ancient_mail"]
        ],
        Plate = [
            [1, "plate/legend_hide_and_bone_armor"]
        ],
        Cloak = [
        ],
        Tabard = [
            
        ],
        Attachments =[
            [0, ""],
            [4, "armor_upgrades/legend_bone_platings_upgrade"]
        ]
    }]
},
{
    ID = "barbarian_chosen_armor_01", // ~~186
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_gambeson"],
            [4, "cloth/legend_padded_surcoat"],
            [4, "cloth/legend_padded_surcoat_plain"],
            [1, "cloth/legend_gambeson_wolf"]
        ],
        Chain = [
            [1, "chain/legend_armor_reinforced_worn_mail_shirt"],
            [1, "chain/legend_armor_ancient_double_mail", 1],
        ],
        Plate = [
            [1, "plate/legend_scrap_metal_armor"],
            [1, "plate/legend_rugged_scale_armor"],
            [1, "plate/legend_heavy_iron_armor"],
        ],
        Cloak = [
            [1, ""],
            [1, "cloak/legend_southern_shoulder_cloth", 7],
            [1, "cloak/legend_southern_wrap"]
        ],
        Tabard = [
            [1, "tabard/legend_southern_scarf", 7],
            [1, "tabard/legend_southern_scarf", 6],
            [1, "tabard/legend_southern_scarf", 13],
            [1, "tabard/legend_dark_wooly_cloak", 13],
        ],
        Attachments =[
            [4, ""],
            [1, "armor_upgrades/legend_bone_platings_upgrade"],
            [1, "armor_upgrades/legend_direwolf_pelt_upgrade"],
        ]
    }]
},
{
    ID = "brown_monk_armor_00", // ~~186
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_robes", 1]
        ],
        Chain = [
        ],
        Plate = [
            [2, ""],
            [1, "plate/legend_armor_leather_jacket_simple"]
        ],
        Cloak = [
            [2, ""],
            [1, "cloak/legend_southern_shoulder_cloth", 7],
            [1, "cloak/legend_southern_shoulder_cloth", 6]
        ],
        Tabard = [
            [1, "tabard/legend_southern_wrap_left", 6]
        ],
        Attachments =[
            [9, ""],
            [1, "armor_upgrades/legend_leather_neckguard_upgrade"]
        ]
    }]
},
{
    ID = "dark_southern_armor_00", // ~~186
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_tunic_wrap"],
            [1, "cloth/legend_tunic_collar_thin"],
            [1, "cloth/legend_tunic_collar_deep"]
        ],
        Chain = [
            [1, "chain/legend_armor_short_mail"]
        ],
        Plate = [
        ],
        Cloak = [
            [1, "cloak/legend_animal_pelt", 4]
        ],
        Tabard = [
            [1, "tabard/legend_southern_overcloth"]
        ],
        Attachments =[
        ]
    }]
},
{
    ID = "white_nomad_leader_armor_00", // ~~186
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_thick_tunic"],
            [1, "cloth/legend_tunic"],
            [1, "cloth/legend_tunic_wrap"],
            [1, "cloth/legend_tunic_collar_thin"],
            [1, "cloth/legend_tunic_collar_deep"]
        ],
        Chain = [
            [1, "chain/legend_southern_mail"],
        ],
        Plate = [
            
            [1, "plate/legend_armor_leather_lamellar_harness_heavy"], //130
            [1, "plate/legend_armor_leather_lamellar_harness_reinforced"], //150
            [1, "plate/legend_southern_scale"],// 155
        ],
        Cloak = [
            [3, ""],
            [1, "cloak/legend_southern_scarf"],// 5
        ],
        Tabard = [
            [2, ""],
            [1, "tabard/legend_southern_shoulder_cloth"],// 5
            [1, "tabard/legend_southern_wrap"],// 5
            [1, "tabard/legend_southern_shoulder_cloth"],// 5
        ],
        Attachments =[
        ]
    }]
},
{
    ID = "special/heraldic_armor", // 250
    Script = "scripts/items/legend_armor/armor/legend_armor_heraldic",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "special/wardog_armor", // 55
    Script = "",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "special/wardog_heavy_armor", // 85
    Script = "",
    Sets = [{
        Cloth = [
        ],
        Chain = [
        ],
        Plate = [
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
}]);

gt.Const.LegendMod.Armors <- {};

foreach( i, v in gt.Const.LegendMod.ArmorObjs )
{
	gt.Const.LegendMod.Armors[v.ID] <- v;
}

