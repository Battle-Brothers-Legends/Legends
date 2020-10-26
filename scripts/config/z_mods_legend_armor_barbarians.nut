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
    ID = "barbarians/animal_hide_armor", // 45
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_animal_hide_armor"], // 30
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/barbarian_ritual_armor", // 300
    Script = "scripts/items/armor/barbarians/barbarian_ritual_armor",
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
    ID = "barbarians/heavy_iron_armor", // 170
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
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
    ID = "barbarians/hide_and_bone_armor", // 95
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_hide_and_bone_armor"], // 80
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/reinforced_animal_hide_armor", // 65
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_reinforced_animal_hide_armor"], // 55
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/rugged_scale_armor", // 140
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_ancient_cloth_restored"], // 35
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_rugged_scale_armor"], // 95
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/scrap_metal_armor", // 75
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_scrap_metal_armor"], // 65
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/thick_furs_armor", // 30
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
            [1, "cloth/legend_sackcloth"], // 10
            [1, "cloth/legend_sackcloth_patched"], // 15
            [1, "cloth/legend_sackcloth_tattered"], // 5
        ],
        Chain = [
        ],
        Plate = [
            [1, "plate/legend_thick_furs_armor"], // 10
        ],
        Cloak = [
        ],
        Tabard = [
        ],
        Attachments =[
        ]
    }]
},{
    ID = "barbarians/thick_plated_barbarian_armor", // 230
    Script = "",
    Sets = [{
        Cloth = [
            [1, "cloth/legend_ancient_cloth"], // 30
            [1, "cloth/legend_ancient_cloth_restored"], // 35
        ],
        Chain = [
            [1, "chain/legend_armor_mail_shirt_simple"], // 25
            [1, "chain/legend_armor_reinforced_rotten_mail_shirt"], // 45
            [1, "chain/legend_armor_rusty_mail_shirt"], // 20
        ],
        Plate = [
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
    ID = "barbarians/unhold_armor_heavy", // 400
    Script = "scripts/items/armor/barbarians/unhold_armor_heavy",
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
    ID = "barbarians/unhold_armor_light", // 35
    Script = "scripts/items/armor/barbarians/unhold_armor_light",
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
}
])