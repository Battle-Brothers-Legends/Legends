this.dogs_dig_up_loot_event <- this.inherit("scripts/events/event", {
	m = {
		FoundItem = null
	},
	function create()
	{
		this.m.ID = "event.dogs_dig_up_loot";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_27.png[/img]While along the roads, your wardogs suddenly scamper off and begin digging into the earth. You\'re not sure why as you don\'t recall giving either one a bone. A few moments later and they\'re fighting over what appears to be %finding%. You interrupt the tug of war, taking the goods for yourself. The hounds whine, but a few good pets settles them down.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Good boy.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().add(_event.m.FoundItem);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.FoundItem.getIcon(),
					text = "You gain " + this.Const.Strings.getArticle(_event.m.FoundItem.getName()) + _event.m.FoundItem.getName()
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

		if (!currentTile.HasRoad)
		{
			return;
		}

		local numWardogs = 0;
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
			{
				numWardogs = ++numWardogs;
			}
		}

		if (numWardogs < 2)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
				{
					numWardogs = ++numWardogs;

					if (numWardogs >= 2)
					{
						break;
					}
				}
			}
		}

		if (numWardogs < 2)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
		local item;
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			item = this.Const.World.Common.pickArmor([
				[1, "thick_dark_tunic"],
				[1, "noble_tunic"],
				[1, "ragged_surcoat"],
				[1, "thick_tunic"],
				[1, "wizard_robe"],
			]);
		}
		else
		{
			item = this.Const.World.Common.pickHelmet([
				[1, "aketon_cap"],
				[1, "cultist_hood"],
				[1, "hood"],
				[1, "full_leather_cap"],
			]);
		}

		item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
		this.m.FoundItem = item;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"finding",
			this.Const.Strings.getArticle(this.m.FoundItem.getName()) + this.m.FoundItem.getName()
		]);
	}

	function onClear()
	{
		this.m.FoundItem = null;
	}

});

