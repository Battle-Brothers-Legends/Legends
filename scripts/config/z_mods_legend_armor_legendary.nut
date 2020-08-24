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
    ID = "legendary/armor_of_davkul", // this.m.ConditionMax
    Script = "scripts/items/legend_armor/legendary/legend_armor_of_davkul",
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
    ID = "legendary/emperors_armor", // 400
    Script = "scripts/items/legend_armor/legendary/legend_emperors_armor",
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
    ID = "legendary/emperors_armor_fake", // 380
    Script = "scripts/items/legend_armor/legendary/legend_emperors_armor_fake",
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
    ID = "legendary/ijirok_armor", // 320
    Script = "scripts/items/legend_armor/legendary/legend_ijirok_armor",
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
    ID = "legendary/legend_mountain_armor", // this.m.ConditionMax
    Script = "scripts/items/legend_armor/legendary/legend_armor_mountain_named",
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
    ID = "legendary/legend_skin_armor", // 160
    Script = "scripts/items/legend_armor/legendary/legend_armor_skin",
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
    ID = "named/legend_named_warlock_cloak", // 180
    Script = "scripts/items/legend_armor/legendary/legend_armor_named_warlock_cloak",
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
    ID = "named/lindwurm_armor", // 300
    Script = "scripts/items/legend_armor/legendary/legend_lindwurm_armor",
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