this.healer_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {
		MedsUsed = 0,
		InjuriesTreated = 0,
        Rate = 0,
        PointsNeeded = 0,
		Queue = null,
		InjuriesHealed = [],
		InjurySounds = []
	},
    function create()
    {
        this.camp_building.create();
        this.m.ID = this.Const.World.CampBuildings.Healer;
		this.m.BaseCraft = 1.0;
        this.m.ModName = "Healing";   
		this.m.Escorting = true;
        this.m.Slot = "heal";
        this.m.Name = "Healing";
        this.m.Description = "Place brothers in reserves in order to heal from wounds.";
		this.m.BannerImage = "ui/buttons/banner_heal.png"
		this.m.Sounds = [
			{
				File = "ambience/camp/healer_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/healer_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/healer_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/camp/healer_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/healer_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/camp/healer_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.InjurySounds = [
			{
				File = "sounds/ambience/camp/camp_healer_treatment_bandage_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "sounds/ambience/camp/camp_healer_treatment_bandage_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
		]
    }

	function getRate()
	{
		local heal = 1.00;
		if (this.getUpgraded())
		{
			heal = 2.0;
		}
		local points =  this.Const.World.Assets.HitpointsPerHour * heal;
		return points + points * this.m.Rate;
	}

	function getTitle()
	{
		if (this.getUpgraded())
		{
			return this.m.Name + " *Upgraded*"
		} 
		return this.m.Name +  " *Not Upgraded*"
	}

	function getDescription()
	{
		local desc = "";
		desc += "Injuries are a prerequisite for any self respecting battle brother. The quicker temporary injuries are patched up, the quicker a battle brother can get some more! "
		desc += "Assigning brothers to this tent allows them to treat any wounds in the company roster and also help restore healthpoints of any injured brother. "
		desc += "Treating an injury requires a cost of medicine and time (vs coin in a temple). The more people assigned to the tent, the quicker injuries will be treated and healthpoints restored. "
		desc += "\n\n"
		desc += "The healing tent can be upgraded by purchasing a crafting cart from a settlement merchant. An upgraded tent has a 33% increase in treatment speed and a 25% decrease in medicine cost for each injury."
		return desc;
	}

	function getModifierToolip()
    {
		this.init();
		local mod = this.getModifiers();
		local ret = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "There are [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Queue.len() + "[/color] injuries queued to be treated."
			},
			{
				id = 4,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.getRequiredTime() + "[/color] hours to treat all queued injuries."
			},
			{
				id = 5,
				type = "text",
				icon = "ui/buttons/icon_time.png",
				text = "It will take [color=" + this.Const.UI.Color.PositiveValue + "]" + this.Math.ceil(this.m.PointsNeeded / this.getRate()) + "[/color] hours to heal all healthpoints."
			},					
			{
				id = 6,
				type = "text",
				icon = "ui/buttons/asset_medicine_up.png",
				text = "Total healing modifier is [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Rate * 100.0 + "%[/color]."
			}
		];
		local id = 7;
		foreach (bro in mod.Modifiers)
		{
			ret.push({
				id = id,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + bro[0] * 100.0 + "%[/color] " + bro[1] + " (" + bro[2] + ")"
			})
			++id;
		}
		return ret;
	}

	function isHidden()
	{
		return false;
	}	

	function getUpgraded()
	{
        return this.Stash.hasItem("tent.healer_tent");
	}

	function getLevel()
	{
		local pro = "dude";
		if (this.getUpgraded())
		{
			pro = "tent";
		}

		local sub = "empty";
		
		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function getCost(_injury)
	{
		local cost = _injury.getCost();
		if (this.getUpgraded()) 
        {  
            cost = this.Math.floor(cost * 0.75);
        }
		return cost;
	}

    function init()
    {
        this.m.MedsUsed = 0;
		this.m.InjuriesTreated = 0;
		this.m.InjuriesHealed = [];
        local roster = this.World.getPlayerRoster().getAll();
        this.m.PointsNeeded = 0
        foreach( bro in roster )
        {
            bro.setCampHealing(0);
            this.m.PointsNeeded = this.Math.max(this.m.PointsNeeded, (bro.getHitpointsMax() - bro.getHitpoints()));
        }
        local mod = this.getModifiers();
        this.m.Rate = mod.Craft;
		this.onInit();
    }

    function onInit()
    {
		local q = [];
		if (this.m.Queue == null)
		{
			local brothers = this.World.getPlayerRoster().getAll();
			foreach( b in brothers )
			{
				local allInjuries = b.getSkills().query(this.Const.SkillType.TemporaryInjury);
				foreach (i in allInjuries)
				{
					if (i.getQueue() == 0)
					{
						continue
					}
					q.push(i);
				}
			}
			q.sort(this.onSortQueue);
		}
		else
		{
			for (local i = 0; i < this.m.Queue.len(); i = ++i)
			{
				if (this.m.Queue[i] == null)
				{
					continue
				}

				if (this.m.Queue[i].getQueue() == 0)
				{
					continue
				}

				q.push(this.m.Queue[i])
			}
		}
		
		this.m.Queue = q
    }

	function onSortQueue( _a, _b )
	{
		if (_a.getQueue() < _b.getQueue())
		{
			return -1;
		}
		else if (_a.getQueue() > _b.getQueue())
		{
			return 1;
		}

		return 0;
	}

    function getResults()
    {
		local id = 30;
		local res = [];
		if (this.m.MedsUsed > 0)
		{
			res.push({
				id = id,
				icon = "ui/buttons/asset_medicine_down.png",
				text = "You used [color=" + this.Const.UI.Color.NegativeEventValue + "]" + this.Math.floor(this.m.MedsUsed) + "[/color] units of medicine and treated [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.m.InjuriesTreated + "[/color] injuries."
			});
		}

		foreach (b in this.m.InjuriesHealed)
		{
			if (b.getIcon() != null && b.getName() != null)
			{
				res.push({
		 			id = id,
		 			icon = "" + b.getIcon(),
		 			text = b.getName()
				})
			}
			++id;
		}
        
		local roster = this.World.getPlayerRoster().getAll();
        foreach( b in roster )
        {
            if (b.getCampHealing() > 0)
            {
                res.push({
                    id = id,
                    icon = "ui/icons/health.png",
                    text = b.getName() + " healed [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Math.floor(b.getCampHealing()) + "[/color] points."
                })
				++id
            }
        }		
		return res;
    }

    function getModifiers()
    {
        local ret = this.camp_building.getModifiers();
        if (ret.Assigned == 0)
        {
            ret.Craft = this.m.BaseCraft *  this.Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()];
        }
        return ret;
    }


	function getUpdateText()
	{
		if (this.getRequiredTime() <= 0 && this.m.InjuriesTreated > 0)
		{
			return "Injuries Treated ... 100%";
		}

		if (this.getRequiredTime() <= 0)
		{
			return "";
		}

		if (this.World.Assets.getMedicine() <= 0)
		{
			return "No injuries being treated (Out of medicine!)"
		}

		if (this.m.Camp.getElapsedHours() > this.getRequiredTime())
		{
			return "Injuries Treated ... 100%";
		}

		local percent = (this.m.Camp.getElapsedHours() / this.getRequiredTime()) * 100.0;
		if (percent >= 100)
		{
			return "Injuries Treated ... 100%";
		}
		
		local text =  "Injuries Treated ... " + percent + "%";

		return text;
	}

	function getHealUpdateText()
	{
		local totalTime = this.Math.ceil(this.m.PointsNeeded / this.getRate())
		local percent = (this.m.Camp.getElapsedHours() / totalTime) * 100.0;
		if (percent >= 100)
		{
			return "Health points ... 100%";
		}
		
		return "Health points ... " + percent + "%";
	}

    function update ()
    {
        local modifiers = this.getModifiers();
		if (this.m.Queue == null)
		{
			this.init();
		}
        foreach (i, r in this.m.Queue)
        {
            if (r == null)
            {
                continue;
            }

			if (r.isTreated())
			{
				continue;
			}

			if (!r.isTreatable())
			{
				continue;
			}

			if (r.getQueue() == 0)
			{
				continue;
			}

			if (this.World.Assets.getMedicine() <= 0 )
			{
				continue
			}

            local needed = this.getCost(r) - r.getPoints();

            if (modifiers.Craft < needed)
            {
                needed = modifiers.Craft;
            }
			r.setPoints(r.getPoints() + needed);
            modifiers.Craft -= needed;

			this.World.Assets.addMedicine(-needed)

			if (r.getPoints() >= this.getCost(r))
			{
				r.setTreated(true);
				r.setQueue(0);
				local cont = r.getContainer();
				if (cont != null) //was gettng rare error that said index getActor DNE, should fix that assuming it's a null container somehow(?) 
				{
					if (r.getContainer().getActor() != null)
					{
						r.getContainer().getActor().updateInjuryVisuals();
					}
					this.m.InjuriesHealed.push(r);
					this.m.Queue[i] = null;
				}
				else
				{
					this.logWarning("Healer building container was null");
					//can use this if we want to forceit and see if that was the problem(?)
					//local forceActorBugInLog = cont.getAtor();
				}
				
			}

            if (modifiers.Craft <= 0) 
            {
                break
            }
        }
		local text = this.getUpdateText()
		if (text != "")
		{
			text += "</br>"
		}

        local roster = this.World.getPlayerRoster().getAll();
        foreach( bro in roster )
        {
            local d = bro.getHitpointsMax() - bro.getHitpoints();
            if (d <= 0)
            {
                continue;
            }
            bro.setCampHealing(bro.getCampHealing() + this.getRate());
            bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.getRate()));
        }

		return text + this.getHealUpdateText();
    }

	function getQueue()
	{
		local ret = [];
		foreach( b in this.m.Queue )
		{
			if (b == null)
			{
				continue
			}
			
			local r = {
				ID = b.getID(),
				Name = b.getName(),
				Description = b.getDescription(),
				ImagePath = b.getIcon(),
				Percentage = b.getTreatedPercentage() * 100
			};			
			ret.push(r);
		}
		return ret;
	}

	function getRoster()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			local injuries = [];
			local allInjuries = b.getSkills().query(this.Const.SkillType.TemporaryInjury);

			for( local i = 0; i != allInjuries.len(); i = ++i )
			{
				local inj = allInjuries[i];
				if (!inj.isTreated())
				{
					injuries.push({
						id = inj.getID(),
						icon = inj.getIconColored(),
						name = inj.getNameOnly(),
						price = this.getCost(inj),
						treatable = inj.isTreatable() && inj.getQueue() == 0,
						points = inj.getPoints()
					});
				}
			}

			if (injuries.len() == 0)
			{
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Injuries = injuries
			};
			roster.push(e);
		}
		return roster;
	}

    function getRequiredMeds()
    {
        local points = 0;
        foreach (i, r in this.m.Queue)
        {
            if (r == null)
            {
                continue;
            }
            
            points += this.getCost(r);
        }
		return points;
    }

    function getRequiredTime()
    {
        local points = 0;
		if (this.m.Queue == null)
        {
            return 0;
        }
				
        foreach (r in this.m.Queue)
        {
            if (r == null)
            {
                continue;
            }
            
            points += this.getCost(r);
        }
        local modifiers = this.getModifiers();
		if (modifiers.Craft <= 0)
		{
			return 0
		}
        return this.Math.ceil(points / modifiers.Craft);
    }

    function getAssignedBros()
    {
        local mod = this.getModifiers();
        return mod.Assigned;
    }


	function getResourceImage()
	{
		return "ui/buttons/icon_time.png";
	}

	function getResourceCount()
	{
		return this.getRequiredTime();
	}

	function onAdd( _entityID, _injuryID  )
	{
		local entity = this.Tactical.getEntityByID(_entityID);
		local injury = entity.getSkills().getSkillByID(_injuryID);
		this.m.Queue.push(injury)
		injury.setQueue(this.m.Queue.len());
		local sound = this.m.InjurySounds[this.Math.rand(0, this.m.InjurySounds.len() - 1)];
		this.Sound.play(sound.File, sound.Volume)
	}

	function onRemove( _idx )
	{
		local q = [];
		for (local i = 0; i < this.m.Queue.len(); i = ++i)
		{
			if (i == _idx)
			{
				this.m.Queue[_idx].setQueue(0);
				continue
			}
			q.push(this.m.Queue[i])
		}
		this.m.Queue = q
	}

	function onSwap( _source, _target)
	{
		local item = this.m.Queue[_source];
		item.setQueue(_target + 1);
		this.m.Queue[_target].setQueue(_source + 1);
		this.m.Queue[_source] = this.m.Queue[_target];
		this.m.Queue[_target] = item;
		local sound = this.m.InjurySounds[this.Math.rand(0, this.m.InjurySounds.len() - 1)];
		this.Sound.play(sound.File, sound.Volume)
	}

	function onBroLeave( _bro )
	{
		local allInjuries = _bro.getSkills().query(this.Const.SkillType.TemporaryInjury);
		foreach (i in allInjuries)
		{
			i.setQueue(0);
		}
	}

	function onClicked( _campScreen )
	{
        _campScreen.showHealerDialog();
        this.camp_building.onClicked(_campScreen);
	}
        
	function onSerialize( _out )
	{
		this.camp_building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.camp_building.onDeserialize(_in);
	}


});