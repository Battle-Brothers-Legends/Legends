this.holywar_crucified_1_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_crucified_1";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{In the middle of the desert wastes one has to be somewhat suspicious of anything they come across, especially if it\'s a lone figure on the road. The stranger sways from side to side as they drink the last of their water to talk. %SPEECH_ON%Although it may not look it, crownlings, I am one of the best healers and limb-hackers in these parts...%SPEECH_OFF% They sway a little more and take one last drink. %SPEECH_ON%My camp was overrun by knights from the north — I refused to abandon those in need but after they were killed in their beds, I had no choice but to run.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "And what now?",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{The stranger nods.%SPEECH_ON%I know a few things about medicine — I know it is not in a crownling\'s nature to help others but I would surely be able to help you in the coming days of this war and beyond.%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "You\'re welcome with us.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "I don\'t believe you. Keep walking.",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C", //accept
			Text = "{[img]gfx/ui/events/event_161.png[/img]{You reach for your belt and toss your waterskin to the half cooked stranger. They file in but will need some time to recover.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We could use someone who knows how to attach limbs for once.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"legend_surgeon_background"
				]);

				local effect = this.new("scripts/skills/effects_world/exhausted_effect");
				_event.m.Dude.getSkills().add(effect);

				_event.m.Dude.setHitpointsPct(0.33);
				_event.m.Dude.improveMood(3.0, "Was rescued from the desert");
				this.Characters.push(_event.m.Dude.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.improveMood(1.0, "Saved a dying surgeon from the desert");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D", //decline
			Text = "{[img]gfx/ui/events/event_150.png[/img]{You tell the stranger to keep walking, casually thumbing the direction behind you from where you came. The stranger, half cooked in the heat mutters something under the breath and continues in the direction you came from.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "A real surgeon? Not likely.",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.Type != this.Const.World.TerrainType.Oasis && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
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

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

