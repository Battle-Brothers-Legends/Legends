this.settlement_capture_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.settlement.settlement_capture";
		this.m.Title = "Inside the settlement...";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_30.png[/img]{The settlement's defenders lie dead at your feet. The few civilians that remain cower before you and your company, their valuables open for the taking.\n\n You could leave it all untouched, peacefully declaring this settlement under the ownership of another noble house, which will surely earn you their favor. Or, you could sack the settlement and leave the remains for the crows...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Choose a noble house to hand ownership over to...",
					function getResult( _event )
					{
                        // this.logInfo(this.World.State.getLastLocation());
                        // this.logInfo(this.World.State.getLastLocation().getFactions());
						return "B";

					}
				},
				{
					Text = "Loot and burn!",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});


		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_63.png[/img]{Nobody protests your decision, though you catch %randombrother% staring greedily at the untouched houses. \n\nYou turn to the matter at hand, for which noble house will you declare this settlement?}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
			}

		});

        this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_94.png[/img]{The civilians put up a surprising fight as their houses are stripped of valuables, but their fists are a poor match against steel.\n\n The company leaves with broad grins and sacks of blood-spattered gold.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "We're done here.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local settlement = this.World.State.getLastLocation();
				local money = settlement.calculateLootMoney();
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You loot [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
				settlement.onRaidedByPlayer();
				this.World.Assets.addMoralReputation(-10);
			}

		});

	}

    function transferOwnership( _faction ) {
        local e = this.World.State.getLastLocation();
        local defeatedFaction = e.getOwner();

        this.logInfo("conquering: " + defeatedFaction.getName() + " to " + _faction.getName());
        local settlementFaction = e.getFactionOfType(this.Const.FactionType.Settlement);
        if (defeatedFaction != null)
        {
            if(settlementFaction!=null) {
                defeatedFaction.removeAlly(settlementFaction.getID());
				settlementFaction.cloneAlliesFrom(_faction);
				settlementFaction.addPlayerRelationEx(-15, "Attacked");
            }
            e.removeFaction(defeatedFaction.getID());
        }
        else {
            this.logError("Conquered settlement with no owner!");
        }

        _faction.addSettlement(e);
        _faction.addAlly(settlementFaction.getID());

        _faction.addPlayerRelationEx(15.0, "Conquered a settlement for them");
        defeatedFaction.addPlayerRelationEx(-30.0, "Took over one of their settlements");

        local situation = this.new("scripts/entity/world/settlements/situations/conquered_situation");
        situation.setValidForDays(3);
        e.addSituation(situation);
    }

    function generateNobleSelectOptions() {
        local nobleSelectOptions = [];
        local e = this.World.State.getLastLocation();
        if(e==null) {
            this.logError("Last location was null (should be the settlement that was just conquered)!");
        }
        local defeatedFaction = e.getOwner();
        // this.logInfo(defeatedFaction.getName() + " " + defeatedFaction.getID())
        foreach(faction in this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)) {
            if(faction==null) {
                continue;
            }
            // this.logInfo(faction.getName() + " " + faction.getID())
            if(faction.isAlliedWithPlayer() && faction.getID() != defeatedFaction.getID()) {
                nobleSelectOptions.push({
                    Text = "For " + faction.getName() + "!",
                    Faction = faction,
                    function getResult( _event )
                    {
                        return 0;
                    }
                });
            }
        }

        nobleSelectOptions.push({
            Text = "On second though, loot it all!",
            function getResult( _event )
            {
                return "C";
            }
        });

        return nobleSelectOptions;
    }

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
        foreach( s in this.m.Screens )
		{
			if (s.ID == "B")
			{
                s.Options = generateNobleSelectOptions();
			}
		}
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

    function processInput( _option )
	{
		if (this.m.ActiveScreen == null)
		{
			return false;
		}

		if (_option >= this.m.ActiveScreen.Options.len())
		{
			return true;
		}

        local optionObj =  this.m.ActiveScreen.Options[_option];
        if ("Faction" in optionObj) {
            transferOwnership(optionObj.Faction);
        }

		local result = optionObj.getResult(this);

		if (typeof result != "string" && result <= 0)
		{
			return false;
		}
		this.setScreen(this.getScreen(result));
		return true;
	}
});

