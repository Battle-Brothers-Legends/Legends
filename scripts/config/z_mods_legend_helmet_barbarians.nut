
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
    ID = "barbarians/barbarian_ritual_helmet", //300
    Script = "scripts/items/helmet/barbarians/barbarian_ritual_helmet",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_open_chain_hood"], //65
    ],
    Helms = [
        [1, "helm/legend_helmet_crude_cylinder_helm"], //110
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"], //120
        [1, "top/legend_helmet_goblin_leather_mask"], //40
        [1, "top/legend_helmet_goblin_leather_helm"], //45
        [1, "top/legend_helmet_goblin_chain_helm"], //70
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
		[1, "top/unhold_head_spike"], //100
		[1, "top/unhold_head_chain"], //100
  
    ],
    Vanity = [
        [5, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_bear_head"], //10
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_goat_horns"], //10
        [1, "vanity/legend_helmet_horn_decorations"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_wolf_helm"], //10
    ]
}]
},{
    ID = "barbarians/bear_headpiece", //50
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_open_chain_hood"], //65

    ],
    Helms = [
        [1, ""], //15
    ],
    Tops = [
        [1, ""], //35
    ],
    Vanity = [
        [1, "vanity/legend_helmet_bear_head"], //10
    ]
}]
},{
    ID = "barbarians/beastmasters_headpiece", //130
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [0, "hood/legend_helmet_bronze_chain"], //100
    ],
    Helms = [
		[1, ""], //45
        [1, "helm/legend_helmet_viking_helm"], //45
        [1, "helm/legend_helmet_norman_helm"], //50
    ],
    Tops = [
        [5, ""], //35
		[1, "top/legend_helmet_orc_leather_mask"], //35
		[1, "top/legend_helmet_orc_horn_mask"], //35

    ],
    Vanity = [
        [1, "vanity/legend_helmet_goat_horns"], //10
    ]
}]
},{
    ID = "barbarians/closed_scrap_metal_helmet", //190
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_open_chain_hood"], //65
    ],
    Helms = [
        [1, "helm/legend_helmet_crude_cylinder_helm"], //110
    ],
    Tops = [
        [1, ""], //35
 
    ],
    Vanity = [
        [1, "vanity/legend_helmet_antler"], //10

    ]
}]
},{
    ID = "barbarians/crude_faceguard_helmet", //160
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_open_chain_hood"], //65
    ],
    Helms = [

        [1, "helm/legend_helmet_crude_metal_helm"], //65
    ],
    Tops = [
        [1, ""], //35
    ],
    Vanity = [
        [1, ""], //10
    ]
}]
},{
    ID = "barbarians/crude_metal_helmet", //145
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_leather_hood"], //45
    ],
    Helms = [
        [1, "helm/legend_helmet_crude_metal_helm"], //65
    ],
    Tops = [
        [1, ""], //35

    ],
    Vanity = [
        [1, ""], //10
    ]
}]
},{
    ID = "barbarians/heavy_horned_plate_helmet", //250
    Script = "",
    Sets = [{
    Hoods = [
		[1, "hood/legend_helmet_barb_chain_scarf"], //55
        [1, "hood/legend_helmet_rotten_chain_scarf"], //60
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"], //90
    ],
    Helms = [
        [1, "helm/legend_helmet_heavy_plate_helm"], //170
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"], //120
        [1, "top/legend_helmet_leather_hood_barb"], //105
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
    ],
    Vanity = [
        [1, "vanity/legend_helmet_antler"], //10
        [1, "vanity/legend_helmet_bear_head"], //10
        [10, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_goat_horns"], //10
        [1, "vanity/legend_helmet_headband"], //10
        [1, "vanity/legend_helmet_horn_decorations"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
		[1, ""], //10
    ]
}]
},{
    ID = "barbarians/leather_headband", //30
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_simple_hood"], //30
        [1, "hood/legend_helmet_leather_cap"], //35
    ],
    Helms = [
        [1, ""], //15

    ],
    Tops = [
        [1, "top/legend_helmet_headband_side"], //20
        [1, "top/legend_helmet_headband_nose"], //30
    ],
    Vanity = [
        [1, ""], //10
    ]
}]
},{
    ID = "barbarians/leather_helmet", //105
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45

    ],
    Helms = [
        [1, "helm/legend_helmet_viking_helm"], //45
        [1, "helm/legend_helmet_norman_helm"], //50
    ],
    Tops = [
        [1, "top/legend_helmet_leather_hood_barb"], //105
    ],
    Vanity = [
        [1, ""], //30
    ]
}]
},{
    ID = "barbarians/unhold_helmet_heavy", //400
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_leather_cap"], //35
    ],
    Helms = [
        [1, ""], //160
    ],
    Tops = [
		 [1, "top/unhold_head_spike"], //100
    ],
    Vanity = [
        [1, ""], //10
    ]
}]
},{
    ID = "barbarians/unhold_helmet_light", //35
    Script = "",
    Sets = [{
    Hoods = [
		[1, "hood/legend_helmet_leather_cap"], //35
    ],
    Helms = [
		[1, ""], //160
    ],
    Tops = [
			[1, "top/unhold_head_chain"], //35
    ],
    Vanity = [
        [1, ""], //10
    ]
}]
}])