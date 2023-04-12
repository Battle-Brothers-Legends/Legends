this.rookie_gets_hurt_event <- this.inherit("scripts/events/event", {
	m = {
		Rookie = null
	},
	function create()
	{
		this.m.ID = "event.rookie_gets_hurt";
		this.m.Title = "After battle...";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_22.png[/img]After the battle is over, you find %noncombat% on their knees, body swaying back and forth, nursing a wound. You hear muffled cries in between all-too-loud moans. Approaching, you ask the if everything is alright. %noncombat%\'s head shakes and explains that this was the first taste of real, vicious combat. %SPEECH_ON%It was not what I expected and I am not sure if I can continue.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Suck it up!",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 30 ? "B" : "C";
					}

				},
				{
					Text = "There is not a soul out here who isn\'t scared.",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "D" : "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_22.png[/img]You tell the mercenary to harden up. When %noncombat% pauses, stifling a cry, you repeat it again. This time, %noncombat% brings a leg out and plants a foot, steadying. With true grit, the mercenary manages to get standing again. Shirt is bloodslaked, face covered in mud and crimson and other viscera battle makes of the living. But %noncombat%\'s eyes show a sign of resolve they did not before, the sellsword nods at you before walking back to join the rest of the men.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Iron sharpens iron.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.improveMood(1.0, "Had an encouraging talk");
				_event.m.Rookie.getBaseProperties().Bravery += 3;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] Resolve"
					}
				];

				if (_event.m.Rookie.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_22.png[/img]Unfortunately, telling the mercenary to \'suck it up\' gets nowhere. %noncombat% turns to you, face covered in the blood and gore of battle, but before any words can come out, their lip quivers and they keel over again. You ask if %noncombat% wishes to be cut from the company, but the response comes back with a shaken head and a forceful no. I'll get better, he explains. You nod and walk off, but there\'s little doubt that this poor show of resolve has hurt the mercenary\'s pride.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We will be steeled by combat, or we will be killed by it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.getBaseProperties().Bravery -= 3;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + " loses [color=" + this.Const.UI.Color.NegativeEventValue + "]-3[/color] Resolve"
					}
				];
				_event.m.Rookie.worsenMood(1.0, "Lost confidence in himself");

				if (_event.m.Rookie.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_22.png[/img]The mercenary looks around, at the bodies, at the land, at the sky. %noncombat% nods and gets to their feet. Before heading back to camp, thanking you for your words.%SPEECH_ON%Thankee, captain. I\'ll do a better job of hiding my fears.%SPEECH_OFF%You nod back with a terse smile before putting your fist to your chest.%SPEECH_ON%Bottle it all up right here and don\'t let anybody else see it. Half of any battle is convincing your opponent that you\'re crazier than they are. Being fearless is impossible, but faking it for a time is not.%SPEECH_OFF%The sellsword nods again and heads back to camp with head held a little bit higher.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That\'s the spirit!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.improveMood(1.0, "Had an encouraging talk");
				_event.m.Rookie.getBaseProperties().Bravery += 2;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
					}
				];

				if (_event.m.Rookie.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_22.png[/img]The mercenary turns to you, tears cutting through the crusts of bloody cheeks. %noncombat%\'s head is shaking and asking %SPEECH_ON%How is it that I\'m the only one out here crying?%SPEECH_OFF% You shrug and ask if the mercenary wishes to leave the company. %noncombat%\'s head shakes again.%SPEECH_ON%I\'ll get better. I just.. I just need some time to do it, that\'s all.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We will be steeled by combat, or we will be killed by it.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.worsenMood(1.0, "Realized what being a mercenary means");

				if (_event.m.Rookie.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 10.0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() == 1 && bro.getBackground().getID() != "background.slave" && !bro.getBackground().getID() == "background.slave" && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat) && bro.getPlaceInFormation() <= 17 && bro.getLifetimeStats().Battles >= 1)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Rookie = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500; // Updated to Vanilla 1.5.0.14 change from old this.m.Score = candidates.len() * 75; Abyss 4/12/23
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noncombat",
			this.m.Rookie.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Rookie = null;
	}

});

