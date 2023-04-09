this.cultist_origin_flock_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_flock";
		this.m.Title = "Along the road...";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{%joiner%, a wandering devotee of Davkul, has come to join the %companyname%. The company gathers around, the stranger nods, they nod back, and just like that %joiner% is with you. | %joiner%, in rags, yet armored in the shadows of Davkul, has joined the %companyname%. | A devotee by the name of %joiner% shows you dedication to Davkul, a series of spiritual rites shaped about their skull as gruesome scars. %joiner% is welcomed into the %companyname%. | %joiner% stalked the company for a time before approaching you directly. After a time advocating for Davkul\'s purpose, the argument has been made and yourself engendered to it all the same. %joiner% joins the company. | Davkul surely watches over you as a devotee by the name of %joiner% joins the %companyname%. Stating but one purpose, and it was to find you and ensure that this world sees all that awaits it. | %joiner% says they saw the shadows flicker behind your body as though they were \'of flame.\' %joiner% declaring to join your cause for surely Davkul has embedded in you an aspect of the dark and infinite. | %joiner% walks beside you, calling you an aspect of Davkul\'s darkness, and that eternal eyes surely watch over your party whole. The %companyname% takes %joiner% beneath its many shadowed wings. | %joiner% finds the %companyname% on the march and joins its ranks as though no stranger at all. No one says a word and you simply direct %joiner% to the inventory where the purpose may gather teeth. | With a showing of a scarred head, %joiner% claims to be at the speartip of Davkul\'s purpose. You nod and welcome %joiner% into the %companyname%. | Walking in the shadow of Davkul, you were bound to find folk such as %joiner%. Keen on joining the company, in particular because you are in command of it, and more particularly due to a belief Davkul has chosen you. | %joiner% bands with the company and there is little argument as to why. When asked where %joiner% came from, there is a shrug and talk of Davkul while nodding knowingly in your direction.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Yes, join us.",
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
				_event.m.Dude.getBaseProperties().MeleeSkill += 10;
				_event.m.Dude.setStartValuesEx([
					"cultist_background",
					"cultist_background",
					"cultist_background",
					"cultist_background",
					"legend_lurker_background",
					"legend_lurker_background",
					"legend_lurker_background",
					"legend_husk_background",
					"legend_husk_background",					
					"legend_magister_background"
				]);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		this.m.Score = 75;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

