this.hire_mercenaries_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Reward = 0,
		Cost = 20000
	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(120, 130) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.hire_mercenaries_contract";
		this.m.Name = "Hire mercenaries";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1500.0;
	}

	function onImportIntro()
	{
		#this.importSettlementIntro();
	}

	function start()
	{
		this.contract.start();
	}
	
	function getBanner()
	{
		return "ui/banners/factions/banner_11s"
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview_Building");
			}

		});
	

	}

	function createScreens()
	{	
		this.m.Screens.push({
			ID = "Task",
			Title = "Hire mercenaries",
			Text = "Do you wish to hire a group of mercenaries to follow you for 7 days?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "How much will it cost?",
					function getResult()
					{
						
						return "Overview_Building";
					}

				},
				{
					Text = "Not right now.",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		
		this.m.Screens.push({
			ID = "Overview_Building",
			Title = "Hire mercenaries",
			Text = "You will hire a group of mercenaries for 7 days. This will cost " + this.m.Cost + " crowns. Do you wish to do this?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Yes.",
					function getResult()
					{
						if (this.World.Assets.getMoney() >= this.Contract.m.Cost)
						{
							return "Enough"

						}
						else
						{
							return "Not_Enough"
						}
					}

				},
				{
					Text = "No.",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			ShowDifficulty = false,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}
		});

		this.m.Screens.push({
			ID = "Enough",
			Title = "Hire mercenaries",
			Text = "The mercenaries are ready.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Contract.m.Cost);
						local player_faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player);
						local player_base =  player_faction.m.Settlements[0];
						local mercenary_size = 200
						if (player_base.hasAttachedLocation("attached_location.militia_trainingcamp"))
						{
							mercenary_size += 100
						}
						local party = player_faction.spawnEntity(player_base.getTile(), "Mercenary band of " + player_base.getName(), true, this.Const.World.Spawn.Mercenaries, mercenary_size);
						party.getSprite("body").setBrush("figure_mercenary_01");
						party.setDescription("A band of mercenaries following you around.");
						party.setFootprintType(this.Const.World.FootprintsType.CityState);
						party.setMovementSpeed(150)
						party.getFlags().set("IsRandomlySpawned", true);
						local c = party.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false)
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false)
						local follow = this.new("scripts/ai/world/orders/mod_follow_order");
						follow.setDuration(7);
						c.addOrder(follow);
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You lose " + this.Contract.m.Cost + " crowns."
				});
			}

		});

		this.m.Screens.push({
			ID = "Not_Enough",
			Title = "Hire mercenaries",
			Text = "[img]gfx/ui/events/event_30.png[/img]{You don't have enough crowns! Try again later.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Oh well.}",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
	}
	
	function onPrepareVariables( _vars )
	{
	}

	function onHomeSet()
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			this.m.Home.getSprite("selection").Visible = false;

		}

	}


	function onIsValid()
	{
		return true;
	}
	function cancel()
	{
		this.onCancel();
	}
	function removeThisContract()
	{
		this.World.Contracts.removeContract(this);
		this.m.Home.updateQuests()
		this.World.State.getTownScreen().updateContracts();
	}

	function onSerialize( _out )
	{

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);

	}

});

