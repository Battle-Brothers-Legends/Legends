this.runaway_harem_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Citystate = null
	},
	function create()
	{
		this.m.ID = "event.runaway_harem";
		this.m.Title = "Along the way...";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_170.png[/img]{You come across a sparse group of nomads arguing with a troop of the Vizier\'s men. Between them is another group of what look like the sort of women that would be in the Vizier\'s harem. As you draw near all sides pause and stare at you. A lieutenant of the Vizier\'s troop waves you off.%SPEECH_ON%This does not concern you, Crownling.%SPEECH_OFF%But, perhaps trying to invite you into the event, the nomads explain: the women consist of \'indebted\', those whose service is owed to another for failures or transgressions. In this case, they owe services to the Vizier. However, they have escaped and the nomads, who find the concept of indebtedness to be heresy, have taken them in.%SPEECH_ON%Hey, Crownling! Don\'t listen to a word of that nomad\'s poison! And nomad, these women come with us, or you ALL die here.%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I\'d rather not get involved in this.",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "The women belong to the Vizier.",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "The women are free to go wherever they choose.",
					function getResult( _event )
					{
					
						if (this.World.Assets.getOrigin().getID() == "scenario.sato_escaped_slaves" || this.World.Assets.getOrigin().getID() == "scenario.legends_sisterhood")
						{
						return "E";
						}
						else
						{
						return "B";
						}
					}

				}
			],
			function start( _event )
			{
	
				this.Banner = _event.m.Citystate.getUIBannerSmall();

			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_170.png[/img]{You draw your sword and tell the Vizier\'s men to get lost, hoping it works because any violence with them will not be without a good amount of bloodshed. Thankfully, they retreat. The lieutenant bows mockingly.%SPEECH_ON%The womenfolk are free, but with their debts to the Gilder left unpaid, they shall burn in pits of burning sand, a hell from which there will never be escape!%SPEECH_OFF%Laughing, you thank him for the imagery. The nomads also thank you, as do the freed harem though it\'s more with their eyes than anything. One nomad hands you a gift of treasures.%SPEECH_ON%We carry these not for us, but for when we occasion upon travelers such as yourself. We do not seek comforts in material things, not in this world. And do not trust that man of the Vizier. He lies. The Gilder shall see us all in sublimity when it is our time to come.%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Enjoy your freedom.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
				this.World.Assets.addMoralReputation(1);
				this.World.Assets.addMoney(100);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]100[/color] Crowns"
					}
				];
				_event.m.Citystate.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "You aided in the escape of a Vizier\'s harem");
			}

		});
		
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/legend_harem_slave.png[/img]{You draw your sword and tell the Vizier\'s men to lose themselves before they lose their lives. The declaration shifts the balance of power in favour of the nomads, and the vizier\'s men retreat.  The nomads thank you, as do the freed harem. One woman steps forward.%SPEECH_ON%You have shown bravery stranger. We hate that man of the Vizier. He lies, and worse. If you have set your blade against him, then I wish to join you. I have a score to settle.%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Welcome. I hope you know how to use a weapon.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "We don\'t have room for another",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(2);
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"female_slave_southern_background"
				]);
				_event.m.Dude.setTitle("of the dance");
				_event.m.Dude.getBackground().m.RawDescription = "You rescued %name% from a life in slavery after she was forced into the vizier\'s harem. She seeks revenge on the vizier.";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);	
				talents[this.Const.Attributes.MeleeSkill] = 3;
				talents[this.Const.Attributes.Bravery] = 3;
				_event.m.Dude.getSkills().add(this.new("scripts/skills/perks/perk_coup_de_grace"));
				_event.m.Dude.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_southerner"));
				_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/natural_trait"));
				_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/pragmatic_trait"));
				_event.m.Dude.worsenMood(1.0, "Got taken captive by manhunters");
				_event.m.Dude.improveMood(2.0, "Got saved from a life in slavery");
				this.Characters.push(_event.m.Dude.getImagePath());
				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "You aided in the escape of a Vizier\'s harem");
				}
			}

		});
		
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_170.png[/img]{You know a good payday when you see one, and by payday you mean an ambassador of a Vizier. Drawing your sword, you jump between the nomads and the women, telling the former to back off and return to the deserts. The nomads draw bows and raise spears, but their leader quiets them.%SPEECH_ON%No, the interloper has intervened in a manner he finds most suitable, and certainly the Gilder has chosen him as an arbiter in this matter for good reason. Take the women, then, and the dispute is settled.%SPEECH_OFF%The Vizier\'s men gather the harem back into their ranks. A heavy bag is brought to you by the lieutenant.%SPEECH_ON%Payment, Crownling. This was not your task, but that does not mean it carries no reward. You have saved these indebted women from the Gilder\'s hellfire. May our generosity be a constant reminder going forward, yes?%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We look forward to further business with your master.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
				this.World.Assets.addMoney(150);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]150[/color] Crowns"
					}
				];
				_event.m.Citystate.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "You helped to return a Vizier\'s harem");
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_170.png[/img]{You shake your head and wish the women the best in the matter, but it\'s resolved before you can even leave: the nomads back off and the Vizier\'s men take them away. When you ask the nomads why they gave up so quick, their leader states that you must have been an arbitrator sent by the Gilder Himself, and if this is what you chose then so be it. Seems the nomads never had a chance at beating those professional soldiers and you were their last hope.}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It\'s the way of things.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.Citystate.getUIBannerSmall();
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local bestTown;
		local bestDistance = 9000;

		foreach( t in towns )
		{
			local d = currentTile.getDistanceTo(t.getTile());

			if (d <= bestDistance)
			{
				bestDistance = d;
				bestTown = t;
			}
		}

		if (bestTown == null || bestDistance < 7)
		{
			return;
		}

		this.m.Citystate = bestTown.getOwner();
		this.m.Score = 5;
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
		this.m.Citystate = null;
	}

});

