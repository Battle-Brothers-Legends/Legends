this.legend_custom_scenario_intro <- this.inherit("scripts/events/event", {
	m = {
		StartBro = null,
		PartySize =  1,
		Traits = [],
		PreviousScreen = "",
		Dude = null,
		Init = false,
		Talent = -1
	},

	function addBro(_background)
	{
		local roster = this.World.getTemporaryRoster();
		this.m.Dude = roster.create("scripts/entity/tactical/player");
		this.m.Dude.setStartValuesEx([_background], false);
		this.m.Dude.m.Talents.resize(this.Const.Attributes.COUNT, 0);

		this.World.getPlayerRoster().add(this.m.Dude);
		this.World.getTemporaryRoster().clear();
		//this.m.Dude.onHired();
		this.m.PartySize += 1;
		this.m.Traits = [];

		// this.m.Dude = null;
		// this.m.Traits = [];
	}

	function setBroScreen(screen)
	{
		screen.Text = "[img]gfx/ui/events/event_25.png[/img] " + this.m.Dude.getName() + " : " + this.m.Dude.getBackground().getNameOnly();
		screen.Characters=[this.m.Dude.getImagePath()];

		foreach (t in this.m.Traits)
		{
			screen.List.push({
				id = 10,
				icon = t.getIconColored(),
				text = t.getName()
			});
		}
		for( local i = 0; i < this.Const.Attributes.COUNT; i = ++i )
		{
			if (this.m.Dude.m.Talents[i] > 0)
			{
				local text = "";
				local icon = "";
				switch(i)
				{
				case 0:
					text = "Hitpoints";
					icon = "health";
					break;

				case 1:
					text = "Resovle";
					icon = "bravery";
					break;

				case 2:
					text = "Fatigue";
					icon = "fatigue";
					break;

				case 3:
					text = "Initiative";
					icon = "initiative";
					break;

				case 4:
					text = "Melee Attack";
					icon = "melee_skill";
					break;

				case 5:
					text = "Range Attack";
					icon = "ranged_skill";
					break;

				case 6:
					text = "Melee Defense";
					icon = "melee_defense";
					break;

				case 7:
					text = "Range Defense";
					icon = "ranged_defense";
					break;
				}

				screen.List.push({
					id = 11,
					icon = "ui/icons/talent_" + this.m.Dude.m.Talents[i] + ".png",
					text = text
				});
			}

		}

	}

	function createHeroesScreen()
	{
		local scriptFiles = this.IO.enumerateFiles("scripts/skills/backgrounds/");
		local blist = {
			character_background = null,
		}
		//Build Hero selection ...
		local screen = {
			ID = "A",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your companions background",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
			],
			function start( _event )
			{
				// if (!_event.m.Init)
				// {
				// 	local bros = this.World.getPlayerRoster();
				// 	foreach (bro in bros)
				// 	{
				// 		//bro.removeActiveRelationship();
				// 		this.World.getPlayerRoster().remove(bro);
				// 	}
				// }
				// _event.m.Init = true;
			}
		}

		local count = 0;
		local screenNum = 0;
		foreach( scriptFile in scriptFiles )
		{
			local bground = this.new(scriptFile);

			local sparts = split(scriptFile, "/");
			local fname = sparts[sparts.len() - 1];

			if (fname in blist) continue;

			local opt = {
				Text = bground.m.Name,
				Background = fname,
				function getResult( _event ) {
					_event.addBro(this.Background)
					//_event.m.Background = this.Background;
					return "F"
				}
			}
			screen.Options.push(opt);

			if (count > 3) {
				local nextScreen = "A" + screenNum;
				local opt = {
					Text = "More ...",
					function getResult( _event ) {
						return nextScreen;
					}
				}
				screen.Options.push(opt);
				this.m.Screens.push(screen);

				screen = {
					ID = nextScreen,
					Text = "[img]gfx/ui/events/event_128.png[/img]Pick your companions background",
					Image = "",
					Banner = "",
					List = [],
					Characters = [],
					Options = [
					],
					function start( _event )
					{
					}
				}
				screenNum++;
				count = 0;
				continue
			};

			count++;
		}

		local opt = {
			Text = "More ...",
			function getResult( _event ) {
				return "A";
			}
		}
		screen.Options.push(opt);
		this.m.Screens.push(screen);
	}

	function createTraitsScreen()
	{

		local screen = {
			ID = "BF",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes traits ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Continue adding traits",
					function getResult( _event ) {
						return _event.m.PreviousScreen;
					}
				},
				{
					Text = "Done",
					function getResult( _event )
					{
						return "F";
					}
				}
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}
		}
		this.m.Screens.push(screen);

		local scriptFiles = this.IO.enumerateFiles("scripts/skills/traits/");
		local blist = {
			character_trait = null,
			legend_frenemies = null,
			legend_alignment = null,
			intensive_training_trait = null,

		}
		//Build Traits selection ...
		screen = {
			ID = "B0",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes traits ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}
		}

		local count = 0;
		local screenNum = 0;
		foreach( scriptFile in scriptFiles )
		{
			local bground = this.new(scriptFile);

			local sparts = split(scriptFile, "/");
			local fname = sparts[sparts.len() - 1];

			if (fname in blist) continue;

			local currScreen = "B" + screenNum;
			local opt = {
				Text = bground.m.Name,
				Trait = scriptFile,
				Screen = currScreen,
				function getResult( _event ) {
					local t = this.new(this.Trait);
					_event.m.Dude.getSkills().add(t);
					_event.m.Traits.push(t);
					_event.m.PreviousScreen = this.Screen;
					return "BF"
				}
			}
			screen.Options.push(opt);

			if (count > 3) {
				screenNum++;
				local nextScreen = "B" + screenNum;
				local opt = {
					Text = "More ...",
					function getResult( _event ) {
						return nextScreen;
					}
				}
				screen.Options.push(opt);
				this.m.Screens.push(screen);

				screen = {
					ID = nextScreen,
					Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes traits ",
					Image = "",
					Banner = "",
					List = [],
					Characters = [],
					Options = [
					],
					function start( _event )
					{
						_event.setBroScreen(this);
					}
				}
				count = 0;
				continue
			};

			count++;
		}

		local opt = {
			Text = "More ...",
			function getResult( _event ) {
				return "B0";
			}
		}
		screen.Options.push(opt);
		this.m.Screens.push(screen);
	}

	function createTalentScreen()
	{

		local screen = {
			ID = "C0",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes talents ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
 				{
					Text = "Hitpoints",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.Hitpoints;
						_event.m.PreviousScreen = "C0";
						return "C1";
					}
				},
 				{
					Text = "Resolve",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.Bravery;
						_event.m.PreviousScreen = "C0";
						return "C1";
					}
				},
 				{
					Text = "Melee Attack",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.MeleeSkill;
						_event.m.PreviousScreen = "C0";
						return "C1";
					}
				}
 				{
					Text = "Melee Defense",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.MeleeDefense;
						_event.m.PreviousScreen = "C0";
						return "C1";
					}
				},
 				{
					Text = "More ...",
					function getResult( _event ) {
						return "C00";
					}
				},
				{
					Text = "Done",
					function getResult( _event ) {
						return "F";
					}
				}
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}
		}
		this.m.Screens.push(screen);

		local screen = {
			ID = "C00",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes talents ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
 				{
					Text = "Fatigue",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.Fatigue;
						_event.m.PreviousScreen = "C00";
						return "C1";
					}
				},
				{
					Text = "Initiative",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.Initiative;
						_event.m.PreviousScreen = "C00";
						return "C1";
					}
				},
 				{
					Text = "Ranged Attack",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.RangedSkill;
						_event.m.PreviousScreen = "C00";
						return "C1";
					}
				},
 				{
					Text = "Ranged Defense",
					function getResult( _event ) {
						_event.m.Talent = this.Const.Attributes.RangedDefense;
						_event.m.PreviousScreen = "C00";
						return "C1";
					}
				},
 				{
					Text = "More ...",
					function getResult( _event ) {
						return "C0";
					}
				},
				{
					Text = "Done",
					function getResult( _event ) {
						return "F";
					}
				}
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}
		}
		this.m.Screens.push(screen);

		local screen = {
			ID = "C1",
			Text = "[img]gfx/ui/events/event_128.png[/img]Pick your heroes talent stars ",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
 				{
					Text = "1",
					function getResult( _event ) {
						_event.m.Dude.m.Talents[_event.m.Talent] = 1;
						return _event.m.PreviousScreen;
					}
				},
 				{
					Text = "2",
					function getResult( _event ) {
						_event.m.Dude.m.Talents[_event.m.Talent] = 2;
						return _event.m.PreviousScreen;
					}
				},
 				{
					Text = "3",
					function getResult( _event ) {
						_event.m.Dude.m.Talents[_event.m.Talent] = 3;
						return _event.m.PreviousScreen;
					}
				}
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}
		}
		this.m.Screens.push(screen);

	}

	function create()
	{
		this.m.ID = "event.legend_custom_scenario_intro";
		this.m.IsSpecial = true;
		this.createHeroesScreen();
		this.createTraitsScreen();
		this.createTalentScreen();


		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_25.png[/img] ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Add Traits",
					function getResult( _event )
					{
						return "B0";
					}
				},
				{
					Text = "Set Talent Stars",
					function getResult( _event )
					{
						return "C0";
					}
				},
				{
					Text = "Add another companion",
					function getResult( _event )
					{
						if (_event.m.Talent == -1) _event.m.Dude.fillTalentValues(3);

						_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
						_event.m.Dude = null
						return "A";
					}
				}
				{
					Text = "Finished",
					function getResult( _event )
					{
						if (_event.m.Talent == -1) _event.m.Dude.fillTalentValues(3);

						_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
						_event.m.Dude = null

						//_event.m.StartBro.removeActiveRelationship();
						 this.World.getPlayerRoster().remove(_event.m.StartBro)

						return 0;
					}
				}
			],
			function start( _event )
			{
				_event.setBroScreen(this);
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = this.World.Assets.getName();
		this.m.StartBro = this.World.getPlayerRoster().getAll()[0];
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});