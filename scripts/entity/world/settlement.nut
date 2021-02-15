this.settlement <- this.inherit("scripts/entity/world/location", {
	m = {
		Buildings = [],
		CurrentBuilding = null,
		AttachedLocations = [],
		AttachedLocationsMax = 0,
		UIDescription = "",
		UIBackground = null,
		UIBackgroundCenter = null,
		UIBackgroundLeft = null,
		UIBackgroundRight = null,
		UIRamp = null,
		UIRampPathway = null,
		UIMood = null,
		UIForeground = null,
		UISprite = null,
		Sprite = "",
		Lighting = "",
		Sounds = [],
		SoundsAtNight = [],
		Situations = [],
		DraftList = [],
		FemaleDraftList = [],
		StablesList = [],
		Rumors = [],
		Size = 1,
		HousesMin = 0,
		HousesMax = 0,
		HousesType = 1,
		HousesTiles = [],
		LastPreload = 0.0,
		PreloadState = 0,
		LastShopUpdate = 0.0,
		LastRosterUpdate = 0.0,
		LastStablesUpdate = 0.0,
		ShopSeed = 0,
		RosterSeed = 0,
		StablesSeed = 0,
		Owner = null,
		Factions = [],
		Culture = 0,
		ProduceString = "goods",
		Produce = [],
		ProduceImported = [],
		Modifiers = null,
		DeepOceanTile = null,
		ConnectedTo = [],
		ConnectedToByRoads = [],
		IsCoastal = false,
		IsMilitary = false,
		IsActive = true,
		IsUpgrading = false
	},
	function setUpgrading( _v )
	{
		this.m.IsUpgrading = _v;
	}

	function isUpgrading()
	{
		return this.m.IsUpgrading;
	}

	function setSize( _v )
	{
		this.m.Size = _v;

		if (this.m.Name == "")
		{
			this.m.Name = this.getRandomName(this.m.Names[_v - 1]);

			if (this.hasLabel("name"))
			{
				this.getLabel("name").Text = this.m.Name;
			}
		}

		this.updateSprites();
	}

	function changeSize( _v )
	{
		this.setUpgrading(false);
		_v = this.Math.max(1, _v);
		this.setSize(this.Math.min(3, _v));
	}

	function getDraftList()
	{
		local L = clone this.m.DraftList;

		if (this.LegendsMod.Configs().LegendGenderEnabled())
		{
			L.extend(this.m.FemaleDraftList);
		}

		return L;
	}

	function getStablesList()
	{
		return this.m.StablesList;
	}

	function getHousesMin()
	{
		return this.m.HousesMin;
	}

	function getHousesMax()
	{
		return this.m.HousesMax;
	}

	function getHousesType()
	{
		return this.m.HousesType;
	}

	function getAttachedLocationsMax()
	{
		return this.m.AttachedLocationsMax;
	}

	function getAttachedLocations()
	{
		return this.m.AttachedLocations;
	}

	function getRosterMax()
	{
		return this.m.RosterMax;
	}

	function getSize()
	{
		return this.m.Size;
	}

	function getCurrentBuilding()
	{
		return this.m.CurrentBuilding;
	}

	function isIsolated()
	{
		return this.m.ConnectedTo.len() == 0;
	}

	function isIsolatedFromRoads()
	{
		return this.m.ConnectedToByRoads.len() == 0;
	}

	function isCoastal()
	{
		return this.m.IsCoastal;
	}

	function isMilitary()
	{
		return this.m.IsMilitary;
	}

	function isSouthern()
	{
		return false;
	}

	function isConnectedTo( _s )
	{
		return this.m.ConnectedTo.find(_s.getID()) != null;
	}

	function isConnectedToByRoads( _s )
	{
		return this.m.ConnectedToByRoads.find(_s.getID()) != null;
	}

	function getProduce()
	{
		return this.m.Produce;
	}

	function getProduceAsString()
	{
		return this.m.ProduceString;
	}

	function getSituations()
	{
		return this.m.Situations;
	}

	function getRumors()
	{
		return this.m.Rumors;
	}

	function getModifiers()
	{
		return this.m.Modifiers;
	}

	function getCulture()
	{
		return this.m.Culture;
	}

	function getDeepOceanTile()
	{
		return this.m.DeepOceanTile;
	}

	function getOwner()
	{
		return this.m.Owner;
	}

	function removeFaction( _f )
	{
		local r = this.m.Factions.find(_f);

		if (r != null)
		{
			this.m.Factions.remove(r);
		}
	}

	function getFactions()
	{
		return this.m.Factions;
	}

	function isEnterable()
	{
		if (!this.m.IsActive)
		{
			return false;
		}

		if (this.isMilitary() || this.isKindOf(this, "city_state"))
		{
			if (!this.getOwner().isAlliedWithPlayer())
			{
				return false;
			}
		}
		else if (!this.getFactionOfType(this.Const.FactionType.Settlement).isAlliedWithPlayer())
		{
			return false;
		}

		return true;
	}

	function addFaction( _f )
	{
		if (this.m.Factions.len() == 0)
		{
			this.setFaction(_f);

			foreach( a in this.m.AttachedLocations )
			{
				a.setFaction(_f);
			}
		}

		this.m.Factions.push(_f);
	}

	function setOwner( _o )
	{
		if (this.m.Owner != null)
		{
			this.m.Owner.removeSettlement(this);
		}

		this.m.Owner = this.WeakTableRef(_o);
		local location_banner = this.getSprite("location_banner");
		location_banner.setBrush(_o.getBannerSmall());
		location_banner.Visible = true;
	}

	function getFactionOfType( _type )
	{
		foreach( i in this.m.Factions )
		{
			local f = this.World.FactionManager.getFaction(i);

			if (f.getType() == _type)
			{
				return f;
			}
		}

		return null;
	}

	function getTooltip()
	{
		if (!this.m.IsActive)
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = "Ruins of " + this.getName()
				}
			];

			if (this.isMilitary())
			{
				ret.push({
					id = 2,
					type = "description",
					text = "Only ruins are left of what was once a formidable castle."
				});
			}
			else
			{
				ret.push({
					id = 2,
					type = "description",
					text = "Only ruins are left of what was once a flourishing town."
				});
			}

			return ret;
		}

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.m.IsVisited && this.isUpgrading())
		{
			ret.push({
				id = 3,
				type = "description",
				icon = "ui/icons/special.png",
				text = "Is currently being upgraded"
			});
		}

		if (this.m.IsVisited || this.World.State.getDistantVisionBonus())
		{
			foreach( b in this.m.Buildings )
			{
				if (b == null || b.isHidden() || b.getID() == "building.marketplace" || b.getID() == "building.crowd")
				{
					continue;
				}

				ret.push({
					id = 4,
					type = "text",
					icon = b.getTooltipIcon(),
					text = b.getName()
				});
			}
		}
		else
		{
			ret.push({
				id = 4,
				type = "text",
				text = "You\'ve never been to this place."
			});
		}

		if (this.World.Retinue.hasFollower("follower.agent"))
		{
			local contracts = this.getContracts();

			foreach( i, c in contracts )
			{
				if (c.isActive())
				{
					continue;
				}

				ret.push({
					id = 10 + i,
					type = "text",
					icon = "ui/icons/contract_scroll.png",
					text = c.getName()
				});
			}
		}

		foreach( i in this.m.Factions )
		{
			local f = this.World.FactionManager.getFaction(i);
			ret.push({
				id = 5,
				type = "hint",
				icon = f.getUIBanner(),
				text = "Relations: " + f.getPlayerRelationAsText()
			});
		}

		if (this.World.State.getDistantVisionBonus())
		{
			foreach( s in this.m.Situations )
			{
				ret.push({
					id = 6,
					type = "text",
					text = "Has current event: " + s.getName()
				});
			}

			this.World.State.setDistantVisionBonus(false);
		}

		if (this.Const.LegendMod.DebugMode)
		{
			ret.push({
				id = 6,
				type = "hint",
				text = "Resources: " + this.getResources()
			});
		}

		if (this.Const.LegendMod.DebugMode)
		{
			ret.push({
				id = 6,
				type = "hint",
				text = "Generating Resources: " + this.getNewResources()
			});
		}

		if (this.Const.LegendMod.DebugMode || this.m.IsVisited && this.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			ret.push({
				id = 6,
				type = "hint",
				text = "Wealth " + this.getWealth() + " %"
			});
		}

		if (this.World.Retinue.hasFollower("follower.agent"))
		{
			local contracts = this.getContracts();
			local situations = this.getSituations();
			local addedSituations = {};

			foreach( i, s in situations )
			{
				if (s.isValid() && !(s.getValidUntil() == 0 && !this.World.Contracts.hasContractWithSituation(s.getInstanceID())))
				{
					local id = s.getID();

					if (!(id in addedSituations))
					{
						ret.push({
							id = 10 + contracts.len() + i,
							type = "text",
							icon = s.getIcon(),
							text = s.getName()
						});
						addedSituations[id] <- true;
					}
				}
			}
		}

		return ret;
	}

	function getWealth()
	{
		local baseLevel = 0.0;

		if (this.isMilitary())
		{
			baseLevel = baseLevel + 50.0;
		}

		if (this.isKindOf(this, "city_state"))
		{
			baseLevel = baseLevel + 100;
		}

		switch(this.getSize())
		{
		case 1:
			baseLevel = baseLevel + 100.0;
			break;

		case 2:
			baseLevel = baseLevel + 150.0;
			break;

		case 3:
			baseLevel = baseLevel + 200.0;
			break;
		}

		return this.Math.round(100.0 * (1.0 * this.getResources() / baseLevel));
	}

	function getImagePath()
	{
		return this.m.UISprite;
	}

	function getSpriteName()
	{
		local s = this.m.Sprite;

		if (this.LegendsMod.Configs().LegendWorldEconomyEnabled())
		{
			s = "legend_" + this.m.Sprite;
		}

		if (this.isUpgrading())
		{
			s = s + "_upgrade";
		}

		return s;
	}

	function getUIContractInformation()
	{
		this.m.Modifiers.reset();

		foreach( s in this.m.Situations )
		{
			s.onUpdate(this.m.Modifiers);
		}

		local result = {
			Contracts = [],
			IsContractActive = this.World.Contracts.getActiveContract() != null,
			IsContractsLocked = false
		};
		local contracts = this.getContracts();

		foreach( i, contract in contracts )
		{
			if (i > 9)
			{
				break;
			}

			if (contract.isActive())
			{
				continue;
			}

			local c = {
				Icon = contract.getBanner(),
				ID = contract.getID(),
				IsNegotiated = contract.isNegotiated(),
				DifficultyIcon = contract.getUIDifficultySmall()
			};
			result.Contracts.push(c);
		}

		if (result.Contracts.len() == 0 && this.m.IsMilitary && !this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			result.IsContractsLocked = true;
		}

		return result;
	}

	function getUIDescription()
	{
		return this.m.UIDescription;
	}

	function getUIBackground()
	{
		return this.m.UIBackground;
	}

	function getUIBackgroundCenter()
	{
		return this.m.UIBackgroundCenter;
	}

	function getUIBackgroundLeft()
	{
		return this.m.UIBackgroundLeft;
	}

	function getUIBackgroundRight()
	{
		return this.m.UIBackgroundRight;
	}

	function getUIRamp()
	{
		return this.m.UIRamp;
	}

	function getUIRampPathway()
	{
		return this.m.UIRampPathway;
	}

	function getUIMood()
	{
		return this.m.UIMood;
	}

	function getUIForeground()
	{
		return this.m.UIForeground;
	}

	function getLighting()
	{
		return this.m.Lighting;
	}

	function getUIInformation()
	{
		local night = !this.World.getTime().IsDaytime;
		local water = this.m.IsCoastal ? "ui/settlements/water_01" : null;
		local result = {
			Title = this.getName(),
			SubTitle = this.getUIDescription(),
			Assets = this.UIDataHelper.convertAssetsInformationToUIData(),
			HeaderImagePath = null,
			Background = this.getUIBackground() + (night ? "_night" : "") + ".jpg",
			BackgroundCenter = this.getUIBackgroundCenter() + (night ? "_night" : "") + ".png",
			BackgroundLeft = this.getUIBackgroundLeft() + (night ? "_night" : "") + ".png",
			BackgroundRight = this.getUIBackgroundRight() + (night ? "_night" : "") + ".png",
			Ramp = this.getUIRamp() + (night ? "_night" : "") + ".png",
			RampPathway = this.getUIRampPathway() != null ? this.getUIRampPathway() + (night ? "_night" : "") + ".png" : null,
			Mood = this.getUIMood() != null ? this.getUIMood() + ".png" : null,
			Foreground = this.getUIForeground() != null ? this.getUIForeground() + (night ? "_night" : "") + ".png" : null,
			Water = water != null ? water + (night ? "_night" : "") + ".png" : null,
			Slots = [],
			Situations = [],
			Contracts = [],
			IsContractActive = this.World.Contracts.getActiveContract() != null,
			IsContractsLocked = false
		};

		foreach( building in this.m.Buildings )
		{
			if (building == null || building.isHidden())
			{
				result.Slots.push(null);
			}
			else
			{
				local b = {
					Image = building.getUIImage(),
					Tooltip = building.getTooltip()
				};
				result.Slots.push(b);
			}
		}

		foreach( situation in this.m.Situations )
		{
			local exists = false;

			foreach( e in result.Situations )
			{
				if (e.ID == situation.getID())
				{
					exists = true;
					break;
				}
			}

			if (exists)
			{
				continue;
			}

			result.Situations.push({
				ID = situation.getID(),
				Icon = situation.getIcon()
			});
		}

		local contracts = this.getContracts();

		foreach( i, contract in contracts )
		{
			if (i > 9)
			{
				break;
			}

			if (contract.isActive())
			{
				continue;
			}

			local c = {
				Icon = contract.getBanner(),
				ID = contract.getID(),
				IsNegotiated = contract.isNegotiated(),
				DifficultyIcon = contract.getUIDifficultySmall()
			};
			result.Contracts.push(c);
		}

		if (result.Contracts.len() == 0 && this.m.IsMilitary && !this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			result.IsContractsLocked = true;
		}

		return result;
	}

	function getUIPreloadInformation()
	{
		local night = !this.World.getTime().IsDaytime;
		local water = this.m.IsCoastal ? "ui/settlements/water_01" : null;
		local result = {
			Background = this.getUIBackground() + (night ? "_night" : "") + ".jpg",
			BackgroundCenter = this.getUIBackgroundCenter() + (night ? "_night" : "") + ".png",
			BackgroundLeft = this.getUIBackgroundLeft() + (night ? "_night" : "") + ".png",
			BackgroundRight = this.getUIBackgroundRight() + (night ? "_night" : "") + ".png",
			Ramp = this.getUIRamp() + (night ? "_night" : "") + ".png",
			RampPathway = this.getUIRampPathway() != null ? this.getUIRampPathway() + (night ? "_night" : "") + ".png" : null,
			Mood = this.getUIMood() != null ? this.getUIMood() + ".png" : null,
			Foreground = this.getUIForeground() != null ? this.getUIForeground() + (night ? "_night" : "") + ".png" : null,
			Water = water != null ? water + (night ? "_night" : "") + ".png" : null,
			Slots = []
		};

		foreach( building in this.m.Buildings )
		{
			if (building == null || building.isHidden())
			{
				result.Slots.push(null);
			}
			else
			{
				local b = {
					Image = building.getUIImage(),
					Tooltip = building.getTooltip()
				};
				result.Slots.push(b);
			}
		}

		return result;
	}

	function getContracts()
	{
		local contracts = [];

		foreach( f in this.m.Factions )
		{
			foreach( c in this.World.FactionManager.getFaction(f).getContracts() )
			{
				if ((c.getHome() == null || c.getHome().getID() == this.getID()) && (c.getOrigin() == null || c.getOrigin().isNull() || c.getOrigin().getID() != this.getID() || c.getHome() != null && !c.getHome().isNull() && c.getOrigin().getID() == c.getHome().getID()))
				{
					contracts.push(c);
				}
			}
		}

		return contracts;
	}

	function hasContract( _id )
	{
		local contracts = this.getContracts();

		foreach( c in contracts )
		{
			if (c.getType() == _id)
			{
				return true;
			}
		}

		return false;
	}

	function getSounds( _all = true )
	{
		local sounds;

		if (!this.isActive())
		{
			return sounds;
		}

		if (this.World.getTime().IsDaytime)
		{
			sounds = clone this.m.Sounds;
			sounds.extend(this.Const.SoundAmbience.GeneralSettlement);

			if (this.m.Size >= 2)
			{
				sounds.extend(this.Const.SoundAmbience.LargeSettlement);
			}

			if (this.m.Size >= 3)
			{
				sounds.extend(this.Const.SoundAmbience.VeryLargeSettlement);
			}

			if (this.m.IsMilitary)
			{
				sounds.extend(this.Const.SoundAmbience.GeneralMilitary);
			}
			else
			{
				sounds.extend(this.Const.SoundAmbience.CivilianSettlement);
			}
		}
		else
		{
			sounds = clone this.m.SoundsAtNight;
			sounds.extend(this.Const.SoundAmbience.GeneralSettlementAtNight);

			if (this.m.IsMilitary)
			{
				sounds.extend(this.Const.SoundAmbience.GeneralMilitaryAtNight);
			}
		}

		if (_all)
		{
			foreach( building in this.m.Buildings )
			{
				if (building != null)
				{
					sounds.extend(building.getSounds());
				}
			}
		}

		return sounds;
	}

	function getMusic()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return [];
		}

		if (this.isSouthern())
		{
			return this.Const.Music.CityStateTracks;
		}
		else if (this.m.IsMilitary)
		{
			return this.Const.Music.StrongholdTracks;
		}
		else if (this.m.Size <= 1)
		{
			return this.Const.Music.VillageTracks;
		}
		else
		{
			return this.Const.Music.CityTracks;
		}
	}

	function addImportedProduce( _p )
	{
		this.m.ProduceImported.push(_p);
	}

	function getFoodPriceMult()
	{
		return this.m.Modifiers.FoodPriceMult;
	}

	function getPriceMult()
	{
		local p;

		if (this.m.Size <= 1)
		{
			p = 0.95 + this.getActiveAttachedLocations().len() * 0.03;
		}
		else if (this.m.Size == 2)
		{
			p = 1.02 + this.getActiveAttachedLocations().len() * 0.03;
		}
		else if (this.m.Size == 3)
		{
			p = 1.1 + this.getActiveAttachedLocations().len() * 0.03;
		}

		return p * this.m.Modifiers.PriceMult;
	}

	function getBuyPriceMult()
	{
		local p = this.getPriceMult() * this.World.Assets.getBuyPriceMult();
		local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();

		if (r < 50)
		{
			p = p + (50.0 - r) * 0.006;
		}
		else if (r > 50)
		{
			p = p - (r - 50.0) * 0.003;
		}

		local barterMult = this.World.State.getPlayer().getBarterMult();

		if (this.m.Modifiers.BuyPriceMult - barterMult >= 0.01)
		{
			p = p * (this.m.Modifiers.BuyPriceMult - barterMult);
		}

		return p;
	}

	function getSellPriceMult()
	{
		local p = this.getPriceMult() * this.World.Assets.getSellPriceMult();
		local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();

		if (r < 50)
		{
			p = p - (50.0 - r) * 0.006;
		}
		else if (r > 50)
		{
			p = p + (r - 50.0) * 0.003;
		}

		local barterMult = this.World.State.getPlayer().getBarterMult();
		p = p * (this.m.Modifiers.SellPriceMult + barterMult);
		return p;
	}

	function getActiveAttachedLocations()
	{
		local ret = [];

		foreach( a in this.m.AttachedLocations )
		{
			if (a.isActive())
			{
				ret.push(a);
			}
		}

		return ret;
	}

	function create()
	{
		this.location.create();
		this.m.LocationType = this.Const.World.LocationType.Settlement;
		this.m.Banner = "banner_noble_11";
		this.m.ShopSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.RosterSeed = this.Time.getRealTime() + this.Math.rand();
		this.m.Modifiers = this.new("scripts/entity/world/settlement_modifiers");
		this.m.IsAttackable = false;
		this.m.IsDestructible = false;
		this.m.IsShowingStrength = true;
		this.m.IsScalingDefenders = true;
		this.m.IsShowingLabel = true;
		this.m.VisibilityMult = 2.0;
		this.m.Buildings.resize(6, null);
	}

	function getSituationByID( _id )
	{
		foreach( e in this.m.Situations )
		{
			if (e.getID() == _id)
			{
				return e;
			}
		}

		return null;
	}

	function getSituationByInstance( _instanceID )
	{
		foreach( e in this.m.Situations )
		{
			if (e.getInstanceID() == _instanceID)
			{
				return e;
			}
		}

		return null;
	}

	function hasSituation( _id )
	{
		foreach( e in this.m.Situations )
		{
			if (e.getID() == _id)
			{
				return true;
			}
		}

		return false;
	}

	function addSituation( _s, _validForDays = 0 )
	{
		if (!_s.isStacking())
		{
			this.removeSituationByID(_s.getID());
		}

		if (this.m.Situations.len() >= 10)
		{
			this.m.Situations[0].onRemoved(this);
			this.m.Situations.remove(0);
		}

		this.m.Situations.push(_s);
		_s.setInstanceID(this.World.EntityManager.getNextSituationID());

		if (_validForDays != 0)
		{
			_s.setValidForDays(_validForDays);
		}
		else if (_s.getDefaultDays() != 0)
		{
			_s.setValidForDays(_s.getDefaultDays());
		}

		_s.onAdded(this);
		_s.m.IsSouthern = this.isSouthern();
		this.m.Modifiers.reset();

		foreach( s in this.m.Situations )
		{
			s.onUpdate(this.m.Modifiers);
		}

		return _s.getInstanceID();
	}

	function removeSituationByID( _id )
	{
		foreach( i, e in this.m.Situations )
		{
			if (e.getID() == _id)
			{
				e.onRemoved(this);
				this.m.Situations.remove(i);
				this.m.Modifiers.reset();

				foreach( s in this.m.Situations )
				{
					s.onUpdate(this.m.Modifiers);
				}

				break;
			}
		}
	}

	function removeSituationByInstance( _instanceID )
	{
		foreach( i, e in this.m.Situations )
		{
			if (e.getInstanceID() == _instanceID)
			{
				e.onRemoved(this);
				this.m.Situations.remove(i);
				this.m.Modifiers.reset();

				foreach( s in this.m.Situations )
				{
					s.onUpdate(this.m.Modifiers);
				}

				return 0;
			}
		}

		return _instanceID;
	}

	function resolveSituationByInstance( _instanceID )
	{
		foreach( i, e in this.m.Situations )
		{
			if (e.getInstanceID() == _instanceID)
			{
				e.onResolved(this);
				this.m.Situations.remove(i);
				this.m.Modifiers.reset();

				foreach( s in this.m.Situations )
				{
					s.onUpdate(this.m.Modifiers);
				}

				return 0;
			}
		}

		return _instanceID;
	}

	function updateSituations()
	{
		local garbage = [];

		foreach( i, s in this.m.Situations )
		{
			if (!s.isValid())
			{
				garbage.push(i);
			}
			else if (s.getValidUntil() == 0)
			{
				if (!this.World.Contracts.hasContractWithSituation(s.getInstanceID()))
				{
					garbage.push(i);
				}
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Situations[g].onRemoved(this);
			this.m.Situations.remove(g);
		}
	}

	function getSituations()
	{
		return this.m.Situations;
	}

	function hasFreeBuildingSlot()
	{
		for( local i = 0; i < this.m.Buildings.len(); i = i )
		{
			if (this.m.Buildings[i] == null)
			{
				return true;
			}

			i = ++i;
		}

		return false;
	}

	function addBuilding( _building, _slot = null )
	{
		_building.setSettlement(this);

		if (_slot != null)
		{
			this.m.Buildings[_slot] = _building;
		}
		else
		{
			local candidates = [];

			for( local i = 0; i < this.m.Buildings.len(); i = i )
			{
				if (this.m.Buildings[i] == null)
				{
					candidates.push(i);
				}

				i = ++i;
			}

			if (candidates.len() != 0)
			{
				this.m.Buildings[candidates[this.Math.rand(0, candidates.len() - 1)]] = _building;
			}
		}

		if (_building.getID() == "building.barber")
		{
			++this.Const.World.Buildings.Barbers;
		}
		else if (_building.getID() == "building.kennel")
		{
			++this.Const.World.Buildings.Kennels;
		}
		else if (_building.getID() == "building.fletcher")
		{
			++this.Const.World.Buildings.Fletchers;
		}
		else if (_building.getID() == "building.temple")
		{
			++this.Const.World.Buildings.Temples;
		}
		else if (_building.getID() == "building.taxidermist")
		{
			++this.Const.World.Buildings.Taxidermists;
		}
		else if (_building.getID() == "building.stables")
		{
			++this.Const.World.Buildings.Stables;
		}
		else if (_building.getID() == "building.taxidermist_oriental")
		{
			++this.Const.World.Buildings.TaxidermistsOriental;
		}
		else if (_building.getID() == "building.alchemist")
		{
			++this.Const.World.Buildings.Alchemists;
		}
		else if (_building.getID() == "building.arena")
		{
			++this.Const.World.Buildings.Arenas;
		}
		else if (_building.getID() == "building.weaponsmith_oriental")
		{
			++this.Const.World.Buildings.WeaponsmithsOriental;
		}
		else if (_building.getID() == "building.armorsmith_oriental")
		{
			++this.Const.World.Buildings.ArmorsmithsOriental;
		}
	}

	function buildNewLocation()
	{
		return null;
	}

	function buildAttachedLocation( _num, _script, _terrain, _nearbyTerrain, _additionalDistance = 0, _mustBeNearRoad = false, _clearTile = true, _force = false )
	{
		_num = this.Math.min(_num, this.getAttachedLocationsMax() - this.m.AttachedLocations.len());

		if (_num <= 0 && !_force)
		{
			return;
		}

		local tries = 0;
		local myTile = this.getTile();
		local entity;

		while (_num > 0 && tries++ < 1000)
		{
			local x = this.Math.rand(myTile.SquareCoords.X - 2 - _additionalDistance, myTile.SquareCoords.X + 2 + _additionalDistance);
			local y = this.Math.rand(myTile.SquareCoords.Y - 2 - _additionalDistance, myTile.SquareCoords.Y + 2 + _additionalDistance);

			if (!this.World.isValidTileSquare(x, y))
			{
				continue;
			}

			local tile = this.World.getTileSquare(x, y);

			if (tile.IsOccupied)
			{
				continue;
			}

			if (_mustBeNearRoad && tile.HasRoad)
			{
				continue;
			}

			if (tile.getDistanceTo(myTile) == 1 && _additionalDistance >= 0 || tile.getDistanceTo(myTile) < _additionalDistance)
			{
				continue;
			}

			local terrainFits = false;

			foreach( t in _terrain )
			{
				if (t == tile.Type)
				{
					if (_nearbyTerrain.len() == 0 && !_mustBeNearRoad)
					{
						terrainFits = true;
					}
					else
					{
						for( local i = 0; i < 6; i = i )
						{
							if (!tile.hasNextTile(i))
							{
							}
							else
							{
								local next = tile.getNextTile(i);

								if (_mustBeNearRoad && !next.HasRoad)
								{
								}
								else
								{
									if (_nearbyTerrain.len() != 0)
									{
										foreach( n in _nearbyTerrain )
										{
											if (next.Type == n)
											{
												terrainFits = true;
												break;
											}
										}
									}
									else
									{
										terrainFits = true;
									}

									if (terrainFits)
									{
										break;
									}
								}
							}

							i = ++i;
						}
					}

					if (terrainFits)
					{
						break;
					}
				}
			}

			if (!terrainFits)
			{
				continue;
			}

			if (tile.getDistanceTo(myTile) > 2)
			{
				local navSettings = this.World.getNavigator().createSettings();
				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
				local path = this.World.getNavigator().findPath(myTile, tile, navSettings, 0);

				if (path.isEmpty())
				{
					continue;
				}
			}

			if (_clearTile)
			{
				tile.clearAllBut(this.Const.World.DetailType.Shore);
			}
			else
			{
				tile.clear(this.Const.World.DetailType.NotCompatibleWithRoad);
			}

			entity = this.World.spawnLocation(_script, tile.Coords);
			entity.setSettlement(this);

			if (entity.onBuild())
			{
				this.m.AttachedLocations.push(entity);
				_num = --_num;
				_num = _num;
				tries = 0;

				if (entity.isUsable() && !entity.isMilitary() && this.Math.rand(1, 100) <= 8)
				{
					entity.setActive(false);
				}
			}
			else
			{
				entity.die();
				continue;
			}
		}

		this.updateProduce();
		return entity;
	}

	function hasAttachedLocation( _id )
	{
		foreach( a in this.m.AttachedLocations )
		{
			if (a.isActive() && a.getTypeID() == _id)
			{
				return true;
			}
		}

		return false;
	}

	function hasBuilding( _id )
	{
		foreach( b in this.m.Buildings )
		{
			if (b != null && b.getID() == _id)
			{
				return true;
			}
		}

		return false;
	}

	function getBuilding( _id )
	{
		foreach( b in this.m.Buildings )
		{
			if (b != null && b.getID() == _id)
			{
				return b;
			}
		}

		return null;
	}

	function getRandomName( _names )
	{
		local name;
		local settlements = this.World.EntityManager.getSettlements();

		while (true)
		{
			name = _names[this.Math.rand(0, _names.len() - 1)];
			local duplicate = false;

			foreach( s in settlements )
			{
				if (s.getName() == name)
				{
					duplicate = true;
					break;
				}
			}

			if (!duplicate)
			{
				break;
			}
		}

		return name;
	}

	function build( _settings = null )
	{
		if (this.m.IsCoastal && (this.m.Buildings[3] == null || this.m.Buildings[3].getID() != "building.port"))
		{
			this.addBuilding(this.new("scripts/entity/world/settlements/buildings/port_building"), 3);
			this.m.UIBackgroundLeft = "ui/settlements/water_01";
		}

		this.onBuild(_settings);

		if (this.m.Size <= 1)
		{
			this.m.Resources = 100;
		}
		else if (this.m.Size == 2)
		{
			this.m.Resources = 150;
		}
		else if (this.m.Size == 3)
		{
			this.m.Resources = 200;
		}

		if (this.isMilitary())
		{
			this.m.Resources += 50;
		}

		if (this.isKindOf(this, "city_state"))
		{
			this.m.Resources += 100;
		}

		if (this.getHousesMax() > 0)
		{
			local tile = this.getTile();
			local candidates = [];
			local poorCandidates = [];

			for( local i = 0; i < 6; i = i )
			{
				if (!tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = tile.getNextTile(i);

					if (nextTile.IsOccupied)
					{
					}
					else if (nextTile.Type == this.Const.World.TerrainType.Oasis || nextTile.Type == this.Const.World.TerrainType.Plains || nextTile.Type == this.Const.World.TerrainType.Tundra || nextTile.Type == this.Const.World.TerrainType.Steppe || nextTile.Type == this.Const.World.TerrainType.Snow)
					{
						candidates.push(nextTile);
					}
					else if (nextTile.Type == this.Const.World.TerrainType.Desert || nextTile.Type == this.Const.World.TerrainType.Hills || nextTile.Type == this.Const.World.TerrainType.Forest || nextTile.Type == this.Const.World.TerrainType.SnowyForest || nextTile.Type == this.Const.World.TerrainType.LeaveForest || nextTile.Type == this.Const.World.TerrainType.AutumnForest || nextTile.Type == this.Const.World.TerrainType.Swamp)
					{
						poorCandidates.push(nextTile);
					}
				}

				i = ++i;
			}

			local houses = this.Math.min(this.Math.rand(this.getHousesMin(), this.getHousesMax()), candidates.len() + poorCandidates.len());

			for( local c; houses != 0; houses = houses )
			{
				local c = candidates.len() != 0 ? candidates : poorCandidates;
				local i = this.Math.rand(0, c.len() - 1);
				local v = this.Math.rand(1, 2);
				this.m.HousesTiles.push({
					X = c[i].SquareCoords.X,
					Y = c[i].SquareCoords.Y,
					V = v
				});
				c[i].clear();
				c[i].IsOccupied = true;
				local d = c[i].spawnDetail("world_houses_0" + this.getHousesType() + "_0" + v, this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
				d.Scale = 0.85;
				c.remove(i);
				houses = --houses;
			}
		}
	}

	function updateProduce()
	{
		this.m.Produce = [];

		foreach( a in this.m.AttachedLocations )
		{
			if (a.isActive())
			{
				a.onUpdateProduce(this.m.Produce);
			}
		}
	}

	function updateSituations()
	{
		local garbage = [];

		foreach( i, s in this.m.Situations )
		{
			if (!s.isValid())
			{
				garbage.push(i);
			}
			else if (s.getValidUntil() == 0)
			{
				if (!this.World.Contracts.hasContractWithSituation(s.getInstanceID()))
				{
					garbage.push(i);
				}
			}
		}

		garbage.reverse();

		foreach( g in garbage )
		{
			this.m.Situations[g].onRemoved(this);
			this.m.Situations.remove(g);
		}

		this.m.Modifiers.reset();

		foreach( s in this.m.Situations )
		{
			s.onUpdate(this.m.Modifiers);
		}

		foreach( building in this.m.Buildings )
		{
			if (building != null)
			{
				building.onSettlementEntered();
			}
		}
	}

	function resetRoster( _soft = false )
	{
		if (_soft)
		{
			this.m.LastRosterUpdate = this.Time.getVirtualTimeF() - 10.0 * this.World.getTime().SecondsPerDay;
		}
		else
		{
			this.m.LastRosterUpdate = -9000.0;
		}
	}

	function updateRoster( _force = false )
	{
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastRosterUpdate) / this.World.getTime().SecondsPerDay;

		if (!_force && this.m.LastRosterUpdate != 0 && daysPassed < 2)
		{
			return;
		}

		if (this.m.RosterSeed != 0)
		{
			this.Math.seedRandom(this.m.RosterSeed);
		}

		this.m.RosterSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastRosterUpdate = this.Time.getVirtualTimeF();
		local roster = this.World.getRoster(this.getID());
		local allbros = roster.getAll();
		local current = [];
		for( local i = 0; i < allbros.len(); i = ++i )
		{
			if (allbros[i].isStabled())
			{
				continue
			}
			else
			{
				current.push(allbros[i]);
			}
		}

		local iterations = this.Math.max(1, daysPassed / 2);
		local activeLocations = 0;

		foreach( loc in this.m.AttachedLocations )
		{
			if (loc.isActive())
			{
				activeLocations = ++activeLocations;
				activeLocations = activeLocations;
			}
		}

		local minRosterSizes = [
			0,
			3,
			6,
			9
		];
		local rosterMin = minRosterSizes[this.m.Size] + (this.isSouthern() ? 2 : 0);
		local rosterMax = minRosterSizes[this.m.Size] + activeLocations + (this.isSouthern() ? 1 : 0);

		if (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() < 50)
		{
			rosterMin = rosterMin * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
			rosterMax = rosterMax * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
		}

		rosterMin = rosterMin * this.m.Modifiers.RecruitsMult;
		rosterMax = rosterMax * this.m.Modifiers.RecruitsMult;
		rosterMin = rosterMin + this.World.Assets.m.RosterSizeAdditionalMin;
		rosterMax = rosterMax + this.World.Assets.m.RosterSizeAdditionalMax;

		if (iterations < 7)
		{
			for( local i = 0; i < iterations; i = i )
			{
				for( local maxRecruits = this.Math.rand(this.Math.max(0, rosterMax / 2 - 1), rosterMax - 1); current.len() > maxRecruits;  )
				{
					local n = this.Math.rand(0, current.len() - 1);
					roster.remove(current[n]);
					current.remove(n);
				}

				i = ++i;
			}
		}
		else
		{
			for( local i = 0; i < current.len(); i = i )
			{
				roster.remove(current[i]);
				i = ++i;
			}

			current = [];
		}

		local maxRecruits = this.Math.rand(rosterMin, rosterMax);
		local draftList;
		draftList = this.getDraftList();
		local gender = this.LegendsMod.Configs().LegendGenderEnabled();

		foreach( loc in this.m.AttachedLocations )
		{
			loc.onUpdateDraftList(draftList, gender);
		}

		foreach( b in this.m.Buildings )
		{
			if (b != null)
			{
				b.onUpdateDraftList(draftList, gender);
			}
		}

		foreach( s in this.m.Situations )
		{
			s.onUpdateDraftList(draftList, gender);
		}

		this.World.Assets.getOrigin().onUpdateDraftList(draftList, gender);

		while (maxRecruits > current.len())
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx(draftList);
			current.push(bro);
		}

		this.updateStables(_force);
		this.World.Assets.getOrigin().onUpdateHiringRoster(roster);
	}

	function updateStables( _force = false )
	{
		if (!this.hasBuilding("building.stables"))
		{
			return;
		}

		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastStablesUpdate) / this.World.getTime().SecondsPerDay;

		if (!_force && this.m.LastStablesUpdate != 0 && daysPassed < 2)
		{
			return;
		}

		if (this.m.StablesSeed != 0)
		{
			this.Math.seedRandom(this.m.StablesSeed);
		}

		this.m.StablesSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastStablesUpdate = this.Time.getVirtualTimeF();
		local roster = this.World.getRoster(this.getID());
		local allbros = roster.getAll();
		local current = [];

		for( local i = 0; i < allbros.len(); i = ++i )
		{
			if (!allbros[i].isStabled())
			{
				continue
			}

			current.push(allbros[i]);
		}

		local iterations = this.Math.max(1, daysPassed / 2);
		local activeLocations = 0;

		foreach( loc in this.m.AttachedLocations )
		{
			if (loc.isActive())
			{
				activeLocations = ++activeLocations;
				activeLocations = activeLocations;
			}
		}

		local minRosterSizes = [
			0,
			1,
			3,
			5
		];
		local rosterMin = minRosterSizes[this.m.Size];
		local rosterMax = minRosterSizes[this.m.Size] + activeLocations;

		if (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() < 50)
		{
			rosterMin = rosterMin * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
			rosterMax = rosterMax * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
		}

		rosterMin = rosterMin * this.m.Modifiers.StablesMult;
		rosterMax = rosterMax * this.m.Modifiers.StablesMult;

		if (iterations < 5)
		{
			for( local i = 0; i < iterations; i = i )
			{
				for( local maxRecruits = this.Math.rand(this.Math.max(0, rosterMax / 2 - 1), rosterMax - 1); current.len() > maxRecruits;  )
				{
					local n = this.Math.rand(0, current.len() - 1);
					roster.remove(current[n]);
					current.remove(n);
				}

				i = ++i;
			}
		}
		else
		{
			for( local i = 0; i < current.len(); i = ++i )
			{
				if (current[i].isStabled())
				{
					continue
				}
				current = [];
			}
		}

		local maxRecruits = this.Math.rand(rosterMin, rosterMax);
		local draftList;
		draftList = this.getStablesList();

		foreach( loc in this.m.AttachedLocations )
		{
			loc.onUpdateStablesList(draftList);
		}

		foreach( b in this.m.Buildings )
		{
			if (b != null)
			{
				b.onUpdateStablesList(draftList);
			}
		}

		foreach( s in this.m.Situations )
		{
			s.onUpdateStablesList(draftList);
		}

		this.World.Assets.getOrigin().onUpdateStablesList(draftList);
		draftList = [
			"legend_donkey"
		];

		while (maxRecruits > current.len())
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx(draftList);
			current.push(bro);
		}
	}

	function updateImportedProduce()
	{
		if (this.m.ProduceImported.len() == 0)
		{
			return;
		}

		local marketplace;

		foreach( building in this.m.Buildings )
		{
			if (building != null && building.getID() == "building.marketplace")
			{
				marketplace = building;
				break;
			}
		}

		if (marketplace == null)
		{
			return;
		}

		foreach( p in this.m.ProduceImported )
		{
			local item = this.new("scripts/items/" + p);
			marketplace.getStash().add(item);
		}

		marketplace.getStash().sort();
		this.m.ProduceImported = [];
	}

	function resetShop()
	{
		this.m.LastShopUpdate = -9000.0;
	}

	function updateShop( _force = false )
	{
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastShopUpdate) / this.World.getTime().SecondsPerDay;

		if (!_force && this.m.LastShopUpdate != 0 && daysPassed < 3)
		{
			this.updateImportedProduce();
			return;
		}

		if (this.m.ShopSeed != 0)
		{
			this.Math.seedRandom(this.m.ShopSeed);
		}

		this.m.ShopSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastShopUpdate = this.Time.getVirtualTimeF();

		foreach( building in this.m.Buildings )
		{
			if (building != null)
			{
				building.onUpdateShopList();

				if (building.getStash() != null)
				{
					foreach( s in this.m.Situations )
					{
						s.onUpdateShop(building.getStash());
					}
				}
			}
		}

		this.updateImportedProduce();
	}

	function updateProperties()
	{
		local myTile = this.getTile();
		local mapSize = this.World.getMapSize();
		this.m.ConnectedTo = [];
		this.m.ConnectedToByRoads = [];
		local settlements = this.World.EntityManager.getSettlements();
		local navSettings = this.World.getNavigator().createSettings();

		foreach( s in settlements )
		{
			if (s.getID() == this.getID())
			{
				continue;
			}

			navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
			local path = this.World.getNavigator().findPath(myTile, s.getTile(), navSettings, 0);

			if (!path.isEmpty())
			{
				this.m.ConnectedTo.push(s.getID());
			}
		}

		if (!this.isIsolated())
		{
			foreach( s in settlements )
			{
				if (s.getID() == this.getID())
				{
					continue;
				}

				navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost;
				navSettings.RoadOnly = true;
				local path = this.World.getNavigator().findPath(myTile, s.getTile(), navSettings, 0);

				if (!path.isEmpty())
				{
					this.m.ConnectedToByRoads.push(s.getID());
				}
			}
		}

		this.m.IsCoastal = false;

		for( local i = 0; i < 6; i = ++i )
		{
			if (!myTile.hasNextTile(i))
			{
			}
			else if (myTile.getNextTile(i).Type == this.Const.World.TerrainType.Ocean || myTile.getNextTile(i).Type == this.Const.World.TerrainType.Shore)
			{
				this.m.IsCoastal = true;
				break;
			}
		}

		if (this.m.IsCoastal)
		{
			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, mapSize.X, 0, 1);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, 1, 0, mapSize.Y);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(mapSize.X - 1, mapSize.X, 0, mapSize.Y);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.DeepOceanTile = this.findAccessibleOceanEdge(0, mapSize.X, mapSize.Y - 1, mapSize.Y);
			}

			if (this.m.DeepOceanTile == null)
			{
				this.m.IsCoastal = false;
			}
		}
	}

	function isIsolatedFromLocation( _location )
	{
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;
		local path = this.World.getNavigator().findPath(this.getTile(), _location.getTile(), navSettings, 0);
		return path.isEmpty();
	}

	function findAccessibleOceanEdge( _minX, _maxX, _minY, _maxY )
	{
		local myTile = this.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Ship;
		local tiles = [];

		for( local x = _minX; x < _maxX; x = x )
		{
			for( local y = _minY; y < _maxY; y = y )
			{
				if (!this.World.isValidTileSquare(x, y))
				{
				}
				else
				{
					local tile = this.World.getTileSquare(x, y);

					if (tile.Type != this.Const.World.TerrainType.Ocean || tile.IsOccupied)
					{
					}
					else
					{
						local isDeepSea = true;

						for( local i = 0; i != 6; i = ++i )
						{
							if (tile.hasNextTile(i) && tile.getNextTile(i).Type != this.Const.World.TerrainType.Ocean)
							{
								isDeepSea = false;
								break;
							}
						}

						if (!isDeepSea)
						{
						}
						else
						{
							tiles.push(tile);
						}
					}
				}

				y = ++y;
			}

			x = ++x;
		}

		while (tiles.len() != 0)
		{
			local idx = this.Math.rand(0, tiles.len() - 1);
			local tile = tiles[idx];
			tiles.remove(idx);
			local path = this.World.getNavigator().findPath(myTile, tile, navSettings, 0);

			if (!path.isEmpty())
			{
				return tile;
			}
		}

		return null;
	}

	function getActiveAttachedLocations()
	{
		local ret = [];

		foreach( a in this.m.AttachedLocations )
		{
			if (a.isActive() && a.isUsable())
			{
				ret.push(a);
			}
		}

		return ret;
	}

	function updateSprites( _burn = true )
	{
		if (this.m.IsActive)
		{
			this.getSprite("location_banner").Visible = true;
			this.getLabel("name").Visible = true;
			this.getSprite("body").setBrush(this.getSpriteName());

			foreach( h in this.m.HousesTiles )
			{
				continue;
				local tile = this.World.getTileSquare(h.X, h.Y);
				tile.clear(this.Const.World.DetailType.Houses);
				local d = tile.spawnDetail("world_houses_0" + this.getHousesType() + "_0" + h.V, this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);

				if (d == null)
				{
					continue;
				}

				d.Scale = 0.85;
			}
		}
		else
		{
			this.World.getRoster(this.getID()).clear();
			this.getSprite("location_banner").Visible = false;
			this.getLabel("name").Visible = false;
			this.getSprite("body").setBrush(this.getSpriteName() + "_ruins");
			this.getSprite("lighting").Alpha = 0;

			if (_burn)
			{
				this.spawnFireAndSmoke();
			}

			foreach( h in this.m.HousesTiles )
			{
				continue;
				local tile = this.World.getTileSquare(h.X, h.Y);
				tile.clear(this.Const.World.DetailType.Houses | this.Const.World.DetailType.Lighting);
				local d = tile.spawnDetail("world_houses_0" + this.getHousesType() + "_0" + h.V + "_ruins", this.Const.World.ZLevel.Object - 3, this.Const.World.DetailType.Houses);
				d.Scale = 0.85;
				this.spawnFireAndSmoke(tile.Pos);
			}

			foreach( loc in this.m.AttachedLocations )
			{
				if (loc.isActive())
				{
					loc.setActive(false);
				}

				loc.setSettlement(null);
			}
		}
	}

	function setActive( _a, _burn = true )
	{
		if (_a == this.m.IsActive)
		{
			return;
		}

		this.m.IsActive = _a;
		this.updateSprites(_burn);
	}

	function destroy()
	{
		this.setActive(false);
		this.getTile().spawnDetail(this.getSpriteName() + "_ruins", this.Const.World.ZLevel.Object - 3, 0);
		this.die();
	}

	function onUpdate()
	{
		local lighting = this.getSprite("lighting");

		if (!this.m.IsActive)
		{
			lighting.Alpha = 0;
			return;
		}

		if (lighting.IsFadingDone)
		{
			if (lighting.Alpha == 0 && this.World.getTime().TimeOfDay >= 4 && this.World.getTime().TimeOfDay <= 7)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeIn(5000);
				}
				else
				{
					lighting.Alpha = 255;
				}

				foreach( h in this.m.HousesTiles )
				{
					local tile = this.World.getTileSquare(h.X, h.Y);
					local d = tile.spawnDetail("world_houses_0" + this.getHousesType() + "_0" + h.V + "_light", this.Const.World.ZLevel.Object - 4, this.Const.World.DetailType.Lighting, false, insideScreen);
					d.IgnoreAmbientColor = true;
					d.Scale = 0.85;
				}
			}
			else if (lighting.Alpha != 0 && this.World.getTime().TimeOfDay >= 0 && this.World.getTime().TimeOfDay <= 3)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeOut(4000);
				}
				else
				{
					lighting.Alpha = 0;
				}

				foreach( h in this.m.HousesTiles )
				{
					local tile = this.World.getTileSquare(h.X, h.Y);

					if (insideScreen)
					{
						tile.clearAndFade(this.Const.World.DetailType.Lighting);
					}
					else
					{
						tile.clear(this.Const.World.DetailType.Lighting);
					}
				}
			}
		}
	}

	function onUpdateShopList( _id, _list )
	{
		foreach( loc in this.m.AttachedLocations )
		{
			if (loc.isActive())
			{
				if (this.LegendsMod.Configs().LegendArmorsEnabled())
				{
					loc.onUpdateShopList(_id, _list);
				}
				else
				{
					loc.onUpdateShopList(_id, _list);
				}
			}
		}
	}

	function onBuild( _settings = null )
	{
	}

	function onSlotClicked( _i, _townScreen )
	{
		if (this.m.Buildings[_i] != null)
		{
			this.m.CurrentBuilding = this.m.Buildings[_i];
			this.m.Buildings[_i].onClicked(_townScreen);
		}
	}

	function onThink()
	{
		this.location.onThink();
	}

	function onEnter()
	{
		this.location.onEnter();

		this.m.CurrentBuilding = null;
		this.updateSituations();
		this.updateRoster();
		this.updateShop();
		this.Math.seedRandom(this.Time.getRealTime());
		return true;
	}

	function onCombatLost()
	{
	}

	function onRaided()
	{
		if (this.m.LastSmokeSpawned + 90.0 < this.Time.getVirtualTimeF())
		{
			this.m.LastSmokeSpawned = this.Time.getVirtualTimeF();

			if (this.Const.World.SmokeParticles.len() != 0)
			{
				local smoke = this.Const.World.SmokeParticles;

				for( local i = 0; i < smoke.len(); i = i )
				{
					this.World.spawnParticleEffect(smoke[i].Brushes, smoke[i].Delay, smoke[i].Quantity, smoke[i].LifeTime, smoke[i].SpawnRate, smoke[i].Stages, this.createVec(this.getPos().X, this.getPos().Y - 30), this.Const.World.ZLevel.Particles);
					i = ++i;
				}

				local fire = this.Const.World.FireParticles;

				for( local i = 0; i < fire.len(); i = i )
				{
					this.World.spawnParticleEffect(fire[i].Brushes, fire[i].Delay, fire[i].Quantity, fire[i].LifeTime, fire[i].SpawnRate, fire[i].Stages, this.createVec(this.getPos().X, this.getPos().Y - 30), this.Const.World.ZLevel.Particles - 3);
					i = ++i;
				}
			}

			this.m.LastShopUpdateDay = -900;
		}
	}

	function onAttachedLocationsChanged()
	{
		local civilian = this.getFactionOfType(this.Const.FactionType.Settlement);

		if (civilian != null)
		{
			local units = 1;

			foreach( a in this.m.AttachedLocations )
			{
				if (a.isActive() && a.isMilitary())
				{
					units = ++units;
					units = units;
				}
			}

			civilian.setMaxUnits(units);
		}
	}

	function onInit()
	{
		this.location.onInit();
		this.World.EntityManager.addSettlement(this);
		local tile = this.getTile();
		local terrain = [];
		terrain.resize(this.Const.World.TerrainType.COUNT, 0);

		for( local i = 0; i < 6; i = i )
		{
			if (!tile.hasNextTile(i))
			{
			}
			else
			{
				++terrain[tile.getNextTile(i).Type];
			}

			i = ++i;
		}

		terrain[this.Const.World.TerrainType.Plains] = this.Math.max(0, terrain[this.Const.World.TerrainType.Plains] - 1);

		if (terrain[this.Const.World.TerrainType.Steppe] != 0 && this.Math.abs(terrain[this.Const.World.TerrainType.Steppe] - terrain[this.Const.World.TerrainType.Hills]) <= 2)
		{
			terrain[this.Const.World.TerrainType.Steppe] += 2;
		}

		if (terrain[this.Const.World.TerrainType.Snow] != 0 && this.Math.abs(terrain[this.Const.World.TerrainType.Snow] - terrain[this.Const.World.TerrainType.Hills]) <= 2)
		{
			terrain[this.Const.World.TerrainType.Snow] += 2;
		}

		local highest = 0;

		for( local i = 0; i < this.Const.World.TerrainType.COUNT; i = i )
		{
			if (i == this.Const.World.TerrainType.Ocean || i == this.Const.World.TerrainType.Shore)
			{
			}
			else if (terrain[i] >= terrain[highest])
			{
				highest = i;
			}

			i = ++i;
		}

		this.m.UIBackground = this.Const.World.TerrainSettlementImages[highest].Background;
		this.m.UIRamp = this.Const.World.TerrainSettlementImages[highest].Ramp;
		this.m.UIForeground = this.getHousesMax() < 5 || this.isSouthern() ? this.Const.World.TerrainSettlementImages[highest].Foreground : "ui/settlements/foreground_04";
		this.m.UIMood = this.Const.World.TerrainSettlementImages[highest].Mood;
		this.World.createRoster(this.getID());
		this.registerThinker();
		local body = this.addSprite("body");
		body.setBrush(this.getSpriteName());
		local light = this.addSprite("lighting");
		this.setSpriteColorization("lighting", false);

		if (this.getLighting() != "")
		{
			light.setBrush(this.getLighting());
		}

		light.IgnoreAmbientColor = true;
		light.Alpha = 0;
	}

	function onLeave()
	{
		if (this.LegendsMod.Configs().LegendCampUnlockEnabled())
		{
			return;
		}

		local eventID = "";

		if (!this.World.Flags.get("HasLegendCampTraining") && this.hasBuilding("building.training_hall"))
		{
			eventID = "event.legend_camp_unlock_training";
		}
		else if (!this.World.Flags.get("HasLegendCampBarber") && this.hasBuilding("building.barber"))
		{
			eventID = "event.legend_camp_unlock_barber";
		}
		else if (!this.World.Flags.get("HasLegendCampCrafting") && (this.hasBuilding("building.taxidermist") || this.hasBuilding("building.taxidermist_oriental")))
		{
			eventID = "event.legend_camp_unlock_crafting";
		}
		else if (!this.World.Flags.get("HasLegendCampFletching") && (this.hasAttachedLocation("attached_location.fletchers_hut") || this.hasBuilding("building.weaponsmith") || this.hasBuilding("building.weaponsmith_oriental")))
		{
			eventID = "event.legend_camp_unlock_fletching";
		}
		else if (!this.World.Flags.get("HasLegendCampGathering") && (this.hasAttachedLocation("attached_location.gatherers_hut") || this.hasAttachedLocation("attached_location.herbalists_grove") || this.hasAttachedLocation("attached_location.plantation")))
		{
			eventID = "event.legend_camp_unlock_gather";
		}
		else if (!this.World.Flags.get("HasLegendCampHunting") && (this.hasAttachedLocation("attached_location.trapper") || this.hasAttachedLocation("attached_location.hunters_cabin")))
		{
			eventID = "event.legend_camp_unlock_hunt";
		}
		else if (!this.World.Flags.get("HasLegendCampScraping") && (this.hasAttachedLocation("attached_location.workshop") || this.hasBuilding("building.armorsmith") || this.hasBuilding("building.armorsmith_oriental")))
		{
			eventID = "event.legend_camp_unlock_scrap";
		}
		else if (!this.World.Flags.get("HasLegendCampPainter") && (this.hasAttachedLocation("attached_location.workshop") || this.hasBuilding("building.armorsmith") || this.hasBuilding("building.armorsmith_oriental"))) //PaintingTent
		{
			eventID = "event.legend_camp_unlock_painter";
		}
		else if (!this.World.Flags.get("HasLegendCampScouting") && (this.hasAttachedLocation("attached_location.wooden_watchtower") || this.hasAttachedLocation("attached_location.stone_watchtower") || this.hasAttachedLocation("attached_location.fortified_outpost")))
		{
			eventID = "event.legend_camp_unlock_scouting";
		}

		if (eventID == "")
		{
			return;
		}

		this.World.Camp.fireEvent(eventID, this.getName());
	}

	function onFinish()
	{
		this.location.onFinish();
		this.World.deleteRoster(this.getID());
		this.World.EntityManager.removeSettlement(this);

		foreach( f in this.m.Factions )
		{
			this.World.FactionManager.getFaction(f).removeSettlement(this);
		}

		this.unregisterThinker();
	}

	function isBuilding()
	{
		foreach( s in this.getSituations() )
		{
			switch(s.getID())
			{
			case "situation.rebuilding_effort":
			case "situation.legend_degrading_effort":
			case "situation.legend_upgrading_effort":
			case "situation.legend_upgrading_locations_effort":
				return true;
			}
		}

		return false;
	}

	function getBaseResourceLevel()
	{
		local minResources = 50;

		if (this.isMilitary())
		{
			minResources = minResources + 50;
		}

		if (this.isKindOf(this, "city_state"))
		{
			minResources = minResources + 100;
		}

		switch(this.m.Size)
		{
		case 1:
			minResources = minResources + 100;
			break;

		case 2:
			minResources = minResources + 150;
			break;

		case 3:
			minResources = minResources + 200;
			break;
		}

		return minResources;
	}

	function canUpgrade()
	{
		if (this.m.Size >= 3)
		{
			return false;
		}

		if (this.isUpgrading())
		{
			return false;
		}

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
			{
				return false;
			}
		}

		if (this.getResources() < this.getBaseResourceLevel())
		{
			return false;
		}

		return true;
	}

	function canBuildLocation()
	{
		if (this.isUpgrading())
		{
			return false;
		}

		if (this.m.AttachedLocations.len() >= this.getAttachedLocationsMax())
		{
			return false;
		}

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
			{
				return false;
			}
		}

		if (this.getResources() < this.getBaseResourceLevel())
		{
			return false;
		}

		return true;
	}

	function canUpgradeLocations()
	{
		if (this.isUpgrading())
		{
			return false;
		}

		if (this.m.AttachedLocations.len() < this.getAttachedLocationsMax())
		{
			return false;
		}

		foreach( a in this.getAttachedLocations() )
		{
			if (a.isBuilding())
			{
				return false;
			}
		}

		if (this.getResources() < this.getBaseResourceLevel())
		{
			return false;
		}

		return true;
	}

	function numShips()
	{
		local f = this.World.FactionManager.getFaction(this.m.Factions[0]);

		if (f == null)
		{
			return 0;
		}

		local num = 0;

		foreach( u in f.getUnits() )
		{
			if (u.m.Name != "Ship")
			{
				continue;
			}

			num++;
		}

		return num;
	}

	function getNewResources()
	{
		local resources = 0;

		foreach( loc in this.getAttachedLocations() )
		{
			resources = resources + loc.getNewResources();
		}

		resources = resources + this.m.HousesTiles.len();
		return resources;
	}

	function addNewResources()
	{
		if (!this.m.IsActive)
		{
			return;
		}

		this.setResources(this.getResources() + this.getNewResources());
	}

	function onSerialize( _out )
	{
		this.location.onSerialize(_out);
		_out.writeU8(this.m.Size);
		_out.writeBool(this.m.IsUpgrading);
		_out.writeBool(this.m.IsActive);
		_out.writeBool(this.m.IsCoastal);
		_out.writeF32(this.m.LastPreload);
		_out.writeF32(this.m.LastShopUpdate);
		_out.writeF32(this.m.LastRosterUpdate);
		_out.writeF32(this.m.LastStablesUpdate);
		_out.writeI32(this.m.ShopSeed);
		_out.writeI32(this.m.RosterSeed);
		_out.writeI32(this.m.StablesSeed);

		if (this.m.DeepOceanTile != null)
		{
			_out.writeI16(this.m.DeepOceanTile.Coords.X);
			_out.writeI16(this.m.DeepOceanTile.Coords.Y);
		}
		else
		{
			_out.writeI16(-1);
			_out.writeI16(-1);
		}

		_out.writeU8(this.m.Buildings.len());

		foreach( building in this.m.Buildings )
		{
			if (building == null)
			{
				_out.writeU32(0);
			}
			else
			{
				_out.writeI32(building.ClassNameHash);
				building.onSerialize(_out);
			}
		}

		_out.writeU8(this.m.Situations.len());

		foreach( s in this.m.Situations )
		{
			_out.writeI32(s.ClassNameHash);
			s.onSerialize(_out);
		}

		_out.writeU8(this.m.ProduceImported.len());

		foreach( p in this.m.ProduceImported )
		{
			_out.writeString(p);
		}

		_out.writeU8(this.m.ConnectedTo.len());

		foreach( id in this.m.ConnectedTo )
		{
			_out.writeU32(id);
		}

		_out.writeU8(this.m.ConnectedToByRoads.len());

		foreach( id in this.m.ConnectedToByRoads )
		{
			_out.writeU32(id);
		}

		_out.writeU8(this.m.HousesTiles.len());

		for( local i = 0; i != this.m.HousesTiles.len(); i = i )
		{
			_out.writeI16(this.m.HousesTiles[i].X);
			_out.writeI16(this.m.HousesTiles[i].Y);
			_out.writeU8(this.m.HousesTiles[i].V);
			i = ++i;
		}
	}

	function onDeserialize( _in )
	{
		this.location.onDeserialize(_in);
		this.m.Size = _in.readU8();
		this.m.IsUpgrading = _in.readBool();
		this.m.IsActive = _in.readBool();
		this.m.IsCoastal = _in.readBool();

		if (_in.getMetaData().getVersion() >= 52)
		{
			this.m.LastPreload = _in.readF32();
		}

		this.m.LastShopUpdate = _in.readF32();
		this.m.LastRosterUpdate = _in.readF32();

		if (_in.getMetaData().getVersion() >= 58)
		{
			this.m.LastStablesUpdate = _in.readF32();
		}

		this.m.ShopSeed = _in.readI32();
		this.m.RosterSeed = _in.readI32();

		if (_in.getMetaData().getVersion() >= 58)
		{
			this.m.StablesSeed = _in.readI32();
		}

		local x = _in.readI16();
		local y = _in.readI16();

		if (!(x == -1 && y == -1))
		{
			this.m.DeepOceanTile = this.World.getTile(x, y);
		}

		this.m.Buildings = [];
		this.m.Buildings.resize(9, null);
		local numBuildings = _in.readU8();

		for( local i = 0; i < numBuildings; i = i )
		{
			local id = _in.readU32();

			if (id != 0)
			{
				this.m.Buildings[i] = this.new(this.IO.scriptFilenameByHash(id));
				this.m.Buildings[i].setSettlement(this);
				this.m.Buildings[i].onDeserialize(_in);
			}

			i = ++i;
		}

		if (this.m.IsCoastal && this.m.Buildings[3] != null && this.m.Buildings[3].getID() == "building.port")
		{
			this.m.UIBackgroundLeft = "ui/settlements/water_01";
		}

		local numSituations = _in.readU8();
		this.m.Situations.resize(numSituations);

		for( local i = 0; i < numSituations; i = i )
		{
			this.m.Situations[i] = this.new(this.IO.scriptFilenameByHash(_in.readU32()));
			this.m.Situations[i].onDeserialize(_in);
			i = ++i;
		}

		this.m.Modifiers.reset();

		foreach( s in this.m.Situations )
		{
			s.onUpdate(this.m.Modifiers);
		}

		local numProduce = _in.readU8();

		for( local i = 0; i != numProduce; i = i )
		{
			this.m.ProduceImported.push(_in.readString());
			i = ++i;
		}

		local numConnectedTo = _in.readU8();

		for( local i = 0; i != numConnectedTo; i = i )
		{
			this.m.ConnectedTo.push(_in.readU32());
			i = ++i;
		}

		local numConnectedToByRoads = _in.readU8();

		for( local i = 0; i != numConnectedToByRoads; i = i )
		{
			this.m.ConnectedToByRoads.push(_in.readU32());
			i = ++i;
		}

		local numHouses = _in.readU8();

		for( local i = 0; i != numHouses; i = i )
		{
			local x = _in.readI16();
			local y = _in.readI16();
			local v = _in.readU8();
			this.m.HousesTiles.push({
				X = x,
				Y = y,
				V = v
			});
			i = ++i;
		}

		this.updateSprites();
	}

});

