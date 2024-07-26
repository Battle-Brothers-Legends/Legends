this.camp_recruit_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {
		RosterID = 0
	},
	function setRosterID( _id )
	{
		this.m.RosterID = _id;
	}
	function create()
	{
		this.m.ID = "CampRecruitDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}
	
	function clear()
	{
		this.m.RosterID = 0;
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}
	function queryHireInformation()
	{
		return {
			Roster = this.UIDataHelper.convertHireRosterToUIData(this.m.RosterID),
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onHireRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = this.World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = this.World.Assets.getMoney();
			local currentFood = this.World.Assets.getFood();
			local currentBrothers = entities.len();
			local brothersMax = this.World.Assets.getBrothersMax();
			local hiringCost = this.Math.ceil(entry.getHiringCost() * this.World.Assets.m.HiringCostMult);

			if (currentMoney < hiringCost)
			{
				return {
					Result = this.Const.UI.Error.NotEnoughMoney,
					Assets = null
				};
			}

			if (currentBrothers + 1 > brothersMax)
			{
				return {
					Result = this.Const.UI.Error.NotEnoughRosterSpace,
					Assets = null
				};
			}
			this.World.getPlayerRoster().add(entry);
			this.World.getRoster(this.m.RosterID).remove(entry);
			entry.onHired();
			this.World.Assets.addMoney(-hiringCost);
			this.World.Statistics.getFlags().increment("BrosHired");

			if (this.World.getRoster(this.m.RosterID).getSize() == 0)
			{
				this.m.Parent.getMainDialogModule().reload();
			}

			return {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = this.Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function onTryoutRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = this.World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = this.World.Assets.getMoney();
			local tryoutCost = entry.getTryoutCost();

			if (currentMoney < tryoutCost)
			{
				return {
					Result = this.Const.UI.Error.NotEnoughMoney,
					Assets = null
				};
			}

			entry.setTryoutDone(true);
			this.World.Assets.addMoney(-tryoutCost);
			return {
				Result = 0,
				Roster = this.UIDataHelper.convertHireRosterToUIData(this.m.RosterID),
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = this.Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function onDismissRosterEntry( _entityID )
	{
		local entry = this.findEntityWithinRoster(_entityID);

		if (entry != null)
		{
			local roster = this.World.getPlayerRoster();
			local entities = roster.getAll();
			local currentMoney = this.World.Assets.getMoney();
			local tryoutCost = entry.getTryoutCost();

			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
			{
				if (currentMoney < tryoutCost)
				{
					return {
						Result = this.Const.UI.Error.NotEnoughMoney,
						Assets = null
					};
				}
			}

			this.World.getRoster(this.m.RosterID).remove(entry);

			if ("Assets" in this.World && this.World.Assets != null && this.World.Assets.getEconomicDifficulty() == this.Const.Difficulty.Legendary)
			{
			 this.World.Assets.addMoney(-tryoutCost);
			}

			if (this.World.getRoster(this.m.RosterID).getSize() == 0)
			{
				this.m.Parent.getMainDialogModule().reload();
			}

			return {
				Result = 0,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}

		return {
			Result = this.Const.UI.Error.RosterEntryNotFound,
			Assets = null
		};
	}

	function findEntityWithinRoster( _entryID )
	{
		local roster = this.World.getRoster(this.m.RosterID);
		local entities = roster.getAll();

		if (entities == null)
		{
			return null;
		}

		foreach( entity in entities )
		{
			if (entity.getID() == _entryID)
			{
				return entity;
			}
		}

		return null;
	}
});
