this.cultist_origin_vs_uneducated_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Uneducated = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_vs_uneducated";
		this.m.Title = "During camp...";
		this.m.Cooldown = 13.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]A few mercenaries come to you looking rather worried. They say %cultist% has been sitting with %uneducated% for a few hours now. When you ask what\'s the worry, they remind you that the cultist has a scarred forehead and speaks of incredibly strange things. Yeah. Those are the demands of Davkul, an example of one\'s committment. You do not understand what could possibly be wrong with that.\n\n You go and see the two of them. %uneducated% looks up at you, smiling, and says the cultist actually has a lot to teach. Perhaps so, but you know Davkul\'s presence need not be felt in all, and if it desired being forced upon the world it would be a misapprehension of Davkul\'s purpose.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Show the darkness.",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "Davkul does not want him.",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]You nod and turn away. By next morning, %uneducated% is found with a freshly wounded forehead, the blood of conversion and the price some must pay to devote themselves to Davkul. When you ask how  %uneducated% is doing, the reply is simple.%SPEECH_ON%Davkul is coming.%SPEECH_OFF%Shaking your head, you correct the initiate.%SPEECH_ON%Davkul is not coming. Davkul AWAITS us all.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Davkul awaits.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				_event.m.Uneducated.getBackground().Convert();
				_event.m.Uneducated.getBackground().m.RawDescription += " " + _event.m.Cultist.getName() + " helped " + _event.m.Uneducated.getName() + " see the darkness.";
				_event.m.Uneducated.getBackground().buildDescription(true);

				//set relations
				local modifier1 = this.Math.rand(10, 20);
				_event.m.Uneducated.changeActiveRelationship( _event.m.Cultist, modifier1 );
				local modifier2 = this.Math.rand(10, 20);
				_event.m.Cultist.changeActiveRelationship( _event.m.Uneducated, modifier2 );
				this.List = [
					{
						id = 13,
						icon = _event.m.Uneducated.getBackground().getIcon(),
						text = _event.m.Uneducated.getName() + " has been converted to a Cultist"
					}
				];
				if (this.World.LegendsMod.Configs().RelationshipsEnabled())
				{
					this.List.push({
						id = 11,
						icon = "ui/icons/relation.png",
						text = _event.m.Cultist.getName() + " and " + _event.m.Uneducated.getName() + " grow closer"
					});
				}
				_event.m.Cultist.getBaseProperties().Bravery += 2;
				_event.m.Cultist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cultist.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] Resolve"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]You separate the two, telling %uneducated% to go count some inventory. With that done, %cultist% sneers at you.%SPEECH_ON%Davkul awaits. You see him in your sleep. You see him in the nights. His darkness is coming. No light burns forever.%SPEECH_OFF%The cultist pauses and stares into your soul. And you stare back from somewhere not of your body. You can only see infinite blackness around you and a pip of light through which %cultist% is looking. Slowly, you float back toward the light and find yourself blinking and staring. %cultist%  bows.%SPEECH_ON%Apologies, captain, I did not know that Davkul had such plans.%SPEECH_OFF%Blinking again, you can only nod.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Davkul awaits us all.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.Characters.push(_event.m.Uneducated.getImagePath());
				_event.m.Cultist.worsenMood(1.0, "Was denied the chance to convert " + _event.m.Uneducated.getName());

				if (_event.m.Cultist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists" && this.World.Assets.getOrigin().getID() != "scenario.legends_necro" )
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getFlags().get("IsSpecial"))
			{
				continue;
			}

			if (bro.getBackground().isCultist())
			{
				cultist_candidates.push(bro);
			}
			else if ((bro.getBackground().isLowborn() && !bro.getSkills().hasSkill("trait.bright")) ||
						(!bro.getBackground().isNoble() && bro.getSkills().hasSkill("trait.dumb"))	   ||
						bro.getSkills().hasSkill("injury.brain_damage") )
					{
						//this.logInfo("1");
						if(bro.getBackground().getID() != "background.legend_commander_berserker" &&
						   bro.getBackground().getID() != "background.legend_berserker" &&
						   bro.getBackground().getID() != "background.legend_donkey")
						{
							//this.logInfo("2");
							uneducated_candidates.push(bro);
						}
					}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.Uneducated = uneducated_candidates[this.Math.rand(0, uneducated_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len() * 7;
		//this.m.Score = 9999;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist.getName()
		]);
		_vars.push([
			"uneducated",
			this.m.Uneducated.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.Uneducated = null;
	}



});

