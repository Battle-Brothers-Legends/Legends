this.legionkeep <- this.inherit("scripts/entity/world/settlement", {
	m = {},
	function create() {
		this.settlement.create();
		this.m.Name = "Legion Keep"
		this.m.DraftList = [ // backgrounds here were tests, this is where the new legion backgrounds will be added 
			"thief_southern_background",
			"thief_background",
			"disowned_noble_background",
			"female_disowned_noble_background",
			"hedge_knight_background",
			"sellsword_background",
			"manhunter_background",
			"nomad_background",
			"assassin_southern_background",
			"assassin_background",
			"militia_background",
			"houndmaster_background",
			"witchhunter_background",
			"raider_background",
			"retired_soldier_background",
			"squire_background",
			"swordmaster_background",
			"legend_noble_ranged",
			"female_adventurous_noble_background",
			"adventurous_noble_background",
			"female_bowyer_background",
			"hunter_background",
			"gladiator_background",
			"cultist_background",
			"wildman_background",
			"wildwoman_background",
			"deserter_background",
			"beast_hunter_background",
			"barbarian_background",
			"female_thief_background",
			"legend_shieldmaiden_background",
			"legend_ironmonger_background",
			"killer_on_the_run_background",
			"legend_assassin_background",
			"legend_berserker_background",
			"legend_noble_2h",
			"legend_noble_shield"
		];
		this.m.UIDescription = "A large keep where the dead thrive."; // descriptions here are all placeholder texts feel free to edit
		this.m.Description = "A large keep where the dead thrive, Davkul has given this place power for his Champion and his host to requip and muster forces.";
		this.m.UIBackgroundCenter = "ui/settlements/stronghold_03";
		this.m.UIBackgroundLeft = "ui/settlements/bg_houses_03_left";
		this.m.UIBackgroundRight = "ui/settlements/bg_houses_03_right";
		this.m.UIRampPathway = "ui/settlements/ramp_01_cobblestone";
		this.m.UISprite = "ui/settlement_sprites/stronghold_03.png";
		this.m.Sprite = "world_stronghold_03";
		this.m.Lighting = "world_stronghold_03_light";
		this.m.Rumors = this.Const.Strings.RumorsFarmingSettlement;
		this.m.Culture = this.Const.World.Culture.Neutral;
		this.m.Size = 3;
		this.m.HousesType = 3;
		this.m.HousesMin = 3;
		this.m.HousesMax = 5;
		this.m.AttachedLocationsMax = 6;
		this.m.LocationType = this.Const.World.LocationType.Unique;
		this.m.ShopSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.RosterSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.VisibilityMult = 1.5;
		this.m.Banner = this.World.Assets.getBannerID();
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/crowd_building"), 5);// thus far the keep only has hire / store 
		this.addBuilding(this.new("scripts/entity/world/settlements/buildings/legion_building"), 2);
		this.getFlags().set("IsSecondaryBase", true)
		this.m.IsVisited = true;
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.IsAttackableByAI = false;
		this.m.IsShowingStrength = false;
		this.m.IsScalingDefenders = false;
		this.m.IsShowingLabel = true;
		this.m.IsShowingBanner = true;
	}

	function onEnter() {                                   
		this.location.onEnter();
		this.updateRoster();
		this.updateShop();
		this.Math.seedRandom(this.Time.getRealTime());
		return true;
	}

	function onUpdateShopList(_id, _list) {
		foreach(loc in this.m.AttachedLocations) {
			if (loc.isActive()) {
				loc.onUpdateShopList(_id, _list);
			}
		}
	}

	function isEnterable() {
		if (!this.m.IsActive) {
			return false;
		}
		return true;
	}

	function getContracts() {
		return [];
	}

	function updateRoster(_force = false) {
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastRosterUpdate) / this.World.getTime().SecondsPerDay;
		if (!_force && this.m.LastRosterUpdate != 0 && daysPassed < 2) {
			return;
		}
		if (this.m.RosterSeed != 0) {
			this.Math.seedRandom(this.m.RosterSeed);
		}
		this.m.RosterSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastRosterUpdate = this.Time.getVirtualTimeF();
		local roster = this.World.getRoster(this.getID());
		local current = roster.getAll();
		local iterations = this.Math.max(1, daysPassed / 2);
		local rosterMin = 30 + this.World.Assets.m.RosterSizeAdditionalMin;
		local rosterMax = 30 + this.World.Assets.m.RosterSizeAdditionalMax;
		if (iterations < 7) {
			for (local i = 0; i < iterations; i = ++i) {
				for (local maxRecruits = this.Math.rand(this.Math.max(0, rosterMax / 2 - 1), rosterMax - 1); current.len() > maxRecruits;) {
					local n = this.Math.rand(0, current.len() - 1);
					roster.remove(current[n]);
					current.remove(n);
				}
			}
		} else {
			roster.clear();
			current = [];
		}
		local maxRecruits = this.Math.rand(rosterMin, rosterMax);
		local draftList;
		draftList = clone this.m.DraftList;
		this.World.Assets.getOrigin().onUpdateDraftList(draftList);
		while (maxRecruits > current.len()) {
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx(draftList);
			current.push(bro);
		}
		this.World.Assets.getOrigin().onUpdateHiringRoster(roster);
	}

});
