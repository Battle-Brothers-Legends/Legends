this.adopt_wardog_event <- this.inherit("scripts/events/event", {
	m = {
		Bro = null,
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.adopt_wardog";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_27.png[/img]You noticed the mutt a few miles back, and a few miles forward he\'s still there, bobbing and slinking in and out of sight.\n\nA mongrel such as he doesn\'t follow a band of dangerous men for no reason - maybe someone is feeding it?",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Chase that mongrel away!",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Better to put it down now before it steals any of our supplies later.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 60)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "The company needs a mascot. Take it in.",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 75)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Houndmaster != null)
				{
					this.Options.push({
						Text = "%houndmaster%, you\'re trained to handle dogs, right?",
						function getResult( _event )
						{
							return "G";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_75.png[/img]This is no place for a pup to be. The next time the dog appears, you crack it between the eyes with a well-placed stone. Yelping, the dog retreats. It pauses, perhaps thinking that there was some sort of mistake here, but you quickly correct the foul thing with another rock. The dog leaves and is not seen again.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And stay away!",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_75.png[/img]You take a bow and nock an arrow. A few of the brothers watch as you take aim. The shot goes wide, but the dog gets the message and quickly scampers off.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I meant to scare it off.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_27.png[/img]You take a bow and nock an arrow. A few of the brothers watch as you take aim. The wind comes, goes, and comes again. You wait patiently before drawing the string and closing one eye to put the dog into focus. It sits down and stares at you between long-tongued pants.\n\nYou release the shot. The arrow zips through the air and the dog yelps. It keels back on its hind legs and falls over, its feet kicking and scraping on the ground until it stops. You put the bow back into its holding and get the company back on the road.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Poor thing.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_27.png[/img]You decide to take a chunk of meat and approach the dog. It is skittish at first, backing away on your approach, but the aroma you have in hand is an alluring one to be sure. The mongrel slinks back toward you, pausing here and there, eyes flicking in search of an ambush.\n\nYou can see a barrel of ribs on the dog, many days on the road having given the pup a gaunt frame. Its ears are stitched up and its tail bolted with signs of battle. This here animal knows how to fight and that\'s just what it\'ll be doing for you from now on.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome to the company.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/legend_wardog_item");
				item.m.Name = "Battle Brother";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_37.png[/img]A rugged dog such as he would make for a great mascot. The little mutt could definitely boost morale. You order %bro% to feed it some food in the hopes that it\'ll tag along. He goes out with a scrap of leftovers and crouches down.%SPEECH_ON%Good dog.%SPEECH_OFF%The mongrel sniffs the food, then chomps down on it - and the mercenary\'s hand along with it. The brother jumps back, nestling his arm into his chest as though he might lose it otherwise. The dog, on the other hand, swallows the scrap and then runs off.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn, he really would have fit in.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro.getImagePath());
				local injury = _event.m.Bro.addInjury(this.Const.Injury.FeedDog);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Bro.getName() + " suffers " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_27.png[/img]You ask %houndmaster% the houndmaster if he can try and \'woo\' this dog. He nods and steps toward it. The wild mongrel\'s ears go from pinned to pointed. Crouched, the houndmaster slowly edges his way toward the beast. He keeps his hand out with a piece of meat in the palm. Hunger overcomes heedfulness and the dog sniffs its way ever closer to the houndmaster\'s hand. The dog tongues it out of his palm and chows down. The dog trainer feeds him another bite. He scruffs him up and finds the sweet spot behind his ears. Looking back, %houndmaster% nods.%SPEECH_ON%Aye, it\'s an agreeable beast and will be easily trained.%SPEECH_OFF%That\'s great. You ask if it can fight. The houndmaster purses his lips.%SPEECH_ON%A dog is akin to a man. If it can breathe, it can fight.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nice.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/legend_wardog_item");
				item.m.Name = "Battle Brother";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Forest || currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.LeaveForest || currentTile.Type == this.Const.World.TerrainType.Mountains)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.legend_muladi")
			{
				candidates.push(bro);
			}
		}

		this.m.Bro = brothers[this.Math.rand(0, brothers.len() - 1)];

		if (candidates.len() != 0)
		{
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];

		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro",
			this.m.Bro.getName()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster != null ? this.m.Houndmaster.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Bro = null;
		this.m.Houndmaster = null;
	}

});

