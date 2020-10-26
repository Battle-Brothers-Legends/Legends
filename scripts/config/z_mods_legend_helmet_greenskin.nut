
local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

if (!("HelmObjs" in gt.Const.LegendMod))
{
    gt.Const.LegendMod.HelmObjs <- [];
}

gt.Const.LegendMod.HelmObjs.extend([ //gob heavy helmet
{
    ID = "greenskins/goblin_heavy_helmet", //90
    Script = "",
    Sets = [{
    Hoods = [
            [1, "hood/legend_helmet_goblin_scarf"], //5
            [2, "hood/legend_helmet_cloth_scarf"], //10
            [1, "hood/legend_helmet_cloth_bandana"] //15
    ],
    Helms = [
    ],
    Tops = [
        [0, "top/legend_helmet_goblin_leaves"], //5
        [0, "top/legend_helmet_goblin_leaf_helm"], //10
        [0, "top/legend_helmet_goblin_gillie"], //25
        [0, "top/legend_helmet_goblin_leather_mask"], //40
        [2, "top/legend_helmet_goblin_leather_helm"], //45
        [8, "top/legend_helmet_goblin_chain_helm"], //70
        [0, "top/legend_helmet_goblin_spiked_helm"] //90
    ],
    Vanity = [
        [1, "vanity/legend_helmet_ponytail"]//10
    ]
}]
},{ //gob leader helmet
    ID = "greenskins/goblin_leader_helmet", //120
    Script = "scripts/items/helmets/greenskins/goblin_leader_helmet",
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
},{ //gob light helmet
    ID = "greenskins/goblin_light_helmet", //40
    Script = "",
    Sets = [{
    Hoods = [
        [2, "hood/legend_helmet_goblin_scarf"], //5
        [4, "hood/legend_helmet_cloth_scarf"], //10
        [4, "hood/legend_helmet_cloth_bandana"] //15
    ],
    Helms = [
    ],
    Tops = [
        [1, "top/legend_helmet_goblin_leaves"], //5
        [1, "top/legend_helmet_goblin_leaf_helm"], //10
        [8, "top/legend_helmet_goblin_gillie"], //25
    ],
    Vanity = [
    ]
}]
},{ //gob shaman
    ID = "greenskins/goblin_shaman_helmet", //35
    Script = "scripts/items/helmets/greenskins/goblin_shaman_helmet",
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
},{ //gob skirmisher
    ID = "greenskins/goblin_skirmisher_helmet", //25
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_goblin_scarf"], //5
        [1, "hood/legend_helmet_cloth_scarf"], //10
        [1, "hood/legend_helmet_cloth_bandana"] //15
    ],
    Helms = [
    ],
    Tops = [
        [1, "top/legend_helmet_goblin_leaves"], //5
        [1, "top/legend_helmet_goblin_leaf_helm"], //10
        [1, "top/legend_helmet_goblin_gillie"] //25
    ],
    Vanity = [
    ]
}]
},{
    ID = "greenskins/legend_orc_behemoth_helmet", //300
    Script = "",
    Sets = [{
    Hoods = [ //avg 45
        [1, "hood/legend_helmet_cloth_bandana"], //15
        [1, "hood/legend_helmet_patched_hood"], //25
        [1, "hood/legend_helmet_simple_hood"], //30
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"] //65
    ],
    Helms = [ //avg 190 : 235 avg so far need ~~ 70 : max 285 min 175
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [1, "helm/legend_helmet_orc_double_helm"] //220
    ],
    Tops = [
        [1, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"] //120
    ],
    Vanity = [ //+10
        [3, ""], //33% no vanity
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"] //10
    ]
}]
},{
    ID = "greenskins/orc_berserker_helmet", //120
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_padded_cap"] //40
    ],
    Helms = [],
    Tops = [ //ancient crown is sort of cheaty here, withorc bones you dont really see it but it pulls up the durability enough for the helmet. should this be a vanilla script instead? dno
        [1, "top/legend_helmet_ancient_crown"] //80
    ],
    Vanity = [
        [1, "vanity/legend_helmet_orc_bones"] //10
    ]
}]
},{
    ID = "greenskins/orc_elite_heavy_helmet", //540
    Script = "",
    Sets = [{
    Hoods = [ //80 avg : need 470
        [1, "hood/legend_helmet_chain_scarf"], //70
        [1, "hood/legend_helmet_chain_hood"], //80
        [1, "hood/legend_helmet_chain_hood_full"] //90
    ],
    Helms = [ //420 added : need 50
        [1, "helm/legend_helmet_orc_great_helm"], //420
    ],
    Tops = [ //avg slightly below 540
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"] //60
    ],
    Vanity = []
}]
},{
    ID = "greenskins/orc_warlord_helmet", //500
    Script = "",
    Sets = [{
    Hoods = [ //avg  50 need 450
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"], //45
        [1, "hood/legend_helmet_padded_hood"], //50
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [1, "hood/legend_helmet_chain_hood"] //80
    ],
    //note while helms averages correctly its a pretty big swing to be able to hit 600 and also hit like 300, maybe tweak?
    Helms = [ //avg 320 need 130
        [4, "helm/legend_helmet_orc_great_helm"], //420
        [1, "helm/legend_helmet_orc_double_helm"] //220
    ],
    Tops = [ //need 140
        [1, "top/legend_helmet_orc_metal_mask"] //120
    ],
    Vanity = [ //need 130
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [1, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"] //10
    ]
}]
},{
    ID = "greenskins/orc_warrior_heavy_helmet", //360
    Script = "",
    Sets = [{
    Hoods = [ //avg like 72: Need 29
        [1, "hood/legend_helmet_open_chain_hood"], //65
        [2, "hood/legend_helmet_chain_hood"] //80
    ],
    Helms = [ //avg 190 : need 100
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [2, "helm/legend_helmet_orc_double_helm"] //220
    ],
    Tops = [ //slightly higher weights to things that equal 360 exactly
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [2, "top/legend_helmet_orc_horn_mask"], //60
        [1, "top/legend_helmet_orc_metal_mask"] //120
    ],
    Vanity = [
        [5, ""],
        [1, "vanity/legend_helmet_bull_horns"], //10
        [1, "vanity/legend_helmet_orc_bones"], //10
        [1, "vanity/legend_helmet_ram_horns"], //10
        [0, "vanity/legend_helmet_ponytail"], //10
        [1, "vanity_lower/legend_helmet_orc_tail"], //10
        [1, "vanity_lower/legend_helmet_knotted_tail"] //10
    ]
}]
},{
    ID = "greenskins/orc_warrior_light_helmet", //240
    Script = "",
    Sets = [{
    Hoods = [ //need 200
        [1, "hood/legend_helmet_leather_cap"] //35
    ],
    Helms = [
        [1, "helm/legend_helmet_orc_strapped_helm"] //160
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
    ],
    Vanity = []
}]
},{
    ID = "greenskins/orc_warrior_medium_helmet", //300
    Script = "",
    Sets = [{
    Hoods = [ //40 avg
        [1, "hood/legend_helmet_leather_cap"], //35
        [1, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_leather_hood"] //45
    ],
    Helms = [ //208 avg
        [1, "helm/legend_helmet_orc_strapped_helm"], //160
        [4, "helm/legend_helmet_orc_double_helm"], //220
    ],
    Tops = [
        [1, "top/legend_helmet_orc_horn_mask"] //60
    ],
    Vanity = []
}]
},{
    ID = "greenskins/orc_young_heavy_helmet", //120
    Script = "",
    Sets = [{
    Hoods = [
        [2, "hood/legend_helmet_leather_cap"], //35
        [2, "hood/legend_helmet_padded_cap"], //40
        [1, "hood/legend_helmet_padded_hood"], //50
        [5, "hood/legend_helmet_open_chain_hood"], //65
    ],
    Helms = [
    ],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [4, "top/legend_helmet_orc_horn_mask"], //60
    ],
    Vanity = []
}]
},{
    ID = "greenskins/orc_young_light_helmet", //35
    Script = "",
    Sets = [{
    Hoods = [ //flat out more armor but it'll look a lot closer to correct i think
        [1, "hood/legend_helmet_cloth_bandana"] //15
    ],
    Helms = [],
    Tops = [
        [1, "top/legend_helmet_orc_leather_mask"] //35
    ],
    Vanity = []
}]
},{
    ID = "greenskins/orc_young_medium_helmet", //60
    Script = "",
    Sets = [{
    Hoods = [
        [1, "hood/legend_helmet_cloth_bandana"] //15
    ],
    Helms = [],
    Tops = [ //fits avg correct to vanilla dura
        [1, "top/legend_helmet_orc_leather_mask"], //35
        [1, "top/legend_helmet_orc_horn_mask"], //60
    ],
    Vanity = []
}]
}])