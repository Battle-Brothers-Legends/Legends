this.add_playerbase_location_contract <- this.inherit("scripts/contracts/contract", {
	//custom quest to add player base building. Is created when entering the base, if not already there. Gives you a list of options for the relevant building. Requires modified CSS file
	m = {
		Reward = 0,
		Building = "",
		Building_text = "",
		Terrain = [
				this.Const.World.TerrainType.Plains,
				this.Const.World.TerrainType.Steppe,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Desert,
				this.Const.World.TerrainType.Land,
				this.Const.World.TerrainType.Swamp,
				this.Const.World.TerrainType.Hills,
				this.Const.World.TerrainType.Forest,
				this.Const.World.TerrainType.SnowyForest,
				this.Const.World.TerrainType.LeaveForest,
				this.Const.World.TerrainType.AutumnForest,
				this.Const.World.TerrainType.Farmland,
				this.Const.World.TerrainType.Snow,
				this.Const.World.TerrainType.Badlands,
				this.Const.World.TerrainType.Tundra,
				this.Const.World.TerrainType.Shore
			],
		Cost = 10 * this.Const.World.StrongholdPriceMult
	},
	function create()
	{
		this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		this.m.Flags = this.new("scripts/tools/tag_collection");
		this.m.TempFlags = this.new("scripts/tools/tag_collection");
		this.createStates();
		this.createScreens();
		this.m.Type = "contract.add_playerbase_location_contract";
		this.m.Name = "Build Location";
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
			Title = "Purchase a new location",
			Text = "Do you wish to purchase a new location? This will cost you 10000 crowns.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "What are my options?",
					function getResult()
					{
						
						return "Negotiation_Building";
					}

				},
				{
					Text = "I won't add a location right now.",
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
			Title = "Purchase a new location",
			Text = "These are your location options.",
			Image = "",
			List = [],
			Options = this.getOptions()
			});
		
		this.m.Screens.push({
			ID = "Enough",
			Title = "Purchase a new location",
			Text = "Your location is finished.",
			Image = "",
			List = [],
			ShowEmployer = false,
			Options = [
				{
					Text = "Good.",
					function getResult()
					{
						this.World.Assets.addMoney(-this.Contract.m.Cost);
						local home = this.Contract.m.Home;
						local location_type = this.Contract.m.Building
						local text = "scripts/entity/world/attached_location/" + location_type
						home.buildAttachedLocation(1, text, this.Contract.m.Terrain, [], 1)
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
					text = "You lose 10000 crowns."
				});
			}

		});

		this.m.Screens.push({
			ID = "Not_Enough",
			Title = "Purchase a new location",
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
		local home = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Player)[0].m.Settlements[0];
		local tile = home.getTile()
		local contract_options = [];
			
		if (!home.hasAttachedLocation("attached_location.workshop"))
		{
			contract_options.push(
			{
				Text = "Build a workshop. Generates tools.",
				function getResult()
				{

					this.Contract.m.Building = "workshop_location"
					this.Contract.addNegScreen("Workshop")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.ore_smelters"))
		{
			contract_options.push(
			{
				Text = "Build an ore smelter. Weaponsmiths carry more items.",
				function getResult()
				{

					this.Contract.m.Building = "ore_smelters_location"
					this.Contract.addNegScreen("Ore Smelter")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.blast_furnace"))
		{
			contract_options.push(
			{
				Text = "Build a blast furnace. Armourers carry more items.",
				function getResult()
				{

					this.Contract.m.Building = "blast_furnace_location"
					this.Contract.addNegScreen("Blast furnace")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.stone_watchtower"))
		{
			contract_options.push(
			{
				Text = "Build a watchtower. Increases speed and sight range around the stronghold.",
				function getResult()
				{
					this.Contract.m.Building = "stone_watchtower_location"
					this.Contract.addNegScreen("Watchtower")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.militia_trainingcamp"))
		{
			contract_options.push(
			{
				Text = "Build a militia camp. Increases strength of mercenaries.",
				function getResult()
				{
					this.Contract.m.Building = "militia_trainingcamp_location"
					this.Contract.addNegScreen("Training camp")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.wheat_fields"))
		{
			contract_options.push(
			{
				Text = "Build wheat fields. You don't consume food around the stronghold.",
				function getResult()
				{
					this.Contract.m.Building = "wheat_fields_location"
					this.Contract.addNegScreen("Wheat Fields")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.herbalists_grove"))
		{
			contract_options.push(
			{
				Text = "Build a herbalists grove. Hitpoints regenerate faster when around the stronghold.",
				function getResult()
				{
					this.Contract.m.Building = "herbalists_grove_location"
					this.Contract.addNegScreen("Herbalists grove")
					return "Overview_Building";
				}
			})
		}
		if (!home.hasAttachedLocation("attached_location.gold_mine"))
		{
			contract_options.push(
			{
				Text = "Build a gold mine. Gold will be generated over time.",
				function getResult()
				{
					this.Contract.m.Building = "gold_mine_location"
					this.Contract.addNegScreen("gold mine")
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
		this.m.Screens.push({
			ID = "Overview_Building",
			Title = "Confirm your choice",
			Text = "You selected a " + _text +". Do you wish to build this?",
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
			ShowEmployer = false,
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

