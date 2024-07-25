this.recruit_building <- this.inherit("scripts/entity/world/camp/camp_building", {
	m = {},
	function create()
	{
		this.camp_building.create();
		this.m.ID = this.Const.World.CampBuildings.Recruit;
		this.m.Escorting = true;		
		this.m.Slot = "recruit";
		this.m.Name = "Recruit";
		this.m.Description = "Those available for hire linger here";
		this.m.BannerImage = "ui/buttons/banner_rest.png"
		this.m.CanEnter = false
	}

	function getDescription()
	{
		local desc = "";
		desc += "Possible recruits hang around the camp "
		desc += "Perhaps there is someone worth having"
		return desc;
	}

	function getLevel()
	{
		local pro = "dude";
		local sub = "empty";
		if (this.getAssignedBros() > 0) {
			sub =  "full";
		}
		return pro + "_" + sub;
	}

	function getAssignedBros()
	{
		local mod = this.getModifiers();
		return mod.Assigned;
	}

	function getModifiers()
	{
		local ret = 
		{
			Assigned = 0
		}
		local roster = this.World.getPlayerRoster().getAll();
		foreach( bro in roster )
		{
			if (bro.getCampAssignment() != this.m.ID)
			{
				continue
			}
			++ret.Assigned
		}
		return ret;
	}


	function completed()
	{
	}
	
	function getResults()
	{
	}
	function isHidden()
	{
		return !this.World.Flags.get("HasLegendCampRecruit")
	}

	function onClicked( _campScreen )
	{
		_campScreen.getRecruitDialogModule().setRosterID(this.m.Settlement.getID());
		_campScreen.showRecruitDialog();
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
