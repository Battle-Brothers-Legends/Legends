this.player_horserider_test <- this.inherit("scripts/entity/tactical/player", {
    m = {
        Rider = null,
        Horse = null,
        RiderSkills = [], //actual actives not IDs
        HorseSkills = [],
        PlayerBodyArmor = null,
        PlayerStartHelmetDurability = 0,
        PlayerStartBodyDurability = 0,
    },

    function setRider( _a )
	{
		this.m.Rider = this.WeakTableRef((typeof _a == "instance") ? _a.get() : _a);
	}

	function getRider()
	{
		return this.m.Rider
	}

	function setHorse( _a )
	{
		this.m.PlaceInFormation = _a.getPlaceInFormation();
		this.m.Horse = this.WeakTableRef((typeof _a == "instance") ? _a.get() : _a);
	}

	function getHorse()
	{
		return this.m.Horse;
	}

    function setScenarioValues()
    {
        local rSkills = this.getRider().getSkills();
        local hSkills = this.getHorse().getSkills();

        foreach(rS in rSkills)
        {
            this.m.RiderSkills.push(rs)
        }
        foreach(hS in hSkills)
        {
            local hadHorseSkill = false;
            foreach(rS in this.m.RiderSkills)
            {
                if (rS.getID() == hs.getID() && !hS.isStacking()) //not adding the same skill twice
                {
                    hadHorseSkill = true;
                }
            }
            if (!hadHorseSkill)
            {
                this.m.HorseSkills.push(hS);
            }
        }

        local skills = clone this.m.RiderSkills;
        skills.extend(this.m.HorseSkills);

        foreach(s in skills) //we stole everything from horse and rider so 
        {
            s.setContainer(this.getSkills()) //set our container and push the skill, they probably don't need to be re-added
            this.getSkills().m.Skills.push(s)
        }

        this.getFlags().add("IsHorseRider");
        if (!this.getRider().getCurrentProperties().IsContentWithBeingInReserve)
        {
			this.getRider().getFlags().add("TemporaryRider");
        }

        local b = this.m.BaseProperties;
		b.ActionPoints = 9;

        //determine hitpoints
		local horseHP = this.getHorse().getHitpoints();
			this.logInfo("horseHP is " + horseHP)
		local riderHP = this.getRider().getHitpoints();
			this.logInfo("riderHP is " + riderHP)
		local totalHP = this.Math.floor((horseHP + riderHP) / 2);
		b.Hitpoints = totalHP;
			this.logInfo("totalHP is " + b.Hitpoints)

        //determine resolve
		local horseBravery = this.getHorse().getBaseProperties().Bravery;
			this.logInfo("horseBravery is " + horseBravery)
		local riderBravery = this.getRider().getBaseProperties().Bravery;
			this.logInfo("riderBravery is " + riderBravery)
		local totalBravery = (horseBravery + riderBravery) / 2;

		if (this.getHorse().getSkills().hasSkill("perk.legend_horse_liberty"))
		{
			totalBravery += riderBravery * 0.25;
		}
		this.logInfo("totalBravery is " + totalBravery)
		b.Bravery = totalBravery;

        //determine fatigue
		local horseFatigue = this.getHorse().getBaseProperties().Stamina;
			this.logInfo("horseFatigue is " + horseFatigue)
		local riderFatigue = this.getRider().getBaseProperties().Stamina;
			this.logInfo("riderFatiguee is " + riderFatigue)
		local totalFatigue = (horseFatigue + riderFatigue) / 2;
			this.logInfo("totalFatiguee is " + totalFatigue)
		b.Stamina = totalFatigue;


        //determine melee skill
		local horseMeleeSkill  = this.getHorse().getBaseProperties().MeleeSkill;
		local riderMeleeSkill  = this.getRider().getBaseProperties().MeleeSkill;
		local totalMeleeSkill  = (horseMeleeSkill  + riderMeleeSkill ) / 2;

		if (this.getHorse().getSkills().hasSkill("perk.legend_horse_desensitization"))
		{
			totalMeleeSkill += riderMeleeSkill * 0.25;
		}

		b.MeleeSkill = totalMeleeSkill;

        //determine ranged skill
		local horseRangedSkill  = this.getHorse().getBaseProperties().RangedSkill;
		local riderRangedSkill  = this.getRider().getBaseProperties().RangedSkill;
		local totalRangedSkill  = (horseRangedSkill  + riderRangedSkill ) / 2;

		if (this.getHorse().getSkills().hasSkill("perk.legend_horse_parthian_shot"))
		{
			totalRangedSkill += riderRangedSkill * 0.25;
		}

		b.RangedSkill = totalRangedSkill;

        //determine melee defense
		local horseMeleeDefense  = this.getHorse().getBaseProperties().MeleeDefense;
		local riderMeleeDefense  = this.getRider().getBaseProperties().MeleeDefense;
		local totalMeleeDefense  = (horseMeleeDefense  + riderMeleeDefense ) / 2;

		if (this.getHorse().getSkills().hasSkill("perk.legend_horse_bitting"))
		{
			totalMeleeDefense += riderMeleeDefense * 0.25;
		}

		b.MeleeDefense = totalMeleeDefense;

        //determine ranged defense
		local horseRangedDefense  = this.getHorse().getBaseProperties().RangedDefense;
		local riderRangedDefense  = this.getRider().getBaseProperties().RangedDefense;
		local totalRangedDefense  = (horseRangedDefense  + riderRangedDefense ) / 2;
		b.RangedDefense = totalRangedDefense;

        //determine initiative
		local horseInitiative = this.getHorse().getBaseProperties().Initiative;
		local riderInitiative = this.getRider().getBaseProperties().Initiative;
		local totalInitiative = (horseInitiative + riderInitiative) / 2;
		b.Initiative = totalInitiative;

		//determine name
		local horseName = this.getHorse().getName();
		local riderName = this.getRider().getName();
		local newName = riderName + " and " + horseName;
		this.setName(newName);

		local background = this.new("scripts/skills/backgrounds/legend_horserider");
		background.setScenarioOnly(true);
		this.m.Skills.add(background);

		//add horse skills
		this.m.ActionPointCosts = this.Const.HorseMovementAPCost;
		this.m.FatigueCosts = clone this.Const.HorseMovementFatigueCost;

        if (!this.getSkills().hasSkill("actives.legend_horse_charge"))
        {
		    this.getSkills().add(this.new("scripts/skills/actives/legend_horse_charge"));
        }
        if (!this.getSkills().hasSkill("actives.legend_horse_kick"))
        {
            this.getSkills().add(this.new("scripts/skills/actives/legend_horse_kick"));
        }

        this.getRider().getItems().transferTo(this.m.Items);
		this.m.PlayerBodyArmor = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body);
		if (this.m.PlayerBodyArmor != null)
        {
			this.m.Items.unequip(this.m.PlayerBodyArmor);
            this.m.PlayerStartBodyDurability = this.m.PlayerBodyArmor.getCondition();

            local head = this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head)
            this.m.PlayerStartHelmetDurability = head.getCondition();

            head.setCondition(this.m.PlayerStartHelmetDurability + this.m.PlayerBodyArmor.getCondition()); 
        }

		this.m.horseArmor = this.getHorse().getItems().getItemAtSlot(this.Const.ItemSlot.Body);
		if (this.m.horseArmor != null)
			this.m.Items.equip(this.m.horseArmor)

        
        local c = this.m.CurrentProperties;
		this.m.ActionPoints = c.ActionPoints;
		this.m.Hitpoints = c.Hitpoints;
        this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
    }

});