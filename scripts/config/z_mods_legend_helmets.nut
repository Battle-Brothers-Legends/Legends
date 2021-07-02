
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
        ID = "aketon_cap", //40, -1, 0 , 70
        Script = "",
        Sets = [{
            Hoods = [
                [1, "hood/legend_helmet_padded_cap"] // 40, -1, 0
            ],
            Helms = [
            ],
            Tops = [
            ],
            Vanity = [
            ]
        }]
    },{
        ID = "barbute_helmet", //190, -9, -2, 2600
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_cap"], // 40, -1, 0, 70
            [1, "hood/legend_helmet_leather_hood"], //45, -2, 0,
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [3, "hood/legend_helmet_open_chain_hood"] //60, -3, 0, 200
        ],
        Helms = [
            [1, "helm/legend_helmet_barbute"] //130, -7, -2
        ],
        Tops = [],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_feather_band"],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "theamson_barbute_helmet", //172 ish, -10, -2
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_enclave_bevor"] //95, -7, 0
        ],
        Helms = [
            [1, "helm/legend_helmet_barbute"] //75, -3, -2
        ],
        Tops = [],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "bascinet_with_mail", //210, -13, -2, 1400
        Script = "",
        Sets = [{
            Hoods = [
                [1, "hood/legend_helmet_open_chain_hood"], //75, -4, 0
                [1, "hood/legend_helmet_chain_hood"], //80, -5, 0
                [1, "hood/legend_helmet_chain_hood_full"], //90, -6, 375
            ],
            Helms = [
                [1, "helm/legend_helmet_basinet"], // 130, -8, -1
            ],
            Tops = [],
            Vanity = [
                [5, ""],
                [2, "vanity/legend_helmet_plait"]
            ]
        }]
    },{
        ID = "closed_flat_top_helmet", //170, -10, -3, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [2, "hood/legend_helmet_simple_hood"], //30, -1
            [2, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
            [1, "hood/legend_helmet_leather_hood"], // 45, -2, 0 //40
            [1, "hood/legend_helmet_padded_hood"] //50, -2
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm_low"] //90, -6, -1
        ],
        Tops = [
            [1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
        ],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "closed_flat_top_with_neckguard", //180, -11, -3,
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_simple_hood"], //30, -1
            [1, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
            [2, "hood/legend_helmet_leather_hood"], // 45, -2, 0 //40
            [2, "hood/legend_helmet_padded_hood"] //50, -2
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm"] //100, -6, -1
        ],
        Tops = [
            [1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
        ],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "closed_flat_top_with_mail", //280, -19, -3
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
        ],
        Tops = [
            [1, "top/legend_helmet_faceplate_flat"] //30, -2, -2
        ],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "closed_mail_coif", //90, -4, 250
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5
        ],
        Helms = [],
        Tops = [
            [1, "top/legend_helmet_chain_attachment"] //20, 0, 0
        ],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{ //started here
        ID = "conic_helmet_with_closed_mail", //265, -18, -2, 2600
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
            [1, "hood/legend_helmet_southern_chain_hood"], //85, -5
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6
        ],
        Helms = [
            [1, "helm/legend_helmet_conic_helm"], //150, -11, -1
        ],
        Tops = [
            [1, "top/legend_helmet_eyemask"], //20, -1, -1
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "conic_helmet_with_faceguard", //280, -19, -3, 3000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
            [1, "hood/legend_helmet_southern_chain_hood"], //85, -5
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6
        ],
        Helms = [
            [1, "helm/legend_helmet_conic_helm"], //150, -11, -1
        ],
        Tops = [
            [1, "top/legend_helmet_facemask"], //40, -2, -2
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "cultist_hood", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_cap"],
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_sack"], //20
        ]
    }]
    },{
        ID = "cultist_leather_hood", //60
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_cap"]
        ],
        Helms = [
        ],
        Tops = [
            [1, "top/legend_helmet_cult_hood"], //50
        ],
        Vanity = [
        ]
    }]
    },{ //avg of 32 dura
        ID = "dark_cowl", //40
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"] // 10
        ],
        Helms = [],
        Tops = [
            [1, "top/legend_helmet_hood_cloth_round"], //10
            [1, "top/legend_helmet_hood_cloth_wide"], //10
            [1, "top/legend_helmet_hood_cloth_square"], //10
            [1, "top/legend_helmet_cloth_long_hood"], //10
        ],
        Vanity = [
            [1, ""],
            [1, "vanity/legend_helmet_wizard_cowl"]
        ]
    }]
    },{
        ID = "decayed_closed_flat_top_with_mail", //230, -19, -3, 1250
        Script = "",
        Sets = [{
        Hoods = [ //60 need 170
            [3, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
            [1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
        ],
        Helms = [ //150 need 20
            [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
        ],
        Tops = [
            [1, "top/legend_helmet_hood_cloth_round"], //10, -1, 0
            [1, "top/legend_helmet_hood_cloth_wide"], //10
            [1, "top/legend_helmet_hood_cloth_square"], //10
            [1, "top/legend_helmet_cloth_long_hood"], //10
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "decayed_closed_flat_top_with_sack", //230, -19, 3
        Script = "",
        Sets = [{
        Hoods = [ //60 need 170
            [3, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
            [1, "hood/legend_helmet_barb_chain_scarf"], //55, -2, 0
        ],
        Helms = [ //150 need 20
            [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_sack"], //20, 0, -1
        ]
    }]
    },{
        ID = "decayed_full_helm", //240, -20, -3
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
            [1, "hood/legend_helmet_rusty_chain_hood"], //60, -3, 0
        ],
        Helms = [
            [1, "helm/legend_helmet_rotten_great_helm"] //160, -15, -3
        ],
        Tops = [
            [4, ""],
            [1, "top/legend_helmet_hood_cloth_round"], //10, -1, 0
            [1, "top/legend_helmet_hood_cloth_wide"], //10
            [1, "top/legend_helmet_hood_cloth_square"], //10
            [1, "top/legend_helmet_cloth_long_hood"], //10
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "decayed_great_helm", //255, -22, -3
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_rotten_chain_scarf"], //60, -3, 0
            [1, "hood/legend_helmet_rusty_chain_hood"], //60, -3, 0
        ],
        Helms = [
            [1, "helm/legend_helmet_rotten_flat_top_face_mask"], //150, -14, -3
            [1, "helm/legend_helmet_rotten_great_helm"] //160, -15, -3
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_decayed_helmet"], //10, -1, 0
        ]
    }]
    },{ //adds up to 100 only; maybe todo
        ID = "dented_nasal_helmet", //110, -7, -1, 350
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_hood"], //45, -2, 0
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
        ],
        Helms = [
            [1, "helm/legend_helmet_norman_helm"], //60, -4, -1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "faction_helm",
        Script = "scripts/items/legend_helmets/helmets/legend_faction_helmet",
        Sets = [{
        Hoods = [
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{ //
        ID = "feathered_hat", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_feathered_hat"] //10
        ]
    }]
    },{
        ID = "flat_top_helmet", //125, -7, -1
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_simple_hood"], //30, -1
            [1, "hood/legend_helmet_padded_cap"], // 40, -1, 0 //40
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm_low"] //90, -6, -1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "flat_top_with_mail", //230, -15, -2, 1800
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
        ],
        Tops = [
        ],
        Vanity = [
            [5, ""],
            [1, "vanity/legend_helmet_headband"],
            [1, "vanity/legend_helmet_plait"] //10
        ]
    }]
    },{
        ID = "flat_top_with_closed_mail", //265, -18, -2, 2600
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm_polished"] //150, -11, -1
        ],
        Tops = [
            [1, "top/legend_helmet_chain_attachment"] //20, -1
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "full_aketon_cap", //50
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"]
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "full_helm", //300, -20, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "legend_helm_wings", //340, -24, -2, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_winged"], //70, -6, -1

		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_snub", //320, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[3, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_short", //320, -22, -2, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_short"] //20, -2, 0
		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_point", //350, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"] //35, -1, -2
		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_full", //350, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_full"], //57, -1, -1
		],
        Vanity = [
			[1, "vanity/legend_helmet_noble_feather"], //10
			[1, "vanity/legend_helmet_noble_buckle"], //10
			[1, ""] //10
		]
    }]
    },{
        ID = "legend_helm_curved", //325, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_curved"], //25, -4, -2
		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_breathed", //320, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_faceplate_full_breaths"], //25, 0, -1
		],
        Vanity = []
    }]
    },{
        ID = "legend_helm_bearded", //320, -21, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80, -5, 0, 310
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"] //220, -15, -3, 3000
        ],
        Tops = [
			[1, "top/legend_helmet_southern_faceplate_bearded"], //50, -1, -2
		],
        Vanity = []
    }]
    },{
        ID = "full_leather_cap", //45
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_hood"] //45
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "greatsword_faction_helm", //160, -7, -1
        Script = "scripts/items/legend_helmets/helmets/legend_greatsword_faction_helmet",
        Sets = []
    },{
        ID = "greatsword_hat", //70, -3
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0,
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_fencerhat"] //20, -1, 0
        ]
    }]
    },{
        ID = "headscarf", //20
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"] //10
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "hood", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_simple_hood"] //30
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "hunters_hat", //35
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"], //10
            [1, "hood/legend_helmet_patched_hood"], //25
        ],
        Helms = [],
        Tops = [],
        Vanity = [
            [1, "vanity/legend_helmet_hunter_cap"] //10
        ]
    }]
    },{
        ID = "jesters_hat", //35
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"], //10
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_bandana"], //15
            [1, "hood/legend_helmet_patched_hood"], //25
            [1, "hood/legend_helmet_simple_hood"] //30
        ],
        Helms = [],
        Tops = [],
        Vanity = [
            [1, "vanity/legend_helmet_jester_hat"] //10
        ]
    }]
    },{
        ID = "kettle_hat_with_closed_mail", //250, -17, -2 , 2200
        Script = "",
        Sets = [{
        Hoods = [ //avg slightly below 70, need 200
            [1, "hood/legend_helmet_chain_hood"],//80, -5
            [1, "hood/legend_helmet_chain_hood_full"],//90, -6
        ],
        Helms = [
            [1, "helm/legend_helmet_enclave_kettle"] //150, -11, -2
        ],
        Tops = [
            [1, "top/legend_helmet_chain_attachment"], //20, -1
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "kettle_hat_with_mail", //215, -14, -2, 1500
        Script = "",
        Sets = [{
        Hoods = [ //avg slightly below 70, need 200
            [1, "hood/legend_helmet_aventail"], // 60, -4, 0
            [1, "hood/legend_helmet_open_chain_hood"],//75, -4,
            [3, "hood/legend_helmet_chain_hood"],//80, -5,
        ],
        Helms = [
            [1, "helm/legend_helmet_kettle_helm_high"],
        ],
        Tops = [
            [1, ""],
            [1, "top/legend_helmet_chain_attachment"]
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "kettle_hat", //115, -6, -1, 450
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_patched_hood"], //25
            [1, "hood/legend_helmet_simple_hood"] //30
        ],
        Helms = [
            [1, "helm/legend_helmet_kettle_helm_low"] //85
        ],
        Tops = [],
        Vanity = [  ]
    }]
    },{
        ID = "legend_frogmouth_helm_crested", //340
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"], //75
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_legend_armet"], //260
            [1, "helm/legend_helmet_legend_frogmouth"] //265
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_side_feather"], //10
            [1, "vanity/legend_helmet_top_feather"] //10
        ]
    }]
    },{
        ID = "legend_frogmouth_helm", //330
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"], //75
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_legend_armet"], //260
            [1, "helm/legend_helmet_legend_frogmouth"] //265
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "legend_nun_habit", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"],
            [1, "hood/legend_helmet_cloth_bandana"], //15
            [1, "hood/legend_helmet_patched_hood"] //25
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_nun_habit"] //10
        ]
    }]
    },{ //way under durability
        ID = "legend_seer_hat", //80
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_bandana"], //15
            [1, "hood/legend_helmet_patched_hood"], //25
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_wizard_cowl"] //10
        ]
    }]
    },{
        ID = "legend_vampire_lord_helmet", //50
        Script = "scripts/items/helmets/legend_vampire_lord_helmet",
        Sets = [{
        Hoods = [
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "legend_warlock_hood", //100
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_cap"]
        ],
        Helms = [],
        Tops = [
            [1, "top/legend_helmet_warlock_skull"] //90
        ],
        Vanity = [
            [1, "vanity/legend_helmet_warlock_hood"] //10
        ]
    }]
    },{
        ID = "magician_hat", //50
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_cap"] //40
        ],
        Helms = [],
        Tops = [],
        Vanity = [
            [1, "vanity/legend_helmet_wizard_cowl"] //10
        ]
    }]
    },{
        ID = "mail_coif", //80
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "mouth_piece", //10
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf"] //10

        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "nasal_helmet_with_closed_mail", //240, -16, -2
        Script = "",
        Sets = [{
        Hoods = [ //way below avg
            [1, "hood/legend_helmet_chain_hood"],//80
            [1, "hood/legend_helmet_chain_hood_full"] // 90, -6,
        ],
        Helms = [
           [1, "helm/legend_helmet_italo_norman_helm"], //150, -12, -1
        ],
        Tops = [

        ],
        Vanity = [
        ]
    }]
    },{
        ID = "nasal_helmet_with_mail", //200, -12, -2
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"], //70
            [4, "hood/legend_helmet_chain_hood"],//80, -5
            [4, "hood/legend_helmet_chain_hood_full"] // 90, -6,
        ],
        Helms = [
            [1, "helm/legend_helmet_norman_helm"] //70, -4, -1
        ],
        Tops = [
            [1, ""],
            [1, "top/legend_helmet_chain_attachment"] // 20, -1
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "nasal_helmet_with_rusty_mail", //140, -9, -2
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_barb_chain_scarf"], //55
            [1, "hood/legend_helmet_rotten_chain_scarf"],//60, -4
            [3, "hood/legend_helmet_rusty_chain_hood"], //70 -3
        ],
        Helms = [
            [1, "helm/legend_helmet_norman_helm"] //70, -4, -1
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_headband"]
        ]
    }]
    },{
        ID = "nasal_helmet", //105, -5, -1, 350
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_patched_hood"], //25, -1
            [1, "hood/legend_helmet_simple_hood"], //30, -1

        ],
        Helms = [
            [1, "helm/legend_helmet_norman_helm"] //70,-4 -1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "necromancer_hat", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"], // 10
            [1, "hood/legend_helmet_cloth_bandana"] //15
        ],
        Helms = [],
        Tops = [
            [1, "top/legend_helmet_hood_cloth_round"], //10
            [1, "top/legend_helmet_hood_cloth_wide"], //10
            [1, "top/legend_helmet_hood_cloth_square"], //10
            [1, "top/legend_helmet_cloth_long_hood"], //10
        ],
        Vanity = [
            // [1, "vanity/legend_helmet_witchhunter_helm"] //10
        ]
    }]
    },{
        ID = "noble_arrow_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 2] //10
        ]
    }]
    },{
        ID = "noble_bull_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 3] //10
        ]
    }]
    },{
        ID = "noble_castle_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 1] //10
        ]
    }]
    },{
        ID = "noble_deer_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 8] //10
        ]
    }]
    },{
        ID = "noble_dragon_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 10] //10
        ]
    }]
    },{
        ID = "noble_feather_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 5] //10
        ]
    }]
    },{
        ID = "noble_fish_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 7] //10
        ]
    }]
    },{
        ID = "noble_headgear", //10
        Script = "scripts/items/helmets/noble_headgear",
        Sets = [{
        Hoods = [
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "noble_lion_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 4] //10
        ]
    }]
    },{
        ID = "noble_sun_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 9] //10
        ]
    }]
    },{
        ID = "noble_swan_helm", //300
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"] //80
        ],
        Helms = [
            [1, "helm/legend_helmet_great_helm"], //220
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_faction_helmet", 6] //10
        ]
    }]
    },{
        ID = "nordic_helmet_with_closed_mail", //265, -18, -2
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"], //60
            [1, "hood/legend_helmet_chain_hood"],//80, -5
            [1, "hood/legend_helmet_chain_hood_full"] // 90, -6,
        ],
        Helms = [
            [1, "helm/legend_helmet_nordic_helm_high"] //175
        ],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "nordic_helmet", //125, -7, -1
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_simple_hood"] //30
        ],
        Helms = [
            [1, "helm/legend_helmet_nordic_helm_low"] //95, -6, -1
        ],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "open_leather_cap", //40
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"] //35
        ],
        Helms = [],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "padded_flat_top_helmet", //150, -9, -1
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_cap"], // 40, -1, 0
            [1, "hood/legend_helmet_padded_hood"] //50
        ],
        Helms = [
            [1, "helm/legend_helmet_flat_top_helm"] //100, -6, -1
        ],
        Tops = [
        ],
        Vanity = []
    }]
    },{
        ID = "padded_kettle_hat", //140, -8, -1
        Script = "",
        Sets = [{
        Hoods = [ //bit over
            [1, "hood/legend_helmet_padded_cap"], // 40, -1, 0
            [1, "hood/legend_helmet_padded_hood"] //50
        ],
        Helms = [
            [1, "helm/legend_helmet_kettle_helm_med"] //95, -7
        ],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "padded_nasal_helmet", //130, -7, -1
        Script = "",
        Sets = [{
        Hoods = [ //bit over
            [1, "hood/legend_helmet_padded_cap"], // 40, --1, 0 //40
            [1, "hood/legend_helmet_padded_hood"] //50
        ],
        Helms = [
            [1, "helm/legend_helmet_norman_helm"] //70, -4, -1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "reinforced_mail_coif", //100, -5, -1
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"], //80, -5
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6
        ],
        Helms = [
        ],
        Tops = [
            [1, "top/legend_helmet_chain_attachment"], //20, -1
            [1, "top/legend_helmet_nose_plate"] //20, -1, 0
        ],
        Vanity = []
    }]
    },{
        ID = "rusty_mail_coif", //70, -4
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_rusty_chain_hood"]
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "sallet_helmet", //120, -5
        Script = "",
        Sets = [{
        Hoods = [
            [2, "hood/legend_helmet_cloth_cap"],
            [1, "hood/legend_helmet_cloth_bandana"] //15
        ],
        Helms = [
            [1, "helm/legend_helmet_sallet"] //110, -5,
        ],
        Tops = [],
        Vanity = []
    }]
    },{
        ID = "steppe_helmet_with_mail", //200, -12, -2, 1250
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"], // 75, -4, 0
            [1, "hood/legend_helmet_chain_hood"], //80, -5, 0
        ],
        Helms = [
            [1, "helm/legend_helmet_horsetail"] //120, -7, -1
        ],
        Tops = [],
        Vanity = [
            [1, "vanity/legend_helmet_headband"], //10
            [9, ""]
        ]
    }]
    },{
        ID = "straw_hat", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"],
            [1, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_bandana"], //15
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_straw_hat"], //10
        ]
    }]
    },{
        ID = "witchhunter_hat", //40
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"] // 10
        ],
        Helms = [],
        Tops = [
            [1, "top/legend_helmet_hood_cloth_round"], //10
            [1, "top/legend_helmet_hood_cloth_wide"], //10
            [1, "top/legend_helmet_hood_cloth_square"], //10
            [1, "top/legend_helmet_cloth_long_hood"], //10
        ],
        Vanity = [
            // [1, "vanity/legend_helmet_witchhunter_helm"] //10
        ]
    }]
    },{
        ID = "legend_noble_crown", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
          [1, "vanity/legend_helmet_crown"] //10
        ]
    }]
    },{
        ID = "legend_noble_hood", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
        ],
        Vanity = [
          [1, "vanity/legend_helmet_noble_hood"] //10
        ]
    }]
    },{
        ID = "legend_noble_hat", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
       ],
        Vanity = [
          [1, "vanity/legend_helmet_noble_hat"] //10
        ]
    }]
    },{
        ID = "legend_noble_floppy_hat", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
       ],
        Vanity = [
          [1, "vanity/legend_helmet_noble_hat"] //10
        ]
    }]
    },{
        ID = "legend_noble_southern_crown", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
		],
        Vanity = [
          [1, "vanity/legend_helmet_noble_southern_crown"] //10
        ]
    }]
    },{
        ID = "legend_noble_southern_hat", //70
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_bandana"], //15,
            [2, "hood/legend_helmet_cloth_cap"] //10
        ],
        Helms = [
        ],
        Tops = [
		],
        Vanity = [
          [1, "vanity/legend_helmet_noble_southern_hat"] //10
        ]
    }]
    },{
        ID = "wizard_hat", //30
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_cap"], // 10
            [1, "hood/legend_helmet_cloth_bandana"] //15
        ],
        Helms = [],
        Tops = [],
        Vanity = [
            [1, "vanity/legend_helmet_wizard_cowl"] //10
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_armet_01", //300,-20, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_armet"] //130, -6, -1
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_armet_02", //270, -19, -2, 2900
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_armet"] //130, -6, -1
        ],
        Tops = [
            [1, "top/legend_helmet_enclave_armet_visor"] //40, -3, 0
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_great_bascinet_01", //330, -24, -3, 2600
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_venitian_bascinet"] //260, -13, -2
        ],
        Tops = [
            [2, ""],
            [2, "top/legend_helmet_enclave_venitian_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
            [1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"], //35, -1, -2
            [1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_great_bascinet_02", //340, -25, -2, 2800
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_great_bascinet"] //260, -13, -2
        ],
        Tops = [
            [10, ""],
            [2, "top/legend_helmet_enclave_great_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
            [1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"], //35, -1, -2
            [1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_great_bascinet_03", //365, -26, -3, 3200
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_great_bascinet"] //210, -15, -2
        ],
        Tops = [
            [2, ""],
            [2, "top/legend_helmet_enclave_great_bascinet_visor"], //40, -3, 0
			[1, "top/legend_helmet_faceplate_pointed"], //25, -1, -1
            [1, "top/legend_helmet_faceplate_flat"], //22, -1, -1
			[1, "top/legend_helmet_faceplate_pointed_slit"],//35, -1, -2
            [1, "top/legend_helmet_faceplate_snub_nose"], //20, -1, -1
			[1, "top/legend_helmet_faceplate_snub_slit"] //40, -2, -1
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_great_helm_01", //300, -20, -3, 3500
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_great_helm"] //220, -15, -3
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity_lower/legend_helmet_back_feathers"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_kettle_sallet_01", //280, -19, -3, 3000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
            [1, "hood/legend_helmet_chain_hood"], //80, -4, 0
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_kettle_sallet_02", //270, -18, -2, 2700
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_enclave_bevor"] //100, -7, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_kettle_sallet_03", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_open_chain_hood"], //75, -4
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_kettle"] //140, -7, -2
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },{
        ID = "legend_enclave_vanilla_skullcap_01", //245, -17, -1, 2600
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"],
            [1, "hood/legend_helmet_chain_hood_full"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_enclave_skullcap"] //120, -12, -1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },
    {
        ID = "legend_champion_butcher_helmet", //approx 130, -7,
        Script = "",
        Sets = [{
            Hoods = [
                [1, "hood/legend_helmet_chain_scarf"], //70, -4
                [1, "hood/legend_helmet_aventail"]
            ],
            Helms = [
            ],
            Tops = [
                [1, "top/legend_helmet_facemask"], //60, -2, -1
                [1, "top/legend_helmet_faceplate_flat"] //57, -4, -2
            ],
            Vanity = [
            ]
        }]
    },{
        ID = "italo_norman_helm", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_southern_open_chain_hood"], //65, -3, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_italo_norman_helm"] //150, -7, -2
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },{
        ID = "scale_helm", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
            [1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_scale_helm"] //75. -5. 1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "rondel_helm", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
            [1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_rondel_helm"] //75. -5. 1
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
    },{
        ID = "deep_sallet", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_chain_hood_full"], //90, -6, 0
            [1, "hood/legend_helmet_southern_chain_hood"] //90, -6, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_deep_sallet"] //75. -5. 1
        ],
        Tops = [
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },
	{
        ID = "wallace_sallet", //170, -10, -2, 1000
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_padded_hood"], //50, -2, 0
            [1, "hood/legend_helmet_aventail"],
            [1, "hood/legend_helmet_southern_open_chain_hood"], //65, -3, 0
        ],
        Helms = [
             [1, "helm/legend_helmet_wallace_sallet"] //140, -7, -2
        ],
        Tops = [
               [1, "top/legend_helmet_wallace_sallet_visor"] //60, -2, -1
        ],
        Vanity = [
            [10, ""],
            [1, "vanity/legend_helmet_noble_feather"],
            [1, "vanity/legend_helmet_side_feather"],
            [1, "vanity/legend_helmet_plait"], //10
            [1, "vanity/legend_helmet_noble_feather"],

            [1, "vanity/legend_helmet_top_feather"],
        ]
    }]
    },
	{
        ID = "red_bandit_leader_helmet", //215
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood_full"]
        ],
        Helms = [
            [1, "helm/legend_helmet_barbute"] //140, -7, -2
        ],
        Tops = [
            [1, "top/legend_helmet_wallace_sallet_visor"] //60, -2, -1
        ],
        Vanity = [
            [1, "vanity/legend_helmet_headband", 1],
        ]
    }]
    },
	{
        ID = "brown_hedgeknight_helmet", //179
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood_full"]
        ],
        Helms = [
            [1, "helm/legend_helmet_nordic_helm_low"] //140, -7, -2
        ],
        Tops = [
        ],
        Vanity = [
            [1, "vanity/legend_helmet_plait", 7],
        ]
    }]
    },
	{
        ID = "southern_knight_helmet", //200 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_southern_chain_hood"],
            [1, "hood/legend_helmet_southern_open_chain_hood"]
        ],
        Helms = [
            [1, "helm/legend_helmet_conic_helm"] //140, -7, -2
        ],
        Tops = [
            [1, "top/legend_helmet_facemask"]
        ],
        Vanity = [
            [1, "vanity/legend_helmet_southern_patterned_headwrap"],
            [1, "vanity/legend_helmet_southern_turban_open"],
            [1, "vanity/legend_helmet_southern_turban_full"],
            [1, "vanity/legend_helmet_southern_turban_feather"]
        ]
    }]
    },
	{
        ID = "northern_mercenary_helmet_00", //200 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_open_chain_hood"],
            [1, "hood/legend_helmet_rusty_chain_hood"],
            [1, "hood/legend_helmet_chain_hood"],
            [1, "hood/legend_helmet_chain_hood_full"]
        ],
        Helms = [
            [1, "helm/legend_helmet_nordic_helm_low"], 
            [1, "helm/legend_helmet_nordic_helm"], 
            [1, "helm/legend_helmet_nordic_helm_high"] 
        ],
        Tops = [
            [0, "top/legend_helmet_facemask"]
        ],
        Vanity = [
            [0, "vanity/legend_helmet_southern_patterned_headwrap"],
            [0, "vanity/legend_helmet_southern_turban_open"],
            [0, "vanity/legend_helmet_southern_turban_full"],
            [0, "vanity/legend_helmet_southern_turban_feather"]
        ]
    }]
    },
	{
        ID = "northern_mercenary_helmet_01", //160 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"],
            [1, "hood/legend_helmet_chain_hood_full"]
        ],
        Helms = [
            [1, "helm/legend_helmet_viking_helm"]
        ],
        Tops = [
            [1, ""],
            [1, "top/legend_helmet_chain_attachment"], //40
        ],
        Vanity = [
            [2, ""],
            [1, "vanity/legend_helmet_antler"],
            [1, "vanity/legend_helmet_bull_horns"],
            [1, "vanity/legend_helmet_goat_horns"],
            [1, "vanity/legend_helmet_horn_decorations"]
        ]
    }]
    },
	{
        ID = "northern_mercenary_helmet_02", //160 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"],
            [1, "hood/legend_helmet_chain_hood_full"]
        ],
        Helms = [
            [1, "helm/legend_helmet_nordic_helm"], //185
        ],
        Tops = [
            [1, ""],
            [1, "top/legend_helmet_eyemask"]
        ],
        Vanity = [
            [1, "vanity/legend_helmet_orc_bones"],
            [1, "vanity/legend_helmet_orc_great_horns"]
        ]
    }]
    },
	{
        ID = "barbarian_chosen_helmet_00", //150 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_barb_chain_scarf"],
            [1, "hood/legend_helmet_barb_open_chain"],
            [1, "hood/legend_helmet_rotten_chain_scarf"]
        ],
        Helms = [
            [1, "helm/legend_helmet_barb_metal_cap"],
        ],
        Tops = [
            [1, "top/legend_helmet_leather_hood_barb"]
        ],
        Vanity = [
            [1, "vanity/legend_helmet_orc_bones"],
            [1, "vanity/legend_helmet_ponytail"]
        ]
    }]
    },
	{
        ID = "barbarian_chosen_helmet_01", //190 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_chain_hood"],
            [1, "hood/legend_helmet_chain_hood_full"],
            [1, "hood/legend_helmet_bronze_chain"]
        ],
        Helms = [
            [1, "helm/legend_helmet_barb_metal_cap"],
        ],
        Tops = [
            [1, "top/legend_helmet_orc_horn_mask"],
            [1, "top/legend_helmet_leather_hood_barb"],
            [1, "top/legend_helmet_orc_metal_mask"],
            [1, "top/legend_helmet_headband_nose"],
        ],
        Vanity = [
            [1, "vanity/legend_helmet_wolf_helm"],
            [1, "vanity/legend_helmet_lion_pelt"]
        ]
    }]
    },
	{
        ID = "barbarian_chosen_helmet_02", //190 ish
        Script = "",
        Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_cloth_scarf", 1]
        ],
        Helms = [
            [1, "helm/legend_helmet_heavy_plate_helm"], //170
        ],
        Tops = [
            [1, "top/legend_helmet_headband_side"], //20
        ],
        Vanity = [
            [1, "vanity/legend_helmet_ponytail", 1], //10
            [1, "vanity/legend_helmet_ponytail", 4], //10
        ]
        }]
    },
	{
        ID = "heavy_noble_house_helmet_00", //190 ish
        Script = "",
        Sets = [{
            Hoods = [
                [1, "hood/legend_helmet_aventail"],
                [1, "hood/legend_helmet_enclave_bevor"],
                [1, "hood/legend_helmet_chain_hood_full"],
            ],
            Helms = [
                [1, "helm/legend_helmet_rondel_helm"], //170
                [1, "helm/legend_helmet_norman_helm"], //170
                [1, "helm/legend_helmet_barbute"], //170
                [1, "helm/legend_helmet_sallet"], //170
                [1, "helm/legend_helmet_deep_sallet"] //170
            ],
            Tops = [
                [1, "top/legend_helmet_faceplate_winged"], //20
                [1, "top/legend_helmet_faceplate_snub_nose"], //20
                [1, "top/legend_helmet_faceplate_snub_slit"], //20
                [1, "top/legend_helmet_faceplate_short"], //20
                [1, "top/legend_helmet_faceplate_full"], //20
                [1, "top/legend_helmet_faceplate_curved"], //20
                [1, "top/legend_helmet_faceplate_full_breaths"], //20
            ],
            Vanity = [
            ]
        }]
    },
	{
        ID = "brown_monk_helmet_00", //190 ish
        Script = "",
        Sets = [{
            Hoods = [
                [1, "hood/legend_helmet_cloth_cap"],
            ],
            Helms = [
            ],
            Tops = [
                [3, ""],
                [1, "top/legend_helmet_cloth_long_hood", 3] //20
            ],
            Vanity = [
            ]
        }]
    }
])

gt.Const.LegendMod.Helmets <- {};


foreach( i, v in gt.Const.LegendMod.HelmObjs )
{
	// local id = "scripts/items/helmets/" + v.ID;
	gt.Const.LegendMod.Helmets[v.ID] <- v;
}

