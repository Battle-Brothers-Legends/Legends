this.character_background <- this.inherit("scripts/skills/skill", {
	m = {
		HiringCost = 0,
		DailyCost = 0,
		DailyCostMult = 1.0,
		Excluded = [],
		ExcludedTalents = [],
		Faces = null,
		Hairs = null,
		HairColors = null,
		Beards = null,
		Body = null,
		Level = 1,
		BeardChance = 60,
		Titles = [],
		RawDescription = "",
		BackgroundDescription = "",
		GoodEnding = null,
		BadEnding = null,
		IsScenarioOnly = false,
		IsNew = true,
		IsUntalented = false,
		IsOffendedByViolence = false,
		IsCombatBackground = false,
		IsEducatedBackground = false,
		Name = "",
		IsNoble = false,
		IsLowborn = false,
		IsFemaleBackground = false,
		IsRangerRecruitBackground = false,
		IsCrusaderRecruitBackground = false,
		IsOutlawBackground = false,
		IsStabled = false,
		Modifiers = {
			Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[0],
			ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[0],
			Meds = this.Const.LegendMod.ResourceModifiers.Meds[0],
			Stash = this.Const.LegendMod.ResourceModifiers.Stash[0],
			Healing = this.Const.LegendMod.ResourceModifiers.Healing[0],
			Injury = this.Const.LegendMod.ResourceModifiers.Injury[0],
			Repair = this.Const.LegendMod.ResourceModifiers.Repair[0],
			Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[0],
			Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[0],
			Barter = this.Const.LegendMod.ResourceModifiers.Barter[0],
			ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[0],
			MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[0],
			Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[0],
			Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[0],
			Scout = this.Const.LegendMod.ResourceModifiers.Scout[0],
			Gathering = this.Const.LegendMod.ResourceModifiers.Gather[0],
			Training = this.Const.LegendMod.ResourceModifiers.Training[0],
			Enchanting = 0.0
			Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0 //ocean
			]
		},
		PerkTreeDynamicMins = {
			Weapon = 8,
			Defense = 2,
			Traits = 8,
			Enemy = 1,
			EnemyChance = 0.33,
			Class = 0,
			ClassChance = 0.33
		},
		PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.PolearmTree
			],
			Defense = [this.Const.Perks.MediumArmorTree],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = []
		},
		CustomPerkTree = null,
		PerkTreeMap = null,
		PerkTree = null
	},
	function isExcluded( _id )
	{
		return this.m.Excluded.find(_id) != null;
	}

	function isUntalented()
	{
		return this.m.IsUntalented;
	}

	function setScenarioOnly( _f )
	{
		this.m.IsScenarioOnly = _f;
	}

	function isOffendedByViolence()
	{
		return this.m.IsOffendedByViolence;
	}

	function isFemaleBackground()
	{
		return this.m.IsFemaleBackground;
	}

	function isCombatBackground()
	{
		return this.m.IsCombatBackground;
	}

	function isNoble()
	{
		return this.m.IsNoble;
	}

	function isLowborn()
	{
		return this.m.IsLowborn;
	}

	function isRangerRecruitBackground()
	{
		return this.m.IsRangerRecruitBackground;
	}

	function isCrusaderRecruitBackground()
	{
		return this.m.IsCrusaderRecruitBackground;
	}

	function isEducatedBackground()
	{
		return this.m.IsEducatedBackground;
	}

	function isOutlawBackground()
	{
		return this.m.IsOutlawBackground;
	}

	function getExcludedTalents()
	{
		return this.m.ExcludedTalents;
	}

	function getGoodEnding()
	{
		return this.m.GoodEnding;
	}

	function getBadEnding()
	{
		return this.m.BadEnding;
	}

	function getModifiers()
	{
		return this.m.Modifiers;
	}

	function create()
	{
		this.m.Type = this.Const.SkillType.Background | this.Const.SkillType.Trait;
		this.m.Order = this.Const.SkillOrder.Background;
		this.m.DailyCostMult = this.Math.rand(90, 110) * 0.01;
	}

	function isHidden()
	{
		return this.skill.isHidden() || this.m.IsScenarioOnly;
	}

	function getName()
	{
		return "Background: " + this.m.Name;
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getPerkTreeGroupDescription ( _p, _prefix = "")
	{
		if( _p.len() == 0) {
			return ""
		}
		local i = 0;
		local text = _prefix + " " + _p[i].Descriptions[this.Math.rand(0, _p[i].Descriptions.len() - 1)];
		if (i == _p.len() - 1)
		{
			return text + ".\n";
		}

		i = 1;
		if (i == _p.len() - 1)
		{
			text = text + " and " + _p[i].Descriptions[this.Math.rand(0, _p[i].Descriptions.len() - 1)];
			return text + ".\n";
		}

		text = text + ", ";
		for (i; i < _p.len(); i = ++i)
		{
			text = text + _p[i].Descriptions[this.Math.rand(0, _p[i].Descriptions.len() - 1)];
			if (i <  _p.len() - 2)
			{
				text = text + ", ";
			}
			else if (i <  _p.len() - 1)
			{
				text = text + " and "
			}
		}
		return text + ".\n";
	}

	function getPerkBackgroundDescription( _tree )
	{
		local text = "";
		text += this.getPerkTreeGroupDescription(_tree.Weapon,  "Has an aptitude for");
		text += this.getPerkTreeGroupDescription(_tree.Defense,  "Likes wearing");
		text += this.getPerkTreeGroupDescription(_tree.Enemy,  "Prefers fighting");
		text += this.getPerkTreeGroupDescription(_tree.Class,  "Is skilled in") ;
		text += this.getPerkTreeGroupDescription(_tree.Traits,  "");
		return text;
	}

	function getBackgroundDescription( _desc )
	{
		local text = ""
		if (_desc)
		{
			text = text + this.m.BackgroundDescription + "\n";
			text = text + "\n" + this.getPerkBackgroundDescription(this.m.PerkTreeDynamic) + "\n";
		}

		local mtext = ""
		foreach (k, v in this.m.Modifiers)
		{
			if (k == "Terrain")
			{
				continue;
			}

			if (v == 0)
			{
				continue;
			}

			switch (k)
			{
				case "Ammo":
				case "Meds":
				case "Stash":
					mtext += k + " +" + v + "\n";
					break;
				case "ArmorParts":
					mtext += "Tools +" + v + "\n";
					break;
				default:
					v = v * 100;
					mtext += k + " +" + v + "%\n";
			}
		}
		if (mtext != "")
		{
			text += "\n" + mtext;
		}

		local terrains = this.m.Modifiers.Terrain;
		local val = 0.0
		local ttext = "";
		val = terrains[2] * 100.0;
		if (val > 0) {
			ttext += "\nPlains +" + val +"%"
		}
		val = terrains[3] * 100.0;
		if (val > 0) {
			ttext += "\nSwamp +" + val +"%"
		}
		val = terrains[4] * 100.0;
		if (val > 0) {
			ttext += "\nHills +" + val +"%"
		}
		val = terrains[5] * 100.0;
		if (val > 0) {
			ttext += "\nForests +" + val +"%"
		}
		val = terrains[9] * 100.0;
		if (val > 0) {
			ttext += "\nMountains +" + val +"%"
		}
		val = terrains[11] * 100.0;
		if (val > 0) {
			ttext += "\nFarmland +" + val +"%"
		}
		val = terrains[12] * 100.0;
		if (val > 0) {
			ttext += "\nSnow +" + val +"%"
		}
		val = terrains[13] * 100.0;
		if (val > 0) {
			ttext += "\nBadlands +" + val +"%"
		}
		val = terrains[14] * 100.0;
		if (val > 0) {
			ttext += "\nHighlands +" + val +"%"
		}
		val = terrains[15] * 100.0;
		if (val > 0) {
			ttext += "\nStepps +" + val +"%"
		}

		if (ttext != "")
		{
		 	text += "\nTerrain Movement Modifiers:" + ttext;
		}
		return text;
	}

	function getGenericTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getBackgroundDescription(true)
			}
		];
	}

	function getPerkTreeDescription()
	{
		local text = "";
		foreach (i, group in this.m.PerkTree)
		{
			text += "\nTier " + (i + 1) + ": ";
			foreach (p in group)
			{
				text += p.Name + ", ";
			}
		}
		return text;
	}

	function getPerkTree()
	{
		if (this.m.PerkTree != null)
		{
			return this.m.PerkTree;
		}

		local pT = this.Const.Perks.getPerksTree(this.getID());
		if (pT == null)
		{
			return [];
		}
		return pT.Tree;
	}

	function getPerk( _id )
	{
		if ( _id == null )
		{
			return null;
		}

		if (this.m.PerkTreeMap != null)
		{
			if (!(_id in this.m.PerkTreeMap))
			{
				return null;
			}
			return this.m.PerkTreeMap[_id];
		}

		return this.Const.Perks.findByBackground(_id, this.getID());
	}

	function isStabled()
	{
		return this.m.IsStabled;
	}

	function buildDescription( _isFinal = false )
	{
		if (this.m.IsScenarioOnly)
		{
			return;
		}

		local villages = this.World.EntityManager.getSettlements();
		local brother = this.World.getPlayerRoster().getAll();
		brother = brother.len() != 0 ? brother[this.Math.rand(0, brother.len() - 1)].getName() : "";
		local vars = [
			[
				"townname",
				this.World.State.getCurrentTown() != null ? this.World.State.getCurrentTown().getNameOnly() : villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			],
			[
				"randomtown",
				villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			],
			[
				"randomcity",
				villages[0].getNameOnly()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomnamefemale",
				this.Const.Strings.CharacterNamesFemale[this.Math.rand(0, this.Const.Strings.CharacterNamesFemale.len() - 1)]
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randombrother",
				brother
			]
		];
		this.onPrepareVariables(vars);

		if (!_isFinal)
		{
			this.m.RawDescription = this.buildTextFromTemplate(this.onBuildDescription(), vars);
		}

		vars.push([
			"name",
			this.getContainer().getActor().getNameOnly()
		]);
		vars.push([
			"fullname",
			this.getContainer().getActor().getName()
		]);
		this.m.Description = this.buildTextFromTemplate(this.m.RawDescription, vars);
	}

	function onPrepareVariables( _vars )
	{
	}

	function buildAttributes(_tag = null, _attrs = null)
	{
		local a = [];

		if (_tag == "zombie")
		{
			a = {
				Hitpoints = [
					65,
					75
				],
				Bravery = [
					30,
					40
				],
				Stamina = [
					90,
					100
				],
				MeleeSkill = [
					42,
					52
				],
				RangedSkill = [
					27,
					37
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
					85,
					95
				]
			};
		}
		else if (_tag == "skeleton")
		{
			a = {
				Hitpoints = [     // will start with a minimum of 15 health, set below
					1,
					1
				],
				Bravery = [
					30,
					40
				],
				Stamina = [
					90,
					100
				],
				MeleeSkill = [
					42,
					52
				],
				RangedSkill = [
					27,
					37
				],
				MeleeDefense = [
					0,
					5
				],
				RangedDefense = [
					0,
					5
				],
				Initiative = [
					90,
					100
				]
			};
		}
		else
		{
			a = {
				Hitpoints = [
					50,
					60
				],
				Bravery = [
					30,
					40
				],
				Stamina = [
					90,
					100
				],
				MeleeSkill = [
					47,
					57
				],
				RangedSkill = [
					32,
					42
				],
				MeleeDefense = [
					0,
					5
				],
				RangedDefense = [
					0,
					5
				],
				Initiative = [
					100,
					110
				]
			};
		}

		local c = this.onChangeAttributes();
		a.Hitpoints[0] += c.Hitpoints[0];
		a.Hitpoints[1] += c.Hitpoints[1];
		a.Bravery[0] += c.Bravery[0];
		a.Bravery[1] += c.Bravery[1];
		a.Stamina[0] += c.Stamina[0];
		a.Stamina[1] += c.Stamina[1];
		a.MeleeSkill[0] += c.MeleeSkill[0];
		a.MeleeSkill[1] += c.MeleeSkill[1];
		a.MeleeDefense[0] += c.MeleeDefense[0];
		a.MeleeDefense[1] += c.MeleeDefense[1];
		a.RangedSkill[0] += c.RangedSkill[0];
		a.RangedSkill[1] += c.RangedSkill[1];
		a.RangedDefense[0] += c.RangedDefense[0];
		a.RangedDefense[1] += c.RangedDefense[1];
		a.Initiative[0] += c.Initiative[0];
		a.Initiative[1] += c.Initiative[1];

		if (_attrs != null)
		{
			a.Hitpoints[0] += _attrs.Hitpoints[0];
			a.Hitpoints[1] += _attrs.Hitpoints[1];
			a.Bravery[0] += _attrs.Bravery[0];
			a.Bravery[1] += _attrs.Bravery[1];
			a.Stamina[0] += _attrs.Stamina[0];
			a.Stamina[1] += _attrs.Stamina[1];
			a.MeleeSkill[0] += _attrs.MeleeSkill[0];
			a.MeleeSkill[1] += _attrs.MeleeSkill[1];
			a.MeleeDefense[0] += _attrs.MeleeDefense[0];
			a.MeleeDefense[1] += _attrs.MeleeDefense[1];
			a.RangedSkill[0] += _attrs.RangedSkill[0];
			a.RangedSkill[1] += _attrs.RangedSkill[1];
			a.RangedDefense[0] += _attrs.RangedDefense[0];
			a.RangedDefense[1] += _attrs.RangedDefense[1];
			a.Initiative[0] += _attrs.Initiative[0];
			a.Initiative[1] += _attrs.Initiative[1];
		}
		local b = this.getContainer().getActor().getBaseProperties();
		if (_tag == "zombie")
		{
			b.ActionPoints = 6;
		}
		else if (_tag == "skeleton")
		{
			b.ActionPoints = 9;
		}
		else
		{
			b.ActionPoints = 9;
		}
		local Hitpoints1 = this.Math.max(15, this.Math.rand(a.Hitpoints[0], a.Hitpoints[1]));
		local Bravery1 = this.Math.rand(a.Bravery[0], a.Bravery[1]);
		local Stamina1 = this.Math.rand(a.Stamina[0], a.Stamina[1]);
		local MeleeSkill1 = this.Math.rand(a.MeleeSkill[0], a.MeleeSkill[1]);
		local RangedSkill1 = this.Math.rand(a.RangedSkill[0], a.RangedSkill[1]);
		local MeleeDefense1 = this.Math.rand(a.MeleeDefense[0], a.MeleeDefense[1]);
		local RangedDefense1 = this.Math.rand(a.RangedDefense[0], a.RangedDefense[1]);
		local Initiative1 = this.Math.rand(a.Initiative[0], a.Initiative[1]);
		local Hitpoints2 = this.Math.max(15, this.Math.rand(a.Hitpoints[0], a.Hitpoints[1]));
		local Bravery2 = this.Math.rand(a.Bravery[0], a.Bravery[1]);
		local Stamina2 = this.Math.rand(a.Stamina[0], a.Stamina[1]);
		local MeleeSkill2 = this.Math.rand(a.MeleeSkill[0], a.MeleeSkill[1]);
		local RangedSkill2 = this.Math.rand(a.RangedSkill[0], a.RangedSkill[1]);
		local MeleeDefense2 = this.Math.rand(a.MeleeDefense[0], a.MeleeDefense[1]);
		local RangedDefense2 = this.Math.rand(a.RangedDefense[0], a.RangedDefense[1]);
		local Initiative2 = this.Math.rand(a.Initiative[0], a.Initiative[1]);
		local HitpointsAvg = this.Math.floor((Hitpoints1 + Hitpoints2) / 2);
		local BraveryAvg  = this.Math.floor((Bravery1 + Bravery2) / 2);
		local StaminaAvg  = this.Math.floor((Stamina1 + Stamina2) / 2);
		local MeleeSkillAvg  = this.Math.floor((MeleeSkill1 + MeleeSkill2) / 2);
		local RangedSkillAvg  = this.Math.floor((RangedSkill1 + RangedSkill2) / 2);
		local MeleeDefenseAvg  = this.Math.floor((MeleeDefense1 + MeleeDefense2) / 2);
		local RangedDefenseAvg  = this.Math.floor((RangedDefense1 + RangedDefense2) / 2);
		local InitiativeAvg  = this.Math.floor((Initiative1 + Initiative2) / 2);


		b.Hitpoints = HitpointsAvg;
		b.Bravery = BraveryAvg;
		b.Stamina = StaminaAvg;
		b.MeleeSkill = MeleeSkillAvg;
		b.RangedSkill = RangedSkillAvg;
		b.MeleeDefense = MeleeDefenseAvg;
		b.RangedDefense = RangedDefenseAvg;
		b.Initiative = InitiativeAvg;
		this.getContainer().getActor().m.CurrentProperties = clone b;
		this.getContainer().getActor().setHitpoints(b.Hitpoints);

		local weighted = []
		weighted.push(this.Math.floor((a.Hitpoints[1] - b.Hitpoints) / (a.Hitpoints[1] - a.Hitpoints[0]) * 100.0))
		weighted.push(this.Math.floor((a.Bravery[1] - b.Bravery) / (a.Bravery[1] - a.Bravery[0]) * 100.0))
		weighted.push(this.Math.floor((a.Stamina[1] - b.Stamina) / (a.Stamina[1] - a.Stamina[0]) * 100.0))
		weighted.push(this.Math.floor((a.Initiative[1] - b.Initiative) / (a.Initiative[1] - a.Initiative[0]) * 100.0))
		weighted.push(this.Math.floor((a.MeleeSkill[1] - b.MeleeSkill) / (a.MeleeSkill[1] - a.MeleeSkill[0]) * 100.0))
		weighted.push(this.Math.floor((a.RangedSkill[1] - b.RangedSkill) / (a.RangedSkill[1] - a.RangedSkill[0]) * 100.0))
		weighted.push(this.Math.floor((a.MeleeDefense[1] - b.MeleeDefense) / (a.MeleeDefense[1] - a.MeleeDefense[0]) * 100.0))
		weighted.push(this.Math.floor((a.RangedDefense[1] - b.RangedDefense) / (a.RangedDefense[1] - a.RangedDefense[0]) * 100.0))
		return weighted;
	}

	function rebuildPerkTree( _tree )
	{
		this.m.CustomPerkTree = _tree
		if (this.World.Assets.isLegendPerkTrees())
		{
			this.m.CustomPerkTree = this.Const.Perks.MergeDynamicPerkTree(_tree, this.m.PerkTreeDynamic);
		}
		local pT = this.Const.Perks.BuildCustomPerkTree(this.m.CustomPerkTree);
		this.m.PerkTree = pT.Tree;
		this.m.PerkTreeMap = pT.Map;
	}

	function buildPerkTree()
	{
	local a = {
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
				0,
				0
			],
			RangedSkill = [
				0,
				0
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
		if (this.m.PerkTree != null)
		{
			return a;
		}

		if (this.m.CustomPerkTree == null)
		{
			if (this.World.Assets.isLegendPerkTrees())
			{
				local result  = this.Const.Perks.GetDynamicPerkTree(this.m.PerkTreeDynamicMins, this.m.PerkTreeDynamic);
				this.m.CustomPerkTree = result.Tree
				a = result.Attributes;
			}
			else
			{
				this.m.CustomPerkTree = this.Const.Perks.DefaultCustomPerkTree;
			}
		}

		local pT = this.Const.Perks.BuildCustomPerkTree(this.m.CustomPerkTree);

		//When deserializing, the scenario isn't set yet, so it will be null - in this case, the sceario should
		//already have added its perks so we should be ok. This will fail though loading an old save
		//and we've added new perks to a scenario...
		local origin = this.World.Assets.getOrigin()
		if (origin != null)
		{
			this.World.Assets.getOrigin().onBuildPerkTree(pT);
		}

		this.m.PerkTree = pT.Tree;
		this.m.PerkTreeMap = pT.Map;
		return a
	}

	function updateAppearance()
	{
	}

	function addEquipment()
	{
		if (this.Const.LegendMod.Configs.LegendArmorsEnabled())
		{
			this.onAddLegendEquipment()
		}
		else
		{
			this.onAddEquipment();
		}

		this.adjustHiringCostBasedOnEquipment();
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().hasSkill("trait.player"))
		{
			_properties.DailyWage = 0;
		}
		else
		{
			local level = this.getContainer().getActor().getLevel();
			local wage = this.Math.round(this.m.DailyCost * this.m.DailyCostMult);
			_properties.DailyWage += wage * this.Math.pow(1.1, this.Math.min(10, level - 1));

			if (level > 11)
			{
				local previous = wage * this.Math.pow(1.1, 10);
				_properties.DailyWage += previous * this.Math.pow(1.03, level - 1 - 10) - previous;
			}
		}
	}

	function adjustHiringCostBasedOnEquipment()
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
		local items = actor.getItems().getAllItems();
		local cost = 0;

		foreach( i in items )
		{
			cost = cost + i.getValue();
		}

		cost = cost * 1.25;
		actor.m.HiringCost = actor.m.HiringCost + cost;
		actor.m.HiringCost *= 0.1;
		actor.m.HiringCost = this.Math.ceil(actor.m.HiringCost);
		actor.m.HiringCost *= 10;
	}

	function setAppearance(_tag = null)
	{
		if (this.m.HairColors == null)
		{
			return;
		}

		if (_tag == "zombie")
		{
			local actor = this.getContainer().getActor();
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];

			local body = actor.getSprite("body");
			body.setBrush(this.m.Body);
			body.Saturation = 0.5;
			body.varySaturation(0.2);
			body.Color = this.createColor("#c1ddaa");
			body.varyColor(0.05, 0.05, 0.05);
			actor.getSprite("injury_body").setBrush("zombify_body_01");

			local head = actor.getSprite("head");
			head.setBrush(this.m.Faces[this.Math.rand(0, this.m.Faces.len() - 1)]);
			head.Saturation = body.Saturation;
			head.Color = body.Color;

			local hair = actor.getSprite("hair");
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.Zombie[this.Math.rand(0, this.Const.Hair.Zombie.len() - 1)]);
			hair.varyColor(0.02, 0.02, 0.02);

			if (this.Math.rand(1, 100) <= this.m.BeardChance)
			{
				local beard = actor.getSprite("beard");
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.Zombie[this.Math.rand(0, this.Const.Beards.Zombie.len() - 1)]);
				beard.Color = hair.Color;

				if (this.doesBrushExist(beard.getBrush().Name + "_top"))
				{
					local sprite = actor.getSprite("beard_top");
					sprite.setBrush(beard.getBrush().Name + "_top");
					sprite.Color = actor.getSprite("hair").Color;
				}
			}
		}
		else if (_tag == "skeleton")
		{
			local actor = this.getContainer().getActor();
			local hairColor = this.Const.HairColors.Zombie[this.Math.rand(0, this.Const.HairColors.Zombie.len() - 1)];

			local body = actor.getSprite("body");
			body.setBrush("bust_skeleton_body_0" + this.Math.rand(1, 2));
			body.Saturation = 0.8;
			body.varySaturation(0.2);
			body.varyColor(0.025, 0.025, 0.025);
			actor.getSprite("injury_body").setBrush("bust_skeleton_body_injured");

			local head = actor.getSprite("head");
			head.setBrush("bust_skeleton_head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;

			local hair = actor.getSprite("hair");
			hair.setBrush("hair_" + hairColor + "_" + this.Const.Hair.ZombieOnly[this.Math.rand(0, this.Const.Hair.ZombieOnly.len() - 1)]);
			hair.varyColor(0.02, 0.02, 0.02);

			if (this.Math.rand(1, 100) <= this.m.BeardChance)
			{
				local beard = actor.getSprite("beard");
				beard.setBrush("beard_" + hairColor + "_" + this.Const.Beards.ZombieOnly[this.Math.rand(0, this.Const.Beards.ZombieOnly.len() - 1)]);
				beard.Color = hair.Color;

				if (this.doesBrushExist(beard.getBrush().Name + "_top"))
				{
					local sprite = actor.getSprite("beard_top");
					sprite.setBrush(beard.getBrush().Name + "_top");
					sprite.Color = actor.getSprite("hair").Color;
				}
			}
		}
		else
		{
			local actor = this.getContainer().getActor();
			local hairColor = this.m.HairColors[this.Math.rand(0, this.m.HairColors.len() - 1)];

			if (this.m.Faces != null)
			{
				local sprite = actor.getSprite("head");
				sprite.setBrush(this.m.Faces[this.Math.rand(0, this.m.Faces.len() - 1)]);
				sprite.Color = this.createColor("#fbffff");
				sprite.varyColor(0.05, 0.05, 0.05);
				sprite.varySaturation(0.1);
				local body = actor.getSprite("body");
				body.Color = sprite.Color;
				body.Saturation = sprite.Saturation;
			}

			if (this.m.Hairs != null && this.Math.rand(0, this.m.Hairs.len()) != this.m.Hairs.len())
			{
				local sprite = actor.getSprite("hair");
				sprite.setBrush("hair_" + hairColor + "_" + this.m.Hairs[this.Math.rand(0, this.m.Hairs.len() - 1)]);

				if (hairColor != "grey")
				{
					sprite.varyColor(0.1, 0.1, 0.1);
				}
				else
				{
					sprite.varyBrightness(0.1);
				}
			}

			if (this.m.Beards != null && this.Math.rand(1, 100) <= this.m.BeardChance)
			{
				local beard = actor.getSprite("beard");
				beard.setBrush("beard_" + hairColor + "_" + this.m.Beards[this.Math.rand(0, this.m.Beards.len() - 1)]);
				beard.Color = actor.getSprite("hair").Color;

				if (this.doesBrushExist(beard.getBrush().Name + "_top"))
				{
					local sprite = actor.getSprite("beard_top");
					sprite.setBrush(beard.getBrush().Name + "_top");
					sprite.Color = actor.getSprite("hair").Color;
				}
			}

			if (this.m.Body != null)
			{
				actor.getSprite("body").setBrush(this.m.Body);
				actor.getSprite("injury_body").setBrush(this.m.Body + "_injured");
			}
		}

		this.onSetAppearance();
	}

	function onAddEquipment()
	{
	}

	function onAddLegendEquipment()
	{

	}

	function onSetAppearance()
	{
	}

	function onAdded()
	{
		this.m.DailyCost += 1;
		local actor = this.getContainer().getActor();
		actor.m.Background = this;

		if (this.m.IsNew && !(("State" in this.Tactical) && this.Tactical.State != null && this.Tactical.State.isScenarioMode()))
		{
			this.m.IsNew = false;

			if (actor.getTitle() == "" && this.m.Titles.len() != 0 && this.Math.rand(0, 3) == 3)
			{
				actor.setTitle(this.m.Titles[this.Math.rand(0, this.m.Titles.len() - 1)]);
			}

			if (this.m.Level != 1)
			{
				actor.m.PerkPoints = this.m.Level - 1;
				actor.m.LevelUps = this.m.Level - 1;
				actor.m.Level = this.m.Level;
				actor.m.XP = this.Const.LevelXP[this.m.Level - 1];
			}
		}
	}

	function onBuildDescription()
	{
		return "";
	}

	function onChangeAttributes()
	{
		local c = {
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
				0,
				0
			],
			RangedSkill = [
				0,
				0
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
		return c;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeString(this.m.Description);
		_out.writeString(this.m.RawDescription);
		_out.writeU8(this.m.Level);
		_out.writeBool(this.m.IsNew);
		_out.writeF32(this.m.DailyCostMult);
		if (this.m.CustomPerkTree == null)
		{
			_out.writeU8(0);
		}
		else
		{
			_out.writeU8(this.m.CustomPerkTree.len());
			for( local i = 0; i < this.m.CustomPerkTree.len(); i = ++i )
			{
				_out.writeU8(this.m.CustomPerkTree[i].len());
				for( local j = 0; j < this.m.CustomPerkTree[i].len(); j = ++j )
				{
					_out.writeU16(this.m.CustomPerkTree[i][j]);
				}
			}
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Description = _in.readString();
		this.m.RawDescription = _in.readString();
		this.m.Level = _in.readU8();
		this.m.IsNew = _in.readBool();

		if (_in.getMetaData().getVersion() >= 39)
		{
			this.m.DailyCostMult = _in.readF32();
		}
		else
		{
			this.m.DailyCostMult = 1.0;
		}

		if (_in.getMetaData().getVersion() >= 57)
		{
			this.m.CustomPerkTree = [];
			local numRows = _in.readU8();
			for( local i = 0; i < numRows; i = ++i )
	        {
				local numPerks = _in.readU8();
				local perks = [];
				for( local j = 0; j < numPerks; j = ++j )
				{
					perks.push(_in.readU16())
				}
				this.m.CustomPerkTree.push(perks);
			}
		}

		if (this.m.CustomPerkTree != null)
		{
			this.buildPerkTree();
		}
	}

});

