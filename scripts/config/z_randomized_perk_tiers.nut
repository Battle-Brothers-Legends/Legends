local gt = this.getroottable();
local et = gt.Const.EntityType //idk man like i'm supposed to do checks but it loads after global so it's fine?

// Numbers subject to change :: TODO
gt.Const.PerkPurchasePower <- {
    VeryLow = 2,
    Low = 4,
    Medium = 5,
    High = 7,
    VeryHigh = 9,
    ExtraHigh = 11
};

gt.Const.RandomizedCharacterInfo <- {}
gt.Const.RandomizedCharacterInfo["Default"] <- {
    Outfits = [
        [1, "low_tier_unit_catchall_outfit_01"]
    ],
    ClassPerkList = [], 
    DefensePerkList = [  
        this.Const.Perks.HeavyArmorTree,
        this.Const.Perks.MediumArmorTree,
        this.Const.Perks.LightArmorTree,
        this.Const.Perks.ClothArmorTree
    ],
    TraitsPerkList = [  
        this.Const.Perks.AgileTree,
        this.Const.Perks.IndestructibleTree,
        this.Const.Perks.MartyrTree,
        this.Const.Perks.ViciousTree,
        // this.Const.Perks.DeviousTree,
        // this.Const.Perks.InspirationalTree,
        // this.Const.Perks.IntelligentTree,
        this.Const.Perks.CalmTree,
        this.Const.Perks.FastTree,
        this.Const.Perks.LargeTree,
        this.Const.Perks.OrganisedTree,
        this.Const.Perks.SturdyTree,
        this.Const.Perks.FitTree,
        this.Const.Perks.TrainedTree
    ], 
    GuaranteedPerks = [], 
    WeaponsAndTrees = [ 
        ["scripts/items/weapons/knife",  100, 75] // [Weapon Script, Chance to roll weapon-perks, chacne to roll weapon-class-perks] 
    ],
    LevelRange = [3, 3]
    PerkPower = gt.Const.PerkPurchasePower.Low
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.Peasant] <- {
    Outfits = [
        [1, "peasant_outfit_00"]
    ],
    WeaponsAndTrees = [ 
        ["scripts/items/weapons/knife",  100, 80],
        ["scripts/items/weapons/pitchfork", 100, 60],
        ["scripts/items/weapons/wooden_stick", 100, 65],
        ["scripts/items/weapons/pickaxe", 100, 45],
        ["scripts/items/weapons/legend_hammer", 100, 60],
        ["scripts/items/weapons/legend_sickle", 100, 80],
        ["scripts/items/weapons/legend_wooden_pitchfork", 100, 65],
        ["scripts/items/weapons/legend_scythe", 100, 75],
        ["scripts/items/weapons/legend_hoe", 100],
        ["scripts/items/weapons/legend_shiv",  100, 75],
        ["scripts/items/weapons/legend_shovel", 100, 80],
        ["scripts/items/weapons/legend_staff", 100],
        ["scripts/items/weapons/butchers_cleaver", 100, 45],
        ["scripts/items/weapons/legend_wooden_spear", 100, 80]
    ],
    LevelRange = [1, 3]
    PerkPower = gt.Const.PerkPurchasePower.VeryLow
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.CaravanHand] <- {
    Outfits = [
        [1, "caravan_hand_outfit_00"]
    ],
    WeaponsAndTrees = [
        ["scripts/items/weapons/dagger", 100, 75],
        ["scripts/items/weapons/knife",  100, 75],
        ["scripts/items/weapons/wooden_stick", 100, 75],
        ["scripts/items/weapons/hatchet", 100],
        ["scripts/items/weapons/bludgeon", 100],
        ["scripts/items/weapons/militia_spear", 100, 75],
        ["scripts/items/weapons/scramasax", 100],
        ["scripts/items/weapons/shortsword", 100],
        ["scripts/items/weapons/legend_militia_glaive", 100]
    ],
    GuaranteedPerks = [
        "scripts/skills/perks/perk_recover"
    ],
    LevelRange = [3, 5],
    PerkPower = gt.Const.PerkPurchasePower.Low
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.CaravanGuard] <- {
    Outfits = [
        [1, "caravan_guard_outfit_00"]
    ],
    WeaponsAndTrees = [
        ["scripts/items/weapons/hand_axe", 100],
        ["scripts/items/weapons/boar_spear", 100],
        ["scripts/items/weapons/falchion", 100],
        ["scripts/items/weapons/shortsword", 100],
        ["scripts/items/weapons/arming_sword", 100],
        ["scripts/items/weapons/legend_glaive", 100],
    ],
    GuaranteedPerks = [
        "scripts/skills/perks/perk_recover",
        "scripts/skills/perks/perk_shield_expert"
    ],
    LevelRange = [4, 7],
    PerkPower = gt.Const.PerkPurchasePower.Medium
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.BanditRabble] <- {
    Outfits = [
        [1, "bandit_rabble_outfit_00"]
    ],
    TraitsPerkList = [  
        this.Const.Perks.AgileTree,
        this.Const.Perks.IndestructibleTree,
        this.Const.Perks.MartyrTree,
        this.Const.Perks.ViciousTree,
        // this.Const.Perks.DeviousTree,
        // this.Const.Perks.InspirationalTree,
        // this.Const.Perks.IntelligentTree,
        this.Const.Perks.CalmTree,
        this.Const.Perks.FastTree,
        this.Const.Perks.LargeTree,
        // this.Const.Perks.OrganisedTree,
        this.Const.Perks.SturdyTree,
        this.Const.Perks.FitTree,
        this.Const.Perks.TrainedTree
    ], 
    WeaponsAndTrees = [
        ["scripts/items/weapons/legend_wooden_pitchfork", 35],
        ["scripts/items/weapons/legend_wooden_spear", 35],
        ["scripts/items/weapons/legend_sickle", 35],
        ["scripts/items/weapons/legend_staff", 35],
        ["scripts/items/weapons/legend_shovel", 35],
        ["scripts/items/weapons/wooden_stick", 35],
        ["scripts/items/weapons/legend_hammer", 35],
        ["scripts/items/weapons/legend_shiv",  35],
        ["scripts/items/weapons/lute", 35],
        ["scripts/items/weapons/butchers_cleaver", 35],
        ["scripts/items/weapons/legend_saw", 35],
        ["scripts/items/weapons/legend_hoe", 35],
        ["scripts/items/weapons/wooden_flail", 35]
    ],
    LevelRange = [1, 3],
    PerkPower = gt.Const.PerkPurchasePower.VeryLow
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.BanditRabblePoacher] <- {
    Outfits = [
        [1, "bandit_rabble_poacher_outfit_00"]
    ],
    TraitsPerkList = [  
        this.Const.Perks.AgileTree,
        // this.Const.Perks.IndestructibleTree,
        this.Const.Perks.MartyrTree,
        this.Const.Perks.ViciousTree,
        // this.Const.Perks.DeviousTree,
        // this.Const.Perks.InspirationalTree,
        // this.Const.Perks.IntelligentTree,
        this.Const.Perks.CalmTree,
        this.Const.Perks.FastTree,
        this.Const.Perks.LargeTree,
        // this.Const.Perks.OrganisedTree,
        this.Const.Perks.SturdyTree,
        this.Const.Perks.FitTree,
        this.Const.Perks.TrainedTree
    ], 
    WeaponsAndTrees = [
        ["scripts/items/weapons/short_bow", 50],
        ["scripts/items/weapons/legend_sling", 50],
        ["scripts/items/weapons/legend_sling", 50]
    ],
    LevelRange = [1, 3],
    PerkPower = gt.Const.PerkPurchasePower.VeryLow
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.BanditThug] <- {
    Outfits = [
        [1, "bandit_thug_outfit_00"]
    ],
    WeaponsAndTrees = [
        ["scripts/items/weapons/woodcutters_axe", 70],
        ["scripts/items/weapons/goedendag", 70],
        ["scripts/items/weapons/pitchfork", 70],
        ["scripts/items/weapons/shortsword", 70],
        ["scripts/items/weapons/hatchet", 70],
        ["scripts/items/weapons/bludgeon", 70],
        ["scripts/items/weapons/militia_spear", 70],
        ["scripts/items/weapons/pickaxe", 70],
        ["scripts/items/weapons/reinforced_wooden_flail", 70],
        ["scripts/items/weapons/wooden_flail", 70],
        ["scripts/items/weapons/butchers_cleaver", 70],
        ["scripts/items/weapons/dagger",  70],
        ["scripts/items/weapons/legend_scythe", 70],
        ["scripts/items/weapons/legend_tipstaff", 70],
        ["scripts/items/weapons/legend_militia_glaive", 70],
        ["scripts/items/weapons/legend_tipstaff", 70],
        ["scripts/items/weapons/legend_ranged_wooden_flail", 70],
    ],
    TraitsPerkList = [  
        this.Const.Perks.AgileTree,
        this.Const.Perks.IndestructibleTree,
        this.Const.Perks.MartyrTree,
        this.Const.Perks.ViciousTree,
        // this.Const.Perks.DeviousTree,
        // this.Const.Perks.InspirationalTree,
        // this.Const.Perks.IntelligentTree,
        this.Const.Perks.CalmTree,
        this.Const.Perks.FastTree,
        this.Const.Perks.LargeTree,
        // this.Const.Perks.OrganisedTree,
        this.Const.Perks.SturdyTree,
        this.Const.Perks.FitTree,
        this.Const.Perks.TrainedTree
    ], 
    LevelRange = [2, 5],
    PerkPower = gt.Const.PerkPurchasePower.Medium
}
gt.Const.RandomizedCharacterInfo[gt.Const.EntityType.BanditPoacher] <- {
    Outfits = [
        [1, "bandit_poacher_outfit_00"]
    ],
    WeaponsAndTrees = [
        ["scripts/items/weapons/short_bow", 65],
        ["scripts/items/weapons/legend_sling", 65]
    ],
    TraitsPerkList = [  
        this.Const.Perks.AgileTree,
        // this.Const.Perks.IndestructibleTree,
        this.Const.Perks.MartyrTree,
        this.Const.Perks.ViciousTree,
        // this.Const.Perks.DeviousTree,
        // this.Const.Perks.InspirationalTree,
        // this.Const.Perks.IntelligentTree,
        this.Const.Perks.CalmTree,
        this.Const.Perks.FastTree,
        this.Const.Perks.LargeTree,
        // this.Const.Perks.OrganisedTree,
        this.Const.Perks.SturdyTree,
        this.Const.Perks.FitTree,
        this.Const.Perks.TrainedTree
    ], 
    LevelRange = [2, 4],
    GuaranteedPerks = [
        "scripts/skills/perks/perk_rotation",
        "scripts/skills/perks/perk_recover"
    ],
    PerkPower = gt.Const.PerkPurchasePower.Low
}

     
    
     
    
    


gt.Const.RandomizedMalus <- {
    Hitpoints = [
        0,
        0
    ],
    Bravery = [
        0,
        0
    ],
    Stamina = [
        0,
        0
    ],
    MeleeSkill = [
        -3,
        -5
    ],
    RangedSkill = [
        -3,
        -5
    ],
    MeleeDefense = [
        0,
        0
    ],
    RangedDefense = [
        0,
        0
    ],
    Initiative = [
        0,
        0
    ]
};

// Only lower tiered weapons should really get these class trees, might expand this later to just work with any tier of weapon anyways? It'll look the same as the other function if we do 
gt.Const.GetWeaponClassTree <- function ( _item ) {

    switch(true) {
			//Shovel
				case _item.getID() == "weapon.legend_shovel" || _item.getID() == "weapon.legend_named_shovel":
					return this.Const.Perks.ShovelClassTree.Tree;

			//Sickle
				case _item.getID() == "weapon.sickle" || _item.getID() == "weapon.goblin_notched_blade" || _item.getID() == "weapon.legend_named_sickle":
					return this.Const.Perks.SickleClassTree.Tree;

			//Wood Axe
				case _item.getID() == "weapon.woodcutters_axe" || _item.getID() == "weapon.legend_saw":
					return this.Const.Perks.WoodaxeClassTree.Tree;

			//Blacksmith
				case _item.getID() == "weapon.legend_hammer" || _item.getID() == "weapon.legend_named_blacksmith_hammer":
					return this.Const.Perks.HammerClassTree.Tree;

			//Pickaxe
				case _item.getID() == "weapon.pickaxe":
					return this.Const.Perks.PickaxeClassTree.Tree;

			//Butcher
				case _item.getID() == "weapon.butchers_cleaver" || _item.getID() == "weapon.legend_named_butchers_cleaver":
					return this.Const.Perks.ButcherClassTree.Tree;

			//Ninetails
				case _item.getID() == "weapon.legend_cat_o_nine_tails":
					return this.Const.Perks.NinetailsClassTree.Tree;

			//Knife
				case _item.getID() == "weapon.knife" || _item.getID() == "weapon.legend_shiv":
					return this.Const.Perks.KnifeClassTree.Tree;

			//Scythe
				case _item.getID() == "weapon.legend_grisly_scythe" || _item.getID() == "weapon.legend_scythe" || _item.getID() == "weapon.warscythe" || _item.getID() == "weapon.named_warscythe":
					return this.Const.Perks.ScytheClassTree.Tree;

			//Pitchfork
				case _item.isItemType(this.Const.Items.ItemType.Pitchfork):
					return this.Const.Perks.PitchforkClassTree.Tree;

			//Musical
				case _item.isWeaponType(this.Const.Items.WeaponType.Musical):
					return this.Const.Perks.BardClassTree.Tree;

			//Shortbow
				case _item.isItemType(this.Const.Items.ItemType.Shortbow):
					return this.Const.Perks.ShortbowClassTree.Tree;

			//Net
				case _item.isItemType(this.Const.Items.ItemType.Net):
					return this.Const.Perks.BeastClassTree.Tree;

			//Militia
				case _item.getID() == "weapon.militia_spear" || _item.getID() == "weapon.legend_wooden_spear" || _item.getID() == "weapon.ancient_spear":
					return this.Const.Perks.MilitiaClassTree.Tree;
		}

		return null;

}
gt.Const.GetWeaponPerkTree <- function ( _item ) {

    //Greatsword				
        if (_item.isWeaponType(this.Const.Items.WeaponType.Sword) && _item.isItemType(this.Const.Items.ItemType.TwoHanded))
            return this.Const.Perks.GreatSwordTree.Tree;

    // WeaponTypes
        local ret = []; // Push all applicable WeaponTypes into array (supports Hybrid weapons)
        local weaponToPerkMap = {
            Axe = this.Const.Perks.AxeTree,
            Bow = this.Const.Perks.BowTree,
            Cleaver = this.Const.Perks.CleaverTree,
            Crossbow = this.Const.Perks.CrossbowTree,
            Dagger = this.Const.Perks.DaggerTree,
            Firearm = this.Const.Perks.CrossbowTree,
            Flail = this.Const.Perks.FlailTree,
            Hammer = this.Const.Perks.HammerTree,
            Mace = this.Const.Perks.MaceTree,
            Polearm = this.Const.Perks.PolearmTree,
            Sling = this.Const.Perks.SlingTree,
            Spear = this.Const.Perks.SpearTree,
            Sword = this.Const.Perks.SwordTree,
            Staff = this.Const.Perks.StaffTree,
            Throwing = this.Const.Perks.ThrowingTree
        }
        foreach (weapon, tree in weaponToPerkMap)
        {
            if (_item.isWeaponType(this.Const.Items.WeaponType[weapon])) ret.push(tree);
        }
        return ret;

}