this.march_wear_and_tear_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null,
		Other = null,
		Vagabond = null,
		Thief = null
	},
	function create()
	{
		this.m.ID = "event.march_wear_and_tear";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{Marching all around the world has put some wear and tear on your sellswords. Whenever a mercenary takes off a boot you can see the blood seeping through the sock. They\'ve accumulated sores and boils. One peels the flesh off a toe and instantly barks their regret, and you nod. All in all, this is the price to pay for being on the road so much.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Suck it up.",
					function getResult( _event )
					{
						return "End";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Tailor != null)
				{
					this.Options.push({
						Text = "Maybe we can fashion some fresh wrappings from what we\'ve got?",
						function getResult( _event )
						{
							return "Tailor";
						}

					});
				}

				if (_event.m.Vagabond != null)
				{
					this.Options.push({
						Text = "You\'ve traveled the world, %travelbro%. Suggestions?",
						function getResult( _event )
						{
							return "Vagabond";
						}

					});
				}

				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "Wait. %streetrat%, you look like you have something to say?",
						function getResult( _event )
						{
							return "Thief";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "End",
			Text = "%terrainImage%{The next stop ain\'t far. You hope the mercenaries can keep it together until they get there. What bandages you have are applied as necessary.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Put your boots back on.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});
					}
				}

				local amount = brothers.len();
				this.World.Assets.addMedicine(-amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Medical Supplies."
				});
			}

		});
		this.m.Screens.push({
			ID = "Tailor",
			Text = "%terrainImage%{%tailor% the tailor rubs their chin with two fingers before finally pointing them forward.%SPEECH_ON%I\'ve got it. Comrades, give me every scrap of unused or trashy clothing you have. Every article you got. Hand it over. There you go. Yes, that\'s absolutely trash, %otherbrother%. Your favorite shirt? By the gods, just give it to me already. Thank you.%SPEECH_OFF%The tailor collects armfuls of discarded clothing and gets to work with scissors. %tailor% slices and dices and pauses. %tailor% pauses a lot, always unsure of the work. But finally the results are presented. A pile of fresh socks and enough left over scraps to furnish some extra bandages. %tailor%\'s also wearing a surprisingly flashy new garb, and you\'ve no idea how it was created.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Now that\'s a magician if I\'ve ever seen one.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Tailor.getImagePath());
				_event.m.Tailor.improveMood(1.0, "Fashioned something nice from cloth scraps");

				if (_event.m.Tailor.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Tailor.getMoodState()],
						text = _event.m.Tailor.getName() + this.Const.MoodStateEvent[_event.m.Tailor.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();
				local amount = brothers.len();
				this.World.Assets.addMedicine(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] Medical Supplies."
				});
			}

		});
		this.m.Screens.push({
			ID = "Vagabond",
			Text = "%terrainImage%{When it comes to walking the earth, %travelbro% is longer in the tooth than anyone and laughs at the plight of fellow sellswords.%SPEECH_ON%Ah, now this is what I\'m talking about! Nevermind the pain, folks, embrace the soreness!%SPEECH_OFF%The company collectively tells %travelbro% to stuff it, but the traveller happily wiggles toes around. You didn\'t even realize %travelbro%\'s boots were off before that, those feet are so calloused you thought the bony figures but folds of leather!}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Put your damn boots back on.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Vagabond.getImagePath());
				_event.m.Vagabond.improveMood(1.0, "Enjoyed life on the road");

				if (_event.m.Vagabond.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Vagabond.getMoodState()],
						text = _event.m.Vagabond.getName() + this.Const.MoodStateEvent[_event.m.Vagabond.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + " suffers light wounds"
						});
					}
				}

				local amount = brothers.len();
				this.World.Assets.addMedicine(-amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "You lose [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] Medical Supplies."
				});
			}

		});
		this.m.Screens.push({
			ID = "Thief",
			Text = "%terrainImage%{%thief% the thief sidles up to you. Stepping away and putting your hands in your pockets, you ask what they want. The shady character smirks and answers.%SPEECH_ON%Alright I\'ll be honest with you captain. Last time we stopped in town I helped myself to a blind peacemaker\'s wares. What? I\'d a sore tooth. No reason to pay to fix what the old gods gave me. Anyway, I fixed my tooth. See? What a smile, right? But then I thought I felt some aches, man, aches all over the place! So I visited the peacemaker again and...%SPEECH_OFF%You interrupt the man and ask just how much was stolen. The answer comes in the form of a sack of medicinal goods. The thief proudly puts hands on hips and stares out at the world with a crooked grin.%SPEECH_ON%Suffice it to say I ain\'t hurtin\' no more.%SPEECH_OFF%} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What were we complaining about again?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
				local amount = this.Math.rand(5, 15);
				this.World.Assets.addMedicine(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]-" + amount + "[/color] Medical Supplies."
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legend_risen_legion")
		{
			return;
		}

		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		if (this.World.Assets.getMedicine() < brothers.len())
		{
			return;
		}

		local candidates_tailor = [];
		local candidates_vagabond = [];
		local candidates_thief = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.tailor")
			{
				candidates_tailor.push(bro);
			}
			else
			{
				candidates_other.push(bro);

				if (bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.legend_commander_assassin")
				{
					candidates_thief.push(bro);
				}
				else if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
				{
					candidates_vagabond.push(bro);
				}
			}
		}

		if (candidates_tailor.len() != 0 && candidates_other.len() != 0)
		{
			this.m.Tailor = candidates_tailor[this.Math.rand(0, candidates_tailor.len() - 1)];
			this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		}

		if (candidates_vagabond.len() != 0)
		{
			this.m.Vagabond = candidates_vagabond[this.Math.rand(0, candidates_vagabond.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"tailor",
			this.m.Tailor != null ? this.m.Tailor.getName() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"travelbro",
			this.m.Vagabond != null ? this.m.Vagabond.getName() : ""
		]);
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Tailor = null;
		this.m.Other = null;
		this.m.Vagabond = null;
		this.m.Thief = null;
	}

});

