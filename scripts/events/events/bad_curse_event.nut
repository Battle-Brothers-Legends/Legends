this.bad_curse_event <- this.inherit("scripts/events/event", {
	m = {
		Cursed = null,
		Monk = null,
		Sorcerer = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.bad_curse";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%superstitious% enters your tent with hat in hand. The rim of it turns round and round in their fingers as though plucking feathers from it. Even though you haven\'t said a word the %superstitious% \'s head nods furiously, with eyes darting around as if looking for the words to say.\n\nYou put your quill pen down and ask what the issue is. Licking lips, %superstitious%  nods again and begins to explain the predicament. The words come fast, but the general gist of it seems to be that a local witch has cursed %superstitious% to be incapable of some sexual exploit, as it were.\n\nYou shake your head and ask what it is the witch wants and %superstitious% says %payment% crowns, lest the curse be for life.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "If it must be... go take care of it. Here are the crowns.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "This isn\'t going to happen.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "Have %monk% the monk take a look instead.",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Sorcerer != null)
				{
					this.Options.push({
						Text = "Have %sorcerer% the sorcerer take a look instead.",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Characters.push(_event.m.Cursed.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]Thumb and finger pinching your eyes shut, you wonder if maybe this wasn\'t the life for you. Killing\'s easy, but this? Whatever. You throw your hands up and get out of your chair to retrieve a satchel of crowns. The superstitious mercenary totters up on toe tips.%SPEECH_ON%Please count it out! It mustn\'t be a crown short!%SPEECH_OFF%You begrudgingly set the satchel on the table and begin counting. Once the appropriate number is had, you shuffle it into a purse and toss it to %superstitious%, who bows, thanking you and your mercy. You wave the sellsword off to quickly get the whole incident out of your tent.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "The things I put up with...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				_event.m.Cursed.improveMood(3.0, "Was cured of a curse");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
				});
				this.World.Assets.addMoney(-400);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You spend [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 400 + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]You further muddy %superstitious%\'s poor countenance with some bad news: you\'re not paying any witch anything.%SPEECH_ON%A few farcical words from some strange woman in the woods is no basis for an exchange of business. What you\'ve heard is a tramp\'s attempt to get at you, mercenary. You cannot listen to such tripe, especially a tramp\'s tripe for a tramp\'s tripe is always in pursuit of one\'s coin.%SPEECH_OFF%None of these words help %superstitious% who quickly runs out of the tent, perhaps in pursuit of another mercenary who will give a loan.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Some people can\'t be helped.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				local effect = this.new("scripts/skills/effects_world/afraid_effect");
				_event.m.Cursed.getSkills().add(effect);
				this.List = [
					{
						id = 10,
						icon = effect.getIcon(),
						text = _event.m.Cursed.getName() + " is afraid"
					}
				];
				_event.m.Cursed.worsenMood(2.0, "Felt let down by you");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]Wondering if maybe %monk% could help, you go and fetch the holy figure.\n\n %monk% is happy to lend a hand, for the old gods are always at war with the evils of witchcraft and other sorcery. Before an incoming long monologue about this old god or that one, you dip away and send in %superstitious%. For a few minutes, there is peace and quiet in your tent. But you know it can\'t last, for you are like someone beneath a rockslide, awaiting the tumbling stone with their name on it.\n\n However, %superstitious% doesn\'t return. After a few minutes more you realize there still hasn\'t been a disruptive entrance. In fact, the absence altogether has you on edge, as though silence itself might be haranguing. You leave the tent to find the holy one and so-called cursed one deep in religious talks. Smiling, you return to your tent. If there\'s one thing the holy are best at, it\'s maintaining a sense of tranquility.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That should put an end to this.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				this.Characters.push(_event.m.Monk.getImagePath());

				if (!_event.m.Cursed.getFlags().has("resolve_via_curse"))
				{
					_event.m.Cursed.getFlags().add("resolve_via_curse");
					_event.m.Cursed.getBaseProperties().Bravery += 1;
					_event.m.Cursed.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cursed.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
					});
				}

				if (!_event.m.Monk.getFlags().has("resolve_via_curse"))
				{
					_event.m.Monk.getFlags().add("resolve_via_curse");
					_event.m.Monk.getBaseProperties().Bravery += 1;
					_event.m.Monk.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Resolve"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]You snap your fingers, suddenly remembering %sorcerer%, the so-called sorceror. Wanting to not spend another minute being a part of this bizarre affair, you refer %superstitious% to the sorcerer who is quick to leave, but unfortunately returns a few minutes later, explaining that %sorcerer% has removed the curse.%SPEECH_ON%All I had to do was...%SPEECH_OFF%You hold your hand up, stopping the story right where it be. When asked if you want to hear the rest of it, you give a firm no.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "That should put an end to this.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				this.Characters.push(_event.m.Sorcerer.getImagePath());
				_event.m.Cursed.improveMood(3.0, "Was cured of a curse");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 1000)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_cursed = [];
		local candidates_monk = [];
		local candidates_sorcerer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.slave" && bro.getSkills().hasSkill("trait.superstitious"))
			{
				candidates_cursed.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant" || bro.getBackground().getID() == "background.legend_nun")
			{
				candidates_monk.push(bro);
			}
			else if (bro.getBackground().getID() == "background.sorcerer" || bro.getBackground().getID() == "background.legend_necro" || bro.getBackground().getID() == "background.legend_necro_commander" || bro.getBackground().getID() == "background.legend_witch" || bro.getBackground().getID() == "background.legend_witch_commander")
			{
				candidates_sorcerer.push(bro);
			}
		}

		if (candidates_cursed.len() == 0)
		{
			return;
		}

		this.m.Cursed = candidates_cursed[this.Math.rand(0, candidates_cursed.len() - 1)];

		if (candidates_monk.len() != 0)
		{
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		}

		if (candidates_sorcerer.len() != 0)
		{
			this.m.Sorcerer = candidates_sorcerer[this.Math.rand(0, candidates_sorcerer.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = candidates_cursed.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"superstitious",
			this.m.Cursed.getNameOnly()
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"sorcerer",
			this.m.Sorcerer != null ? this.m.Sorcerer.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"payment",
			"400"
		]);
	}

	function onClear()
	{
		this.m.Cursed = null;
		this.m.Monk = null;
		this.m.Sorcerer = null;
		this.m.Town = null;
	}

});

