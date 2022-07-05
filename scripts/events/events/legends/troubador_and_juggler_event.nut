this.troubador_and_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Troubador = null,
		Juggler = null
	},
	function create()
	{
		this.m.ID = "event.troubador_and_juggler";
		this.m.Title = "During camp...";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img] As sparks rise from the fire, %juggler% is stretching and adopting various acrobatic poses. %troubador% approaches and adopts some of the positions along side the juggler. %SPEECH_ON% These movements remind me of the theater troupe i used to perform in. Playing at fighting and love needs tight timings and positioning, to know your spacing as well as your lines. Do you know the faked dagger pass? The trust fall? What of the stage dive?  %SPEECH_OFF% /n/n The juggler laughs and replies. %SPEECH_ON%I have been practicing them for years troubador, shall we dance? %SPEECH_OFF%  The two rise and begin conducting a series of moves you have not seen before. One turning their back to the other and then falling into their arms, before trading places. They grow faster and faster at this blind falling, before the juggler turns midair and the fall becomes a tumble. Soon both are tumbling, through each others arms, and spinning around each other. It becomes a blur of arms, legs and objects moving between them. They begin passing things back and forth, first a ball, then a rock, then a knife. Before long there are items hurling through the air, most caught, but some bouncing off through the camp." 

			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Not standard training, but it will do",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troubador.getImagePath());
				this.Characters.push(_event.m.Juggler.getImagePath());
				local r = this.Math.rand(0, 20);
				local tmdef = _event.m.Troubador.getCurrentProperties().getMeleeDefense;
				local jmdef = _event.m.Juggler.getCurrentProperties().getMeleeDefense;
				local avgmdef = this.Math.floor((tmdef + jmdef) / 2);
				if (r > rdef)
				{
				r = this.Math.rand(1, 5);
					if (r == 1)
					{
					_event.m.Troubador.getBaseProperties().MeleeDefense += 1;
					_event.m.Troubador.getSkills().update();
					this.List.push({
						id = 17,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.Troubador.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Melee Defense"
					});	
					}
					if (r == 2)
					{
					_event.m.Troubador.getBaseProperties().MeleeSkill += 1;
					_event.m.Troubador.getSkills().update();
					this.List.push({
						id = 17,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Troubador.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Melee Skill"
					});	
					}
					if (r == 3)
					{
					local injury = _event.m.Minstrel.addInjury(this.Const.Injury.BluntBody);
					this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Minstrel.getName() + " suffers " + injury.getNameOnly()
					});
					}			
					else
					{
					local injury = _event.m.Minstrel.addInjury(this.Const.Injury.PiercingBody);
					this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Minstrel.getName() + " suffers " + injury.getNameOnly()
					});
					}
				}
				else
				{
					local r;
					r = this.Math.rand(1, 8);
					if (r == 1)
					{
					_event.m.Juggler.getBaseProperties().Meleedefense += 1;
					_event.m.Juggler.getSkills().update();
					this.List.push({
						id = 17,
						icon = "ui/icons/ranged_skill.png",
						text = _event.m.Juggler.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Melee Defense"
					});					
					}
					if (r == 2)
					{
					_event.m.Juggler.getBaseProperties().Meleeskill += 1;
					_event.m.Juggler.getSkills().update();
					this.List.push({
						id = 17,
						icon = "ui/icons/ranged_skill.png",
						text = _event.m.Juggler.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Melee Skill"
					});					
					}
					if (r == 3)
					{
					local injury = _event.m.Minstrel.addInjury(this.Const.Injury.BluntBody);
					this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Minstrel.getName() + " suffers " + injury.getNameOnly()
					});
					}			
					if (r == 4)
					{
					local injury = _event.m.Minstrel.addInjury(this.Const.Injury.PiercingBody);
					this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Minstrel.getName() + " suffers " + injury.getNameOnly()
					});
					}
					
				
					foreach( bro in brothers )
					{
						if (bro.getID() == _event.m.Minstrel.getID() || bro.getID() == _event.m.Juggler.getID())
						{
							continue;
						}
						local r;
						r = this.Math.rand(1, 20);
						if (r == 1)
							{
							bro.getBaseProperties().RangedDefense += 1;
							this.List.push({
							id = 17,
							icon = "ui/icons/ranged_skill.png",
							text = bro.getName() + " gains [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] Ranged Defense"
							});	
							}
						if (r == 2)
						{
						local injury = bro.addInjury(this.Const.Injury.Archery);
						this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = bro.getName() + " suffers " + injury.getNameOnly()
						});
						
						}
					}				
				
				}

			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_troubador = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.female_minstrel")
			{
				candidates_troubador.push(bro);
			}
		}

		if (candidates_troubador.len() == 0)
		{
			return;
		}

		local candidates_juggler = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.juggler")
			{
				candidates_juggler.push(bro);
			}
		}

		if (candidates_juggler.len() == 0)
		{
			return;
		}

		this.m.Troubador = candidates_troubador[this.Math.rand(0, candidates_troubador.len() - 1)];
		this.m.Juggler = candidates_juggler[this.Math.rand(0, candidates_juggler.len() - 1)];
		this.m.Score = (candidates_troubador.len() + candidates_juggler.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"troudbador",
			this.m.Troubador.getNameOnly()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Troubador = null;
		this.m.Juggler = null;
	}

});

