
local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

if (!("HelmObjs" in gt.Const.LegendMod))
{
    gt.Const.LegendMod.HelmObjs <- [];
}

gt.Const.LegendMod.HelmObjs.extend([
{
    ID = "named/death_jesters_helm", //300
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [
        [1, "helm/legend_helmet_great_helm"] //220
    ],
    Tops = [],
    Vanity = [
        [1, "vanity/legend_helmet_jester_hat"]  
    ]
}]
},{
    ID = "named/gold_and_black_turban", //290
    Script = "",
    Sets = [{
    Hoods = [ //below avg
        [1, "hood/legend_helmet_southern_niqaab"], //100
    ],
    Helms = [
        [1, "helm/legend_helmet_southern_named_conic"] //130
    ],
    Tops = [],
    Vanity = []
}]
},{ //todo  
    ID = "named/golden_feathers_helmet", //240
    Script = "",
    Sets = [{
     Hoods = [
        [1, "hood/legend_helmet_goblin_scarf"], //5
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_simple_hood"], //30
        [1, "hood/legend_helmet_hood_cloth_round"], //30
        [1, "hood/legend_helmet_hood_cloth_wide"], //30
        [1, "hood/legend_helmet_cloth_long_hood"], //30
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"], //90
        [1, "hood/legend_helmet_bronze_chain"], //100
    ],
    Helms = [
        [1, "helm/legend_helmet_ancient_conic_helm"], //15
        [1, "helm/legend_helmet_ancient_kettle"], //15
        [1, "helm/legend_helmet_ancient_dome"], //15
        [1, "helm/legend_helmet_ancient_dome_tailed"], //15
        [1, "helm/legend_helmet_ancient_face_plate"], //50
        [1, "helm/legend_helmet_ancient_legionaire"], //50
        [1, "helm/legend_helmet_ancient_side_hawk"], //50
        [1, "helm/legend_helmet_ancient_tailed_conic_helm"], //50
        [1, "helm/legend_helmet_ancient_beard_mask"], //100
        [1, "helm/legend_helmet_ancient_crested"], //100
        [1, "helm/legend_helmet_ancient_lion_mask"], //100
        [1, "helm/legend_helmet_ancient_mask"], //100
        [1, "helm/legend_helmet_ancient_face_helm"], //100
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [1, "helm/legend_helmet_orc_double_helm"], //220
        [1, "helm/legend_helmet_orc_great_helm"], //420
        [1, "helm/legend_helmet_crude_metal_helm"], //65
        [1, "helm/legend_helmet_crude_cylinder_helm"], //110
        [1, "helm/legend_helmet_heavy_plate_helm"], //170
        [1, "helm/legend_helmet_heavy_plate_helm_named"], //170
        [1, "helm/legend_helmet_crude_skull_helm"], //130
        [1, "helm/legend_helmet_heavy_spiked_helm"], //150
        [1, "helm/legend_helmet_viking_helm"], //45
        [1, "helm/legend_helmet_norman_helm"], //50
        [1, "helm/legend_helmet_flat_top_helm"], //70
        [1, "helm/legend_helmet_barbute"], //110
        [1, "helm/legend_helmet_horsetail"], //120
        [1, "helm/legend_helmet_basinet"], //130
        [1, "helm/legend_helmet_kettle_helm"], //130
        [1, "helm/legend_helmet_flat_top_face_plate"], //130
        [1, "helm/legend_helmet_carthaginian"], //160
        [1, "helm/legend_helmet_conic_helm"], //170
        [1, "helm/legend_helmet_sallet"], //185
        [1, "helm/legend_helmet_nordic_helm"], //185
        [1, "helm/legend_helmet_bronze_helm"], //190
        [1, "helm/legend_helmet_great_helm"], //220
        [1, "helm/legend_helmet_legend_armet"], //260
        [1, "helm/legend_helmet_legend_frogmouth"], //265
        [1, "helm/legend_helmet_legend_ancient_gladiator"], //115
        [1, "helm/legend_helmet_legend_ancient_legionaire_restored"], //60
        [1, "helm/legend_helmet_dentist_helmet"], //160
        [1, "helm/legend_helmet_tailed_conic"], //185
        [1, "helm/legend_helmet_legend_armet_01_named"], //260
        [1, "helm/legend_helmet_stag_helm"], //230
        [1, "helm/legend_helmet_swan_helm"], //230
        [1, "helm/legend_helmet_skin_helm"], //190
        [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150
        [1, "helm/legend_helmet_rotten_great_helm"], //160
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"], //120
        [1, "top/legend_helmet_goblin_leaves"], //5
        [1, "top/legend_helmet_goblin_leaf_helm"], //10
        [1, "top/legend_helmet_goblin_gillie"], //25
        [1, "top/legend_helmet_goblin_leather_mask"], //40
        [1, "top/legend_helmet_goblin_leather_helm"], //45
        [1, "top/legend_helmet_goblin_chain_helm"], //70
        [1, "top/legend_helmet_goblin_spiked_helm"], //90
        [1, "top/legend_helmet_vampire_crown"], //30
        [1, "top/legend_helmet_ancient_crown"], //80
        [1, "top/legend_helmet_leather_hood_barb"], //105
        [1, "top/legend_helmet_nose_plate"], //15
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
        [1, "top/legend_helmet_eyemask"], //35
        [1, "top/legend_helmet_chain_attachment"], //40
        [1, "top/legend_helmet_faceplate_flat"], //45
        [1, "top/legend_helmet_faceplate_curved"], //50
        [1, "top/legend_helmet_faceplate_short"], //60
        [1, "top/legend_helmet_cult_hood"], //65
        [1, "top/legend_helmet_faceplate_long"], //65
        [1, "top/legend_helmet_faceplate_winged"], //70
        [1, "top/legend_helmet_faceplate_snub_nose"], //75
        [1, "top/legend_helmet_faceplate_snub_slit"], //80
        [1, "top/legend_helmet_faceplate_sharp"], //85
        [1, "top/legend_helmet_facemask"], //90
        [1, "top/legend_helmet_faceplate_pointed"], //95
        [1, "top/legend_helmet_faceplate_pointed_slit"], //100
        [1, "top/legend_helmet_faceplate_full"], //110
        [1, "top/legend_helmet_faceplate_gold"], //105
        [1, "top/legend_helmet_faceplate_full_gold"], //115
        [1, "top/legend_helmet_golden_helm"], //80
        [1, "top/legend_helmet_faceplate_raised"], //55
        [1, "top/legend_helmet_faceplate_full_01_named"], //110
        [1, "top/legend_helmet_golden_mask"], //100
        [1, "top/legend_helmet_warlock_skull"], //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_hood_cloth_square"], //30
        [1, "vanity/legend_helmet_sack"], //80
        [1, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_bear_head"], //10
        [1, "vanity/legend_helmet_beret"], //10
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_crown"], //10
        [1, "vanity/legend_helmet_faction_helmet"], //10
        [1, "vanity/legend_helmet_faction_helmet_2"], //10
        [1, "vanity/legend_helmet_feather_band"], //10
        [1, "vanity/legend_helmet_feathered_hat"], //10
        [1, "vanity/legend_helmet_fencer_hat"], //10
        [1, "vanity/legend_helmet_goat_horns"], //10
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_horn_decorations"], //10
        [1, "vanity/legend_helmet_hunter_cap"], //10
        [1, "vanity/legend_helmet_impaled_head"], //10
        [1, "vanity/legend_helmet_jester_hat"], //10
        [1, "vanity/legend_helmet_metal_bird"], //10
        [1, "vanity/legend_helmet_noble_buckle"], //10
        [1, "vanity/legend_helmet_noble_feather"], //10
        [1, "vanity/legend_helmet_noble_floppy_hat"], //10
        [1, "vanity/legend_helmet_noble_hat"], //10
        [1, "vanity/legend_helmet_noble_hood"], //10
        [1, "vanity/legend_helmet_wreath"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_plait"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_side_feather"], //10
        [1, "vanity/legend_helmet_straw_hat"], //10
        [1, "vanity/legend_helmet_top_feather"], //10
        [1, "vanity/legend_helmet_witchhunter_helm"], //10
        [1, "vanity/legend_helmet_wizard_cowl"], //10
        [1, "vanity/legend_helmet_wolf_helm"], //10
        [1, "vanity/legend_helmet_white_wolf_helm"], //10
        [1, "vanity/legend_helmet_royal_hood"], //10
        [1, "vanity/legend_helmet_lindwurm_helm"], //10
        [1, "vanity/legend_helmet_redback_helm"], //10
        [1, "vanity/legend_helmet_nun_habit"], //10
        [1, "vanity/legend_helmet_nach_helm"], //10
        [1, "vanity/legend_helmet_mountain_helm"], //10
        [1, "vanity/legend_helmet_demon_alp_helm"], //10
        [1, "vanity/legend_helmet_warlock_hood"], //10
        [1, "vanity_lower/legend_helmet_back_crest"], //10
        [1, "vanity_lower/legend_helmet_back_feathers"], //10
        [1, "vanity_lower/legend_helmet_feather_crest"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_top_plume"], //10
        [1, "vanity_lower/legend_helmet_wings"], //10
    ]
}]
},{
    ID = "named/heraldic_mail_helmet", //280
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"] //90
    ],
    Helms = [
        [0, "helm/legend_helmet_crude_metal_helm"], //65
        [0, "helm/legend_helmet_crude_cylinder_helm"], //110
        [0, "helm/legend_helmet_heavy_plate_helm"], //170
        [0, "helm/legend_helmet_heavy_plate_helm_named"], //170
        [0, "helm/legend_helmet_crude_skull_helm"], //130
        [0, "helm/legend_helmet_heavy_spiked_helm"], //150
        [0, "helm/legend_helmet_viking_helm"], //45
        [0, "helm/legend_helmet_norman_helm"], //50
        [0, "helm/legend_helmet_flat_top_helm"], //70
        [0, "helm/legend_helmet_barbute"], //110
        [0, "helm/legend_helmet_horsetail"], //120
        [0, "helm/legend_helmet_basinet"], //130
        [0, "helm/legend_helmet_kettle_helm"], //130
        [0, "helm/legend_helmet_flat_top_face_plate"], //130
        [0, "helm/legend_helmet_carthaginian"], //160
        [0, "helm/legend_helmet_conic_helm"], //170
        [0, "helm/legend_helmet_sallet"], //185
        [0, "helm/legend_helmet_nordic_helm"], //185
        [0, "helm/legend_helmet_bronze_helm"], //190
        [0, "helm/legend_helmet_great_helm"], //220
        [0, "helm/legend_helmet_legend_armet"], //260
        [0, "helm/legend_helmet_legend_frogmouth"], //265
        [0, "helm/legend_helmet_legend_ancient_gladiator"], //115
        [0, "helm/legend_helmet_legend_ancient_legionaire_restored"], //60
        [0, "helm/legend_helmet_dentist_helmet"], //160
        [0, "helm/legend_helmet_tailed_conic"], //185
        [0, "helm/legend_helmet_legend_armet_01_named"], //260
        [0, "helm/legend_helmet_stag_helm"], //230
        [0, "helm/legend_helmet_swan_helm"], //230
        [0, "helm/legend_helmet_skin_helm"], //190
        [0, "helm/legend_helmet_rotten_flat_top_face_mask"], //150
        [0, "helm/legend_helmet_rotten_great_helm"], //160
    ],
    Tops = [
        [1, "top/legend_helmet_faceplate_raised"] //55
    ],
    Vanity = [
        [1, "vanity/legend_helmet_side_feather"], //10
        [1, "vanity/legend_helmet_top_feather"], //10
        [1, "vanity_lower/legend_helmet_back_crest"], //10
        [1, "vanity_lower/legend_helmet_top_plume"] //10
    ]
}]
},{
    ID = "named/jugglers_hat", //50
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_padded_cap"] //40
    ]
    Helms = [],
    Tops = [],
    Vanity = [
        [1, "vanity/legend_helmet_jester_hat"] //10
    ]
}]
},{
    ID = "named/jugglers_padded_hat", //75
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [],
    Tops = [],
    Vanity = [
        [1, "vanity/legend_helmet_jester_hat"] //10
    ]
}]
},{
    ID = "named/legend_frogmouth_helm_crested_painted", //345
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [
        [1, "helm/legend_helmet_legend_frogmouth"] //265
    ],
    Tops = [
    ],
    Vanity = [
        [1, "vanity/legend_helmet_side_feather"], //10
        [1, "vanity/legend_helmet_top_feather"], //10
        [1, "vanity_lower/legend_helmet_back_crest"], //10
        [1, "vanity_lower/legend_helmet_top_plume"] //10
    ]
}]
},{
    ID = "named/legend_frogmouth_helm_decorated", //330
    Script = "",
    Sets = [{
    Hoods = [
        [4, "hood/legend_helmet_leather_hood"], //45
        [5, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_chain_scarf"] //70
    ],
    Helms = [
        [1, "helm/legend_helmet_legend_frogmouth"] //265
    ],
    Tops = [],
    Vanity = []
}]
},{
    ID = "named/legend_mountain_helmet_named", //300.0
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_scarf"], //70
    ],
    Helms = [
        [1, "helm/legend_helmet_great_helm"] //220
    ],
    Tops = [
    ],
    Vanity = [
        [1, "vanity/legend_helmet_mountain_helm"] //10
    ]
}]
},{
    ID = "named/legend_named_warlock_hood", //180
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [
    ],
    Tops = [
        [1, "top/legend_helmet_warlock_skull"] //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_warlock_hood"] //10
    ]
}]
},{
    ID = "named/lindwurm_helmet", //265
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_scarf"] //70
    ],
    Helms = [
        [1, "helm/legend_helmet_great_helm"] //220
    ],
    Tops = [
    ],
    Vanity = [
        [1, "vanity/legend_helmet_lindwurm_helm"] //10
    ]
}]
},{
    ID = "named/named_conic_helmet_with_faceguard", //280
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [
        [1, "helm/legend_helmet_basinet"] //130
    ],
    Tops = [
        [1, "top/legend_helmet_facemask"] //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_plait"] //10
    ]
}]
},{
    ID = "named/named_metal_bull_helmet", //300
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_bronze_chain"] //100
    ],
    Helms = [
        [1, "helm/legend_helmet_heavy_plate_helm_named"] //170
    ],
    Tops = [
        [0, "top/legend_helmet_orc_leather_mask"], //35
        [0, "top/legend_helmet_orc_horn_mask"], //60
        [0, "top/legend_helmet_orc_metal_mask"], //120
        [0, "top/legend_helmet_goblin_leaves"], //5
        [0, "top/legend_helmet_goblin_leaf_helm"], //10
        [0, "top/legend_helmet_goblin_gillie"], //25
        [0, "top/legend_helmet_goblin_leather_mask"], //40
        [0, "top/legend_helmet_goblin_leather_helm"], //45
        [0, "top/legend_helmet_goblin_chain_helm"], //70
        [0, "top/legend_helmet_goblin_spiked_helm"], //90
        [0, "top/legend_helmet_vampire_crown"], //30
        [0, "top/legend_helmet_ancient_crown"], //80
        [0, "top/legend_helmet_leather_hood_barb"], //105
        [0, "top/legend_helmet_nose_plate"], //15
        [0, "top/legend_helmet_headband_side"], //20
        [0, "top/legend_helmet_headband_nose"], //30
        [0, "top/legend_helmet_eyemask"], //35
        [0, "top/legend_helmet_chain_attachment"], //40
        [0, "top/legend_helmet_faceplate_flat"], //45
        [0, "top/legend_helmet_faceplate_curved"], //50
        [0, "top/legend_helmet_faceplate_short"], //60
        [0, "top/legend_helmet_cult_hood"], //65
        [0, "top/legend_helmet_faceplate_long"], //65
        [0, "top/legend_helmet_faceplate_winged"], //70
        [0, "top/legend_helmet_faceplate_snub_nose"], //75
        [0, "top/legend_helmet_faceplate_snub_slit"], //80
        [0, "top/legend_helmet_faceplate_sharp"], //85
        [0, "top/legend_helmet_facemask"], //90
        [0, "top/legend_helmet_faceplate_pointed"], //95
        [0, "top/legend_helmet_faceplate_pointed_slit"], //100
        [0, "top/legend_helmet_faceplate_full"], //110
        [0, "top/legend_helmet_faceplate_gold"], //105
        [0, "top/legend_helmet_faceplate_full_gold"], //115
        [0, "top/legend_helmet_golden_helm"], //80
        [0, "top/legend_helmet_faceplate_raised"], //55
        [0, "top/legend_helmet_faceplate_full_01_named"], //110
        [0, "top/legend_helmet_golden_mask"], //100
        [0, "top/legend_helmet_warlock_skull"], //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_bull_horns"] //10
    ]
}]
},{
    ID = "named/named_metal_nose_horn_helmet", //230
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [
        [1, "helm/legend_helmet_heavy_spiked_helm"] //150
    ],
    Tops = [],
    Vanity = []
}]
},{
    ID = "named/named_metal_skull_helmet", //210
    Script = "",
    Sets = [{
    Hoods = [
        [2, "hood/legend_helmet_barb_chain_scarf"], //55
        [2, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_bronze_chain"] //100
    ],
    Helms = [
        [1, "helm/legend_helmet_crude_skull_helm"], //130
    ],
    Tops = [
    ],
    Vanity = [
    ]
}]
},{
    ID = "named/named_nordic_helmet_with_closed_mail", //265
    Script = "",
    Sets = [{
    Hoods = [
        [2, "hood/legend_helmet_chain_scarf"], //70
        [6, "hood/legend_helmet_chain_hood"], //80
        [2, "hood/legend_helmet_chain_hood_full"], //90
    ],
    Helms = [
        [1, "helm/legend_helmet_nordic_helm"] //185
    ],
    Tops = [],
    Vanity = []
}]
},{
    ID = "named/named_steppe_helmet_with_mail", //200
    Script = "",
    Sets = [{ //todo atm its same as below but its closest i can get
    Hoods = [
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [
        [1, "helm/legend_helmet_tailed_conic"] //185
    ],
    Tops = [],
    Vanity = []
}]
},{
    ID = "named/nasal_feather_helmet", //265
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [
        [1, "helm/legend_helmet_tailed_conic"] //185
    ],
    Tops = [],
    Vanity = []
}]
},{
    ID = "named/norse_helmet", //125
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [
        [1, "helm/legend_helmet_viking_helm"] //45
    ]
    Tops = [],
    Vanity = [ //missing like 15 s i'm gonna just give it a nice vanity (:
        [1, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_beret"], //10
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_feather_band"], //10
        [1, "vanity/legend_helmet_feathered_hat"], //10
        [1, "vanity/legend_helmet_fencer_hat"], //10
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_plait"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
    ]
}]
},{
    ID = "named/red_and_gold_band_helmet", //255
    Script = "", //todo
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_goblin_scarf"], //5
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_simple_hood"], //30
        [1, "hood/legend_helmet_hood_cloth_round"], //30
        [1, "hood/legend_helmet_hood_cloth_wide"], //30
        [1, "hood/legend_helmet_cloth_long_hood"], //30
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"], //90
        [1, "hood/legend_helmet_bronze_chain"], //100
    ],
    Helms = [
        [1, "helm/legend_helmet_ancient_conic_helm"], //15
        [1, "helm/legend_helmet_ancient_kettle"], //15
        [1, "helm/legend_helmet_ancient_dome"], //15
        [1, "helm/legend_helmet_ancient_dome_tailed"], //15
        [1, "helm/legend_helmet_ancient_face_plate"], //50
        [1, "helm/legend_helmet_ancient_legionaire"], //50
        [1, "helm/legend_helmet_ancient_side_hawk"], //50
        [1, "helm/legend_helmet_ancient_tailed_conic_helm"], //50
        [1, "helm/legend_helmet_ancient_beard_mask"], //100
        [1, "helm/legend_helmet_ancient_crested"], //100
        [1, "helm/legend_helmet_ancient_lion_mask"], //100
        [1, "helm/legend_helmet_ancient_mask"], //100
        [1, "helm/legend_helmet_ancient_face_helm"], //100
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [1, "helm/legend_helmet_orc_double_helm"], //220
        [1, "helm/legend_helmet_orc_great_helm"], //420
        [1, "helm/legend_helmet_crude_metal_helm"], //65
        [1, "helm/legend_helmet_crude_cylinder_helm"], //110
        [1, "helm/legend_helmet_heavy_plate_helm"], //170
        [1, "helm/legend_helmet_heavy_plate_helm_named"], //170
        [1, "helm/legend_helmet_crude_skull_helm"], //130
        [1, "helm/legend_helmet_heavy_spiked_helm"], //150
        [1, "helm/legend_helmet_viking_helm"], //45
        [1, "helm/legend_helmet_norman_helm"], //50
        [1, "helm/legend_helmet_flat_top_helm"], //70
        [1, "helm/legend_helmet_barbute"], //110
        [1, "helm/legend_helmet_horsetail"], //120
        [1, "helm/legend_helmet_basinet"], //130
        [1, "helm/legend_helmet_kettle_helm"], //130
        [1, "helm/legend_helmet_flat_top_face_plate"], //130
        [1, "helm/legend_helmet_carthaginian"], //160
        [1, "helm/legend_helmet_conic_helm"], //170
        [1, "helm/legend_helmet_sallet"], //185
        [1, "helm/legend_helmet_nordic_helm"], //185
        [1, "helm/legend_helmet_bronze_helm"], //190
        [1, "helm/legend_helmet_great_helm"], //220
        [1, "helm/legend_helmet_legend_armet"], //260
        [1, "helm/legend_helmet_legend_frogmouth"], //265
        [1, "helm/legend_helmet_legend_ancient_gladiator"], //115
        [1, "helm/legend_helmet_legend_ancient_legionaire_restored"], //60
        [1, "helm/legend_helmet_dentist_helmet"], //160
        [1, "helm/legend_helmet_tailed_conic"], //185
        [1, "helm/legend_helmet_legend_armet_01_named"], //260
        [1, "helm/legend_helmet_stag_helm"], //230
        [1, "helm/legend_helmet_swan_helm"], //230
        [1, "helm/legend_helmet_skin_helm"], //190
        [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150
        [1, "helm/legend_helmet_rotten_great_helm"], //160
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"], //120
        [1, "top/legend_helmet_goblin_leaves"], //5
        [1, "top/legend_helmet_goblin_leaf_helm"], //10
        [1, "top/legend_helmet_goblin_gillie"], //25
        [1, "top/legend_helmet_goblin_leather_mask"], //40
        [1, "top/legend_helmet_goblin_leather_helm"], //45
        [1, "top/legend_helmet_goblin_chain_helm"], //70
        [1, "top/legend_helmet_goblin_spiked_helm"], //90
        [1, "top/legend_helmet_vampire_crown"], //30
        [1, "top/legend_helmet_ancient_crown"], //80
        [1, "top/legend_helmet_leather_hood_barb"], //105
        [1, "top/legend_helmet_nose_plate"], //15
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
        [1, "top/legend_helmet_eyemask"], //35
        [1, "top/legend_helmet_chain_attachment"], //40
        [1, "top/legend_helmet_faceplate_flat"], //45
        [1, "top/legend_helmet_faceplate_curved"], //50
        [1, "top/legend_helmet_faceplate_short"], //60
        [1, "top/legend_helmet_cult_hood"], //65
        [1, "top/legend_helmet_faceplate_long"], //65
        [1, "top/legend_helmet_faceplate_winged"], //70
        [1, "top/legend_helmet_faceplate_snub_nose"], //75
        [1, "top/legend_helmet_faceplate_snub_slit"], //80
        [1, "top/legend_helmet_faceplate_sharp"], //85
        [1, "top/legend_helmet_facemask"], //90
        [1, "top/legend_helmet_faceplate_pointed"], //95
        [1, "top/legend_helmet_faceplate_pointed_slit"], //100
        [1, "top/legend_helmet_faceplate_full"], //110
        [1, "top/legend_helmet_faceplate_gold"], //105
        [1, "top/legend_helmet_faceplate_full_gold"], //115
        [1, "top/legend_helmet_golden_helm"], //80
        [1, "top/legend_helmet_faceplate_raised"], //55
        [1, "top/legend_helmet_faceplate_full_01_named"], //110
        [1, "top/legend_helmet_golden_mask"], //100
        [1, "top/legend_helmet_warlock_skull"], //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_hood_cloth_square"], //30
        [1, "vanity/legend_helmet_sack"], //80
        [1, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_bear_head"], //10
        [1, "vanity/legend_helmet_beret"], //10
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_crown"], //10
        [1, "vanity/legend_helmet_faction_helmet"], //10
        [1, "vanity/legend_helmet_faction_helmet_2"], //10
        [1, "vanity/legend_helmet_feather_band"], //10
        [1, "vanity/legend_helmet_feathered_hat"], //10
        [1, "vanity/legend_helmet_fencer_hat"], //10
        [1, "vanity/legend_helmet_goat_horns"], //10
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_horn_decorations"], //10
        [1, "vanity/legend_helmet_hunter_cap"], //10
        [1, "vanity/legend_helmet_impaled_head"], //10
        [1, "vanity/legend_helmet_jester_hat"], //10
        [1, "vanity/legend_helmet_metal_bird"], //10
        [1, "vanity/legend_helmet_noble_buckle"], //10
        [1, "vanity/legend_helmet_noble_feather"], //10
        [1, "vanity/legend_helmet_noble_floppy_hat"], //10
        [1, "vanity/legend_helmet_noble_hat"], //10
        [1, "vanity/legend_helmet_noble_hood"], //10
        [1, "vanity/legend_helmet_wreath"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_plait"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_side_feather"], //10
        [1, "vanity/legend_helmet_straw_hat"], //10
        [1, "vanity/legend_helmet_top_feather"], //10
        [1, "vanity/legend_helmet_witchhunter_helm"], //10
        [1, "vanity/legend_helmet_wizard_cowl"], //10
        [1, "vanity/legend_helmet_wolf_helm"], //10
        [1, "vanity/legend_helmet_white_wolf_helm"], //10
        [1, "vanity/legend_helmet_royal_hood"], //10
        [1, "vanity/legend_helmet_lindwurm_helm"], //10
        [1, "vanity/legend_helmet_redback_helm"], //10
        [1, "vanity/legend_helmet_nun_habit"], //10
        [1, "vanity/legend_helmet_nach_helm"], //10
        [1, "vanity/legend_helmet_mountain_helm"], //10
        [1, "vanity/legend_helmet_demon_alp_helm"], //10
        [1, "vanity/legend_helmet_warlock_hood"], //10
        [1, "vanity_lower/legend_helmet_back_crest"], //10
        [1, "vanity_lower/legend_helmet_back_feathers"], //10
        [1, "vanity_lower/legend_helmet_feather_crest"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_top_plume"], //10
        [1, "vanity_lower/legend_helmet_wings"], //10
    ]
}]
},{
    ID = "named/sallet_green_helmet", //265
    Script = "", 
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [
        [1, "helm/legend_helmet_sallet"] //185
    ],
    Tops = [],
    Vanity = [
        [1, "vanity/legend_helmet_headband"],
        [1, "vanity/legend_helmet_plait"] //10
    ]
}]
},{
    ID = "named/witchhunter_helm", //140
    Script = "", //off but it's fine i guess?
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_padded_hood"] //50
    ],
    Helms = [
        [0, "helm/legend_helmet_ancient_conic_helm"], //15
        [0, "helm/legend_helmet_ancient_kettle"], //15
        [0, "helm/legend_helmet_ancient_dome"], //15
        [0, "helm/legend_helmet_ancient_dome_tailed"], //15
        [0, "helm/legend_helmet_ancient_face_plate"], //50
        [0, "helm/legend_helmet_ancient_legionaire"], //50
        [0, "helm/legend_helmet_ancient_side_hawk"], //50
        [0, "helm/legend_helmet_ancient_tailed_conic_helm"], //50
        [0, "helm/legend_helmet_ancient_beard_mask"], //100
        [0, "helm/legend_helmet_ancient_crested"], //100
        [0, "helm/legend_helmet_ancient_lion_mask"], //100
        [0, "helm/legend_helmet_ancient_mask"], //100
        [0, "helm/legend_helmet_ancient_face_helm"], //100
        [0, "helm/legend_helmet_orc_strapped_helm"], //160
        [0, "helm/legend_helmet_orc_double_helm"], //220
        [0, "helm/legend_helmet_orc_great_helm"], //420
        [0, "helm/legend_helmet_crude_metal_helm"], //65
        [0, "helm/legend_helmet_crude_cylinder_helm"], //110
        [0, "helm/legend_helmet_heavy_plate_helm"], //170
        [0, "helm/legend_helmet_heavy_plate_helm_named"], //170
        [0, "helm/legend_helmet_crude_skull_helm"], //130
        [0, "helm/legend_helmet_heavy_spiked_helm"], //150
        [0, "helm/legend_helmet_viking_helm"], //45
        [0, "helm/legend_helmet_norman_helm"], //50
        [0, "helm/legend_helmet_flat_top_helm"], //70
        [0, "helm/legend_helmet_barbute"], //110
        [0, "helm/legend_helmet_horsetail"], //120
        [0, "helm/legend_helmet_basinet"], //130
        [0, "helm/legend_helmet_kettle_helm"], //130
        [0, "helm/legend_helmet_flat_top_face_plate"], //130
        [0, "helm/legend_helmet_carthaginian"], //160
        [0, "helm/legend_helmet_conic_helm"], //170
        [0, "helm/legend_helmet_sallet"], //185
        [0, "helm/legend_helmet_nordic_helm"], //185
        [0, "helm/legend_helmet_bronze_helm"], //190
        [0, "helm/legend_helmet_great_helm"], //220
        [0, "helm/legend_helmet_legend_armet"], //260
        [0, "helm/legend_helmet_legend_frogmouth"], //265
        [0, "helm/legend_helmet_legend_ancient_gladiator"], //115
        [0, "helm/legend_helmet_legend_ancient_legionaire_restored"], //60
        [0, "helm/legend_helmet_dentist_helmet"], //160
        [0, "helm/legend_helmet_tailed_conic"], //185
        [0, "helm/legend_helmet_legend_armet_01_named"], //260
        [0, "helm/legend_helmet_stag_helm"], //230
        [0, "helm/legend_helmet_swan_helm"], //230
        [0, "helm/legend_helmet_skin_helm"], //190
        [0, "helm/legend_helmet_rotten_flat_top_face_mask"], //150
        [0, "helm/legend_helmet_rotten_great_helm"], //160
    ],
    Tops = [

    ],
    Vanity = [
        [1, "vanity/legend_helmet_witchhunter_helm"] //10
    ]
}]
},{
    ID = "named/wolf_helmet", //140
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"], //90
    ],
    Helms = [],
    Tops = [],
    Vanity = [
        [1, "vanity/legend_helmet_wolf_helm"] //10
    ]
}]
}])