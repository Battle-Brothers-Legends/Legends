this.negotiator_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.negotiator";
		this.m.Name = "Meeting Point";
		this.m.Description = "Having a dedicated meeting place where negotiators can talk, barter and trade insults with prominant figures or their lackeys can help in finding work.";
		this.m.Image = "ui/campfire/legend_negotiator_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Allows for more rounds of contract negotiations and greater payment with your potential employers before they abort, and with only a 10% chance on a hit to relations. Bad relations recover faster"
			//"Greater contract payment if negotiations are successful and makes good relations with any faction decay slower and bad relations recover faster"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = "Have someone with the Pacifist perk. Guaranteed on Widow, Inventor, Tailor and many others"
			}
		];
		this.m.RequiredSkills = [
			"perk.legend_pacifist"
		];
	}

	function onUpdate()
	{
		if ("NegotiationAnnoyanceMult" in this.World.Assets.m)
			this.World.Assets.m.NegotiationAnnoyanceMult = 0.5;
		if ("AdvancePaymentCap" in this.World.Assets.m)
			this.World.Assets.m.AdvancePaymentCap = 0.75;

		if ("RelationDecayGoodMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves") {
				this.World.Assets.m.RelationDecayGoodMult = 1.075;
			} else {
				this.World.Assets.m.RelationDecayGoodMult = 0.85;
			}
		}
		if ("RelationDecayBadMult" in this.World.Assets.m) {
			if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves") {
				this.World.Assets.m.RelationDecayBadMult = 0.925;
			} else {
				this.World.Assets.m.RelationDecayBadMult = 1.15;
			}
		}

	}

	function onNewDay()
	{
		this.onUpdate();
	}

});

