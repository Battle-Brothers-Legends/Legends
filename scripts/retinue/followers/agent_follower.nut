this.agent_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.agent";
		this.m.Name = "The Agent";
		this.m.Description = "The Agent has eyes and ears everywhere and knows where to go for current events to take advantage of and well-paying contracts both.";
		this.m.Image = "ui/campfire/agent_01";
		this.m.Cost = 2000;
		this.m.Effects = [
			"Reveals available contracts and active situations in the tooltip of settlements no matter where you are"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have allied relations with a noble house or city state"
			},
			{
				IsSatisfied = false,
				Text = "Have at least one of the following backgrounds: Eunuch, Messenger, Assassin (Southern or Northern)"
			}
		];
	}

	function onUpdate()
	{
	}

	function onEvaluate()
	{
		local allied = false;
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);

		local availableBGs = [
			"background.eunuch",
			"background.messenger",
			"background.assassin",
			"background.assassin_southern"
		];

		local brothers = this.World.getPlayerRoster().getAll();
		foreach( bro in brothers )
		{

			local id = bro.getBackground().getID();
			if (availableBGs.find(id) != null)
			{
				this.m.Requirements[1].IsSatisfied = true;
				break;
			}

		}

		foreach( n in nobles )
		{
			if (n.getPlayerRelation() >= 90.0 )
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}

		local citystates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

		foreach( c in citystates )
		{
			if (c.getPlayerRelation() >= 90.0)
			{
				this.m.Requirements[0].IsSatisfied = true;
				return;
			}
		}
	}

});

