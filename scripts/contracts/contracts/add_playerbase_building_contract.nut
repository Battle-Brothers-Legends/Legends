this.add_playerbase_building_contract <- this.inherit("scripts/contracts/contract", {
	//custom quest to add player base building. Is created when entering the base, if not already there. Gives you a list of options for the relevant building. Requires modified CSS file
	m = {
		Reward = 0,
		Building = "",
		Building_text = "",
		Cost = 0
	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.add_playerbase_building_contract";
		this.m.Name = "Build Building";
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
				#add building
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview_Building");
			}

		});
	}

	function createScreens()
	{	
		this.m.Screens.push({
			ID = "Task",
			Title = "Purchase a new building",
			Text = "Do you wish to purchase a new building?",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "What are my options?",
					function getResult()
					{
						
						return "Negotiation_Building";
					}

				},
				{
					Text = "I won't add a building right now.",
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
			Title = "Purchase a new building",
			Text = "These are your building options.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = this.getOptions()
			});
		
		this.m.Screens.push({
			ID = "Enough",
			Title = "Purchase a new building",
			Text = "Your building is finished.",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Contract.m.Cost);
						local home = this.Contract.m.Home;
						local building_type = this.Contract.m.Building
						//if upgrade, set flag in base to indicate that, unused rn
						if (this.Contract.m.Flags.get("IsUpgrade"))
						{
							home.getFlags().set(this.Contract.m.upgradedBuilding, true)
						}
						//else just add the building, port pushed to the left
						else
						{
							local text = "scripts/entity/world/settlements/buildings/" + building_type
							local building = this.new(text)
							if (building_type != "port_building")
							{
								home.addBuilding(building);
							}
							else
							{
								if (home.m.Buildings[3] == null)
								{
									home.addBuilding(building, 3);
								}
								else
								{
									local tempbuilding = home.m.Buildings[3];
									home.m.Buildings[3] = null;
									home.addBuilding(building, 3)
									foreach (i, building in home.m.Buildings){
										if (building == null)
										{
											home.addBuilding(tempbuilding, i)
											break;
										}
									}
											
								}
							}
							building.onUpdateShopList();
						}
						
						this.Contract.removeThisContract()
						this.World.State.m.WorldTownScreen.show()
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
			Title = "Purchase a new building",
			Text = "[img]gfx/ui/events/event_04.png[/img]{You don't have enough crowns! Try again later.}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{Oh well.}",
					function getResult()
					{
						local home = this.Contract.m.Home;
						this.World.Contracts.removeContract(this.Contract);
						home.updateQuests();
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
		local home = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0];
		local tile = home.getTile()
		local isSouthern = false;
		if (tile.Type == this.Const.World.TerrainType.Desert || tile.Type == this.Const.World.TerrainType.Oasis || tile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills){
			isSouthern = true;
		}
		
		local contract_options = [];
		if (!home.hasBuilding("building.tavern"))
		{
			contract_options.push(
			{
				Text = "Build a tavern. (5000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "tavern_building";
					this.Contract.m.Cost = 5 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Tavern")
					return "Overview_Building";
				}
			})
		}
		
		if (!home.hasBuilding("building.kennel"))
		{
			contract_options.push(
			{
				Text = "Build a kennel. (5000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "kennel_building";
					this.Contract.m.Cost = 5 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Kennel")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.taxidermist") && !home.hasBuilding("building.taxidermist_oriental"))
		{
			contract_options.push(
			{
				Text = "Build a taxidermist. (5000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = isSouthern ? "taxidermist_oriental_building" : "taxidermist_building";
					this.Contract.m.Cost = 5 * this.Const.World.StrongholdPriceMult			
					this.Contract.addNegScreen("Taxidermist")
					return "Overview_Building";
				}
			})
		}
		
		if (!home.hasBuilding("building.weaponsmith") && !home.hasBuilding("building.weaponsmith_oriental"))
		{
			contract_options.push(
			{
				Text = "Build a weaponsmith. (10000 crowns)",
				function getResult()
				{

					this.Contract.m.Building = isSouthern ? "weaponsmith_oriental_building" : "weaponsmith_building" 
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Weaponsmith")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.armorsmith") && !home.hasBuilding("building.armorsmith_oriental"))
		{
			contract_options.push(
			{
				Text = "Build an armorsmith. (10000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = isSouthern ? "armorsmith_oriental_building" : "armorsmith_building"; 
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("n Armorsmith")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.fletcher"))
		{
			contract_options.push(
			{
				Text = "Build a fletcher. (10000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "fletcher_building";
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Fletcher")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.training_hall"))
		{
			contract_options.push(
			{
				Text = "Build a training hall. (10000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "training_hall_building";
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Training Hall")
					return "Overview_Building";
				}
			})
		}

		
		if (!home.hasBuilding("building.temple") && !home.hasBuilding("building.temple_oriental"))
		{
			contract_options.push(
			{
				Text = "Build a temple. (10000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = isSouthern ? "temple_oriental_building" : "temple_building";
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult				
					this.Contract.addNegScreen("Temple")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.mod_alchemist"))
		{
			contract_options.push(
			{
				Text = "Build an alchemist. (10000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "mod_alchemist_building";
					this.Contract.m.Cost = 10 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("n Alchemist")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.port") && home.isCoastal())
		{
			contract_options.push(
			{
				Text = "Build a port. (15000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "port_building";
					this.Contract.m.Cost = 15 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("Port")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasBuilding("building.arena") && home.getSize() == 3)
		{
			contract_options.push(
			{
				Text = "Build an arena. (20000 crowns)",
				function getResult()
				{
					this.Contract.m.Building = "arena_building";
					this.Contract.m.Cost = 20 * this.Const.World.StrongholdPriceMult
					this.Contract.addNegScreen("n Arena")
					return "Overview_Building";
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
		return contract_options;
	}
	
	function addNegScreen(_text){
		//dynamic to add the name
		this.m.Screens.push({
			ID = "Overview_Building",
			Title = "Confirm your choice",
			Text = "You selected a " + _text +". This will cost " + this.m.Cost + " crowns. Do you wish to build this?",
			Image = "",
			List = [],
			ShowEmployer = true,
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
			ShowEmployer = true,
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

