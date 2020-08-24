this.cultists_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.cultists";
		this.m.Name = "Davkul Cultists";
		this.m.Description = "[p=c][img]gfx/ui/events/event_140.png[/img][/p][p]Davkul awaits. You lead a small flock devoted to the elder god, and it\'s time to spread the word. Find more followers, acquire riches, and please Davkul with sacrifices.\n\n[color=#bcad8c]Cultists:[/color] Start with a group of four cultists with poor equipment. More cultists may flock to you for free.\n[color=#bcad8c]Sacrifices:[/color] Davkul will occasionally demand sacrifices from you, but also bestow boons upon those loyal to him.\n[color=#c90000]Let the Blood Flow:[/color] Cult events happen twice as often, and cultist gain whip skills.[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 9;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 4; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.getSkills().add(this.new("scripts/skills/traits/cultist_fanatic_trait"));

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"cultist_background"
		]);
		bros[0].getBackground().m.RawDescription = "When %name% joined, he warmly called you captain, saying \"tis a proper manner to pursue the path into the black from whence we came\".";
		bros[0].setPlaceInFormation(2);
		bros[0].setVeteranPerks(2);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		items.equip(this.Const.World.Common.pickHelmet([[1, "cultist_hood"]]));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_wraps"],
		]));
		bros[1].setStartValuesEx([
			"cultist_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name% found you upon the road. He stated that he knew you were a mercenary captain. You wore but ordinary cloth at that moment, but he said by Davkul\'s darkness you had an aura of wanted black about you.";
		bros[1].setPlaceInFormation(3);
		bros[1].setVeteranPerks(2);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "cultist_leather_robe"],
		]));
		items.equip(this.Const.World.Common.pickHelmet([[1, "hood"]]));
		bros[2].setStartValuesEx([
			"cultist_background"
		]);
		bros[2].getBackground().m.RawDescription = "A quiet man, %name% has shadows beneath his fingerprints, running like the brine beneath a pallid shore. When he shook your hand, it was as though you could hear the hissing of your sanity.";
		bros[2].setPlaceInFormation(4);
		bros[2].setVeteranPerks(2);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/battle_whip"));
		items.equip(this.Const.World.Common.pickHelmet([[1, "cultist_leather_hood"]]));
		bros[3].setStartValuesEx([
			"cultist_background"
		]);
		bros[3].getBackground().m.RawDescription = "%name% banded with you outside a tavern. The first time you saw him he had scars running up his arms and across veins that would imply he should not still be living. But each morning it appears as though his scars move, slowly creeping in one direction: toward his forehead.";
		bros[3].setPlaceInFormation(5);
		bros[3].setVeteranPerks(2);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		items.equip(this.Const.World.Common.pickHelmet([[1, "cultist_hood"]]));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_wraps"],
		]));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 400;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() == 1)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Plains && tile.Type != this.Const.World.TerrainType.Steppe && tile.Type != this.Const.World.TerrainType.Tundra && tile.Type != this.Const.World.TerrainType.Snow)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(7);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.cultists_scenario_intro");
		}, null);
	}

	function onUpdateDraftList( _list, _gender)
	{
		if (_list.len() >= 5)
		{
			_list.push("cultist_background");
		}
	}

});

