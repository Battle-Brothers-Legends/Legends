this.build_road_contract <- this.inherit("scripts/contracts/contract", {
	//abandon hope ye who enter here
	//I have made a mockery of the quest template
	//may the Gilder forgive me
	//srsly though, uses modified build road quests located in player_base (should prob move them here), first half just checks pathing distance to road and substracts existing roads
	m = {
		Reward = 0,
		Cost = this.Const.World.StrongholdPriceMult / 2,
		Sorted_settlements = {},
		Chosen_settlement = null,
		Option = null

	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.build_road_contract";
		this.m.Name = "Build a road";
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
			Title = "Build a road",
			Text = "Do you wish to build a road to the closest town? The cost will depend on the distance.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "How much will it cost?",
					function getResult()
					{
						
						return "Negotiation_Building";
					}

				},
				{
					Text = "I won't build a road right now.",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		
		this.m.Screens.push({
			ID = "Negotiation_Building",
			Title = "Build a new road",
			Text = "You can build roads to these settlements.",
			Image = "",
			List = [],
			Options = this.getOptions()
			});
		
		this.m.Screens.push({
			ID = "Enough",
			Title = "Build a new road",
			Text = "Your road is finished.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						local home = this.Contract.m.Home;
						home.buildRoad(this.Contract.m.Chosen_settlement)
						this.World.Assets.addMoney(-this.Contract.m.Cost);
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
			Title = "Build a road",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You don't have enough crowns! Try again later.}",
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
	
	function getOptions(){
		// searches the road dist, only keeps the closest x since option slots are limited
		local home = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0];
		local tile = home.getTile()
		local settlements = this.World.EntityManager.getSettlements();
		local local_sorted_settlements = [];
		
		foreach (settlement in settlements)
		{
			if (settlement != home){
				local dist = home.getTile().getDistanceTo(settlement.getTile());
				local cost = home.getRoadCost(settlement);
				if (cost && cost != 0)
				{
					local_sorted_settlements.push
					({
					Score = dist, 
					Name = settlement.getName()
					})
				}
			}
		}
		local contract_options = []
		if (local_sorted_settlements.len() == 0){
			contract_options.push(
			{
				Text = "You have built all possible roads!",
				function getResult()
				{
					this.Contract.m.Home.m.Flags.set("AllRoadsBuilt", true)
					this.Contract.removeThisContract()
					return 0;
				}
			})
		}
		else
		{
			local_sorted_settlements.sort(this.onSortByLowestScore);
			this.m.Sorted_settlements = local_sorted_settlements;
			local i_max = 11 < local_sorted_settlements.len() ? 11 : local_sorted_settlements.len();
			
			for (local i=0; i < i_max; i++)
			{
				contract_options.push(
				{
					Text = "Road to " + local_sorted_settlements[i].Name,
					function getResult()
					{

						return "final";
					}
				})
			}
			
			contract_options.push(
				{
					Text = "Not right now.",
					function getResult()
					{
						this.Contract.removeThisContract()
						return 0;
					}
				})
		}
		return contract_options;
	}
	
	function addNegScreen(_i){
		local player_base = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Player).m.Settlements[0];
		foreach (settlement in this.World.EntityManager.getSettlements())
		{
			if(settlement != null && settlement.getName() == this.m.Sorted_settlements[_i].Name)
			{
				this.m.Chosen_settlement = settlement;
			}
		}
		this.m.Cost = player_base.getRoadCost(this.m.Chosen_settlement) * this.m.Cost;

		this.m.Screens.push({	
			ID = "Overview_Building",
			Title = "Build a road",
			Text = "You will try to build a road to " + this.m.Chosen_settlement.getName() +". This will cost " + this.m.Cost + " crowns. Do you wish to do this?",
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
	}

	function onIsValid()
	{
		return true;
	}
	
	function onSortByLowestScore( _d1, _d2 )
	{
		if (_d1.Score < _d2.Score)
		{
			return -1;
		}
		else if (_d1.Score > _d2.Score)
		{
			return 1;
		}

		return 0;
	}
	
	function processInput( _option)
	{
		if (this.m.ActiveScreen == null)
		{
			return false;
		}

		if (_option >= this.m.ActiveScreen.Options.len())
		{
			return true;
		}
		//modded here, to allow skipping ahead if no options are left
		local result = this.m.ActiveScreen.Options[_option].getResult();
		if (result == "final"){
			this.addNegScreen(_option);
			this.setScreen(this.getScreen("Overview_Building"));
			return true;	
		}

		if (typeof result != "string" && result <= 0)
		{
			if (this.isActive())
			{
				this.setScreen(null);
			}

			return false;
		}

		this.setScreen(this.getScreen(result));
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

