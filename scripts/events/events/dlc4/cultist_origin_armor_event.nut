this.cultist_origin_armor_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_armor";
		this.m.Title = "During camp...";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{An urgency takes %randomcultist%,  who stands, leaves the party\'s campfire, strides across the campground and retires to a tent. It is there that you see %randomcultist% at work, a silhouette and shadows moving frenetically. And there\'s more than just %randomcultist% in there: curves of unknown come and go beside, reaching up in poles of black, tendrils of darkness, whipping and flailing to match the energy of the faithful\'s own procession. And then it is done, a silhouette falling forward before yanking something to the light.\n\n %randomcultist% leaves the tent with the sort of hurry with which it was entered, but this time with a piece of leather chest armor in hand. %randomcultist% drops it to the ground.%SPEECH_ON%He awaits us all, brethren.%SPEECH_OFF%The chest armor is patterned with unique cuts which are arranged in strips that, to the unbelieving eye, would be meaningless. To you, it is but a language of Davkul.}",
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
				this.Characters.push(_event.m.Tailor.getImagePath());
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "You lose " + item.getName()
						});
						break;
					}
				}
				local item = this.Const.World.Common.pickArmor([
					[1, "cultist_leather_robe"],
				]);
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().isCultist())
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash )
		{
			if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
			{
				numItems = ++numItems;
			}
		}

		if (numItems == 0)
		{
			return;
		}

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"randomcultist",
			this.m.Tailor.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Tailor = null;
	}

});

