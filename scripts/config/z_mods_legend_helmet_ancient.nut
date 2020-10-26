
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
    ID = "ancient/ancient_gladiator_helmet",
    Script = "",
    Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_legend_ancient_gladiator"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
},{
    ID = "ancient/ancient_honorguard_helmet",
    Script = "",
    Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_ancient_beard_mask"],
            [1, "helm/legend_helmet_ancient_lion_mask"],
            [1, "helm/legend_helmet_ancient_mask"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    },{
        Hoods = [
            [1, "hood/legend_helmet_rotten_chain_scarf"],
            [1, "hood/legend_helmet_barb_chain_scarf"],
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_ancient_face_helm"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
},{
    ID = "ancient/ancient_household_helmet",
    Script = "",
    Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_ancient_conic_helm"],
            [1, "helm/legend_helmet_ancient_kettle"],
            [1, "helm/legend_helmet_ancient_dome"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
},{
    ID = "ancient/ancient_laurels",
    Script = "scripts/items/legend_helmets/helmets/legend_ancient_laurels",
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
    ID = "ancient/ancient_legionary_helmet",
    Script = "",
    Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_ancient_dome_tailed"],
            [1, "helm/legend_helmet_ancient_face_plate"],
            [1, "helm/legend_helmet_ancient_legionaire"],
            [1, "helm/legend_helmet_ancient_side_hawk"],
            [1, "helm/legend_helmet_ancient_tailed_conic_helm"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
},{
    ID = "ancient/ancient_priest_diadem",
    Script = "scripts/items/legend_helmets/helmets/legend_ancient_priest_diadem",
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
    ID = "ancient/legend_ancient_legionary_helmet_restored",
    Script = "",
    Sets = [{
        Hoods = [
            [1, "hood/legend_helmet_leather_cap"]
        ],
        Helms = [
            [1, "helm/legend_helmet_legend_ancient_legionaire_restored"]
        ],
        Tops = [
        ],
        Vanity = [
        ]
    }]
}])