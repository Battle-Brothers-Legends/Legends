this.legends_mutant_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_mutant";
		this.m.Name = "Mutant";
		this.m.Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]A relic from another time. You are a mutant, your body transformed for one task. Hunting monsters.\n\n[color=#bcad8c]Mutant:[/color] Start with a mutant player character.\n[color=#bcad8c]Researchers:[/color] Research the corpses of your fallen foes and gain knowledge to empower your men.\n[color=#bcad8c]Anatomist:[/color] Create mutating potions from your fallen enemies.[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 70;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = this.Const.Roster.getTierForSize(3);
		this.m.StartingBusinessReputation = 800;
		this.setRosterReputationTiers(this.Const.Roster.createReputationTiers(this.m.StartingBusinessReputation));
	}

	function isValid()
	{
		return this.Const.DLC.Paladins;
	}

	function onSpawnAssets()
	{

		local roster = this.World.getPlayerRoster();
		local bro;
		bro = roster.create("scripts/entity/tactical/player");
		bro.setStartValuesEx([
			"hedge_knight_background"
		]);
		bro.getBackground().m.RawDescription = "A relic from another time. You are a mutant, your body transformed for one task. Hunting monsters.";
		bro.getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		bro.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_swordmaster"));
		bro.setTitle("the Mutant");
		bro.getSkills().removeByID("trait.survivor");
		bro.getSkills().removeByID("trait.greedy");
		bro.getSkills().removeByID("trait.loyal");
		bro.getSkills().removeByID("trait.disloyal");
		bro.m.PerkPoints = 3;
		bro.m.LevelUps = 3;
		bro.m.Level = 4;
		bro.setPlaceInFormation(4);
		bro.setVeteranPerks(2);
		bro.getFlags().set("IsPlayerCharacter", true);
		bro.getSprite("socket").setBrush("bust_base_beasthunters"); //custom base
		bro.getSprite("miniboss").setBrush("bust_miniboss_lone_wolf"); //custom bust
		local talents = bro.getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.Initiative] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		local items = bro.getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.equip(this.new("scripts/items/armor/legend_ranger_armor"));
		items.equip(this.new("scripts/items/weapons/warbrand"));
		items.equip(this.new("scripts/items/helmets/undertaker_hat"));
		bro.m.HireTime = this.Time.getVirtualTimeF();
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.m.Ammo = 0;

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_beasts_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_greenskins_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_undead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_legendary_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/apotheosis_potion_item"));
		this.World.Statistics.getFlags().set("isNecromancerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWiedergangerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isFallenHeroPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSkeletonWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHonorGuardPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNecrosavantPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcBerserkerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isOrcWarlordPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinGruntPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
		this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
		this.World.Statistics.getFlags().set("isLindwurmPotionAcquired", false);
		this.World.Statistics.getFlags().set("isUnholdPotionAcquired", false);
		this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
		this.World.Statistics.getFlags().set("isNachzehrerPotionAcquired", false);
		this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHexePotionAcquired", false);
		this.World.Statistics.getFlags().set("isSchratPotionAcquired", false);
		this.World.Statistics.getFlags().set("isSerpentPotionAcquired", false);
		this.World.Statistics.getFlags().set("isKrakenPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
		this.World.Statistics.getFlags().set("isIfritPotionAcquired", false);
		this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
		this.World.Assets.m.Money = this.World.Assets.m.Money;

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Flags.set("HasLegendCampTraining", true);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2 - (this.World.Assets.getEconomicDifficulty() == 0 ? 0 : 100);
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 3;
		this.World.Assets.m.Ammo = 0;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
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
		this.World.Assets.updateLook(11);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.anatomists_scenario_intro");
		}, null);
	}

	function onActorKilled( _actor, _killer, _combatID )
	{
		if (this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			return;
		}

		local isLegendary = _actor.getType() == this.Const.EntityType.ZombieBoss || _actor.getType() == this.Const.EntityType.SkeletonLich || _actor.getType() == this.Const.EntityType.Kraken || _actor.getType() == this.Const.EntityType.TricksterGod;

		if (!isLegendary && _killer != null && _killer.getFaction() != this.Const.Faction.Player && _killer.getFaction() != this.Const.Faction.PlayerAnimals)
		{
			return;
		}

		switch(_actor.getType())
		{
		case this.Const.EntityType.Necromancer:
			this.World.Statistics.getFlags().set("shouldDropNecromancerPotion", true);
			break;

		case this.Const.EntityType.Zombie:
		case this.Const.EntityType.ZombieYeoman:
			this.World.Statistics.getFlags().set("shouldDropWiedergangerPotion", true);
			break;

		case this.Const.EntityType.ZombieKnight:
		case this.Const.EntityType.ZombieBetrayer:
			this.World.Statistics.getFlags().set("shouldDropFallenHeroPotion", true);
			break;

		case this.Const.EntityType.Ghost:
			this.World.Statistics.getFlags().set("shouldDropGeistPotion", true);
			break;

		case this.Const.EntityType.ZombieBoss:
			this.World.Statistics.getFlags().set("shouldDropRachegeistPotion", true);
			break;

		case this.Const.EntityType.SkeletonLight:
		case this.Const.EntityType.SkeletonMedium:
			this.World.Statistics.getFlags().set("shouldDropSkeletonWarriorPotion", true);
			break;

		case this.Const.EntityType.SkeletonHeavy:
			this.World.Statistics.getFlags().set("shouldDropHonorGuardPotion", true);
			break;

		case this.Const.EntityType.SkeletonPriest:
			this.World.Statistics.getFlags().set("shouldDropAncientPriestPotion", true);
			break;

		case this.Const.EntityType.Vampire:
			this.World.Statistics.getFlags().set("shouldDropNecrosavantPotion", true);
			break;

		case this.Const.EntityType.SkeletonLich:
			this.World.Statistics.getFlags().set("shouldDropLorekeeperPotion", true);
			break;

		case this.Const.EntityType.OrcYoung:
			this.World.Statistics.getFlags().set("shouldDropOrcYoungPotion", true);
			break;

		case this.Const.EntityType.OrcWarrior:
			this.World.Statistics.getFlags().set("shouldDropOrcWarriorPotion", true);
			break;

		case this.Const.EntityType.OrcBerserker:
			this.World.Statistics.getFlags().set("shouldDropOrcBerserkerPotion", true);
			break;

		case this.Const.EntityType.OrcWarlord:
			this.World.Statistics.getFlags().set("shouldDropOrcWarlordPotion", true);
			break;

		case this.Const.EntityType.GoblinAmbusher:
		case this.Const.EntityType.GoblinFighter:
		case this.Const.EntityType.GoblinWolfrider:
			this.World.Statistics.getFlags().set("shouldDropGoblinGruntPotion", true);
			break;

		case this.Const.EntityType.GoblinLeader:
			this.World.Statistics.getFlags().set("shouldDropGoblinOverseerPotion", true);
			break;

		case this.Const.EntityType.GoblinShaman:
			this.World.Statistics.getFlags().set("shouldDropGoblinShamanPotion", true);
			break;

		case this.Const.EntityType.Direwolf:
			this.World.Statistics.getFlags().set("shouldDropDirewolfPotion", true);
			break;

		case this.Const.EntityType.Lindwurm:
			this.World.Statistics.getFlags().set("shouldDropLindwurmPotion", true);
			break;

		case this.Const.EntityType.Unhold:
		case this.Const.EntityType.UnholdFrost:
		case this.Const.EntityType.UnholdBog:
		case this.Const.EntityType.BarbarianUnhold:
		case this.Const.EntityType.BarbarianUnholdFrost:
			this.World.Statistics.getFlags().set("shouldDropUnholdPotion", true);
			break;

		case this.Const.EntityType.Spider:
			this.World.Statistics.getFlags().set("shouldDropWebknechtPotion", true);
			break;

		case this.Const.EntityType.Ghoul:
			this.World.Statistics.getFlags().set("shouldDropNachzehrerPotion", true);
			break;

		case this.Const.EntityType.Alp:
			this.World.Statistics.getFlags().set("shouldDropAlpPotion", true);
			break;

		case this.Const.EntityType.Hexe:
			this.World.Statistics.getFlags().set("shouldDropHexePotion", true);
			break;

		case this.Const.EntityType.Schrat:
			this.World.Statistics.getFlags().set("shouldDropSchratPotion", true);
			break;

		case this.Const.EntityType.Kraken:
			this.World.Statistics.getFlags().set("shouldDropKrakenPotion", true);
			break;

		case this.Const.EntityType.TricksterGod:
			this.World.Statistics.getFlags().set("shouldDropIjirokPotion", true);
			break;

		case this.Const.EntityType.Serpent:
			this.World.Statistics.getFlags().set("shouldDropSerpentPotion", true);
			break;

		case this.Const.EntityType.SandGolem:
			this.World.Statistics.getFlags().set("shouldDropIfritPotion", true);
			break;

		case this.Const.EntityType.Hyena:
			this.World.Statistics.getFlags().set("shouldDropHyenaPotion", true);
			break;
		}
	}

	function onBattleWon( _combatLoot )
	{
		local buffs = [
			{
				acquiredFlagName = "isNecromancerPotionAcquired",
				discoveredFlagName = "isNecromancerPotionDiscovered",
				shouldDropFlagName = "shouldDropNecromancerPotion",
				itemName = "necromancer_potion_item"
			},
			{
				acquiredFlagName = "isWiedergangerPotionAcquired",
				discoveredFlagName = "isWiedergangerPotionDiscovered",
				shouldDropFlagName = "shouldDropWiedergangerPotion",
				itemName = "wiederganger_potion_item"
			},
			{
				acquiredFlagName = "isFallenHeroPotionAcquired",
				discoveredFlagName = "isFallenHeroPotionDiscovered",
				shouldDropFlagName = "shouldDropFallenHeroPotion",
				itemName = "fallen_hero_potion_item"
			},
			{
				acquiredFlagName = "isGeistPotionAcquired",
				discoveredFlagName = "isGeistPotionDiscovered",
				shouldDropFlagName = "shouldDropGeistPotion",
				itemName = "geist_potion_item"
			},
			{
				acquiredFlagName = "isRachegeistPotionAcquired",
				discoveredFlagName = "isRachegeistPotionDiscovered",
				shouldDropFlagName = "shouldDropRachegeistPotion",
				itemName = "rachegeist_potion_item"
			},
			{
				acquiredFlagName = "isSkeletonWarriorPotionAcquired",
				discoveredFlagName = "isSkeletonWarriorPotionDiscovered",
				shouldDropFlagName = "shouldDropSkeletonWarriorPotion",
				itemName = "skeleton_warrior_potion_item"
			},
			{
				acquiredFlagName = "isHonorGuardPotionAcquired",
				discoveredFlagName = "isHonorGuardPotionDiscovered",
				shouldDropFlagName = "shouldDropHonorGuardPotion",
				itemName = "honor_guard_potion_item"
			},
			{
				acquiredFlagName = "isAncientPriestPotionAcquired",
				discoveredFlagName = "isAncientPriestPotionDiscovered",
				shouldDropFlagName = "shouldDropAncientPriestPotion",
				itemName = "ancient_priest_potion_item"
			},
			{
				acquiredFlagName = "isNecrosavantPotionAcquired",
				discoveredFlagName = "isNecrosavantPotionDiscovered",
				shouldDropFlagName = "shouldDropNecrosavantPotion",
				itemName = "necrosavant_potion_item"
			},
			{
				acquiredFlagName = "isLorekeeperPotionAcquired",
				discoveredFlagName = "isLorekeeperPotionDiscovered",
				shouldDropFlagName = "shouldDropLorekeeperPotion",
				itemName = "lorekeeper_potion_item"
			},
			{
				acquiredFlagName = "isOrcYoungPotionAcquired",
				discoveredFlagName = "isOrcYoungPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcYoungPotion",
				itemName = "orc_young_potion_item"
			},
			{
				acquiredFlagName = "isOrcWarriorPotionAcquired",
				discoveredFlagName = "isOrcWarriorPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcWarriorPotion",
				itemName = "orc_warrior_potion_item"
			},
			{
				acquiredFlagName = "isOrcBerserkerPotionAcquired",
				discoveredFlagName = "isOrcBerserkerPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcBerserkerPotion",
				itemName = "orc_berserker_potion_item"
			},
			{
				acquiredFlagName = "isOrcWarlordPotionAcquired",
				discoveredFlagName = "isOrcWarlordPotionDiscovered",
				shouldDropFlagName = "shouldDropOrcWarlordPotion",
				itemName = "orc_warlord_potion_item"
			},
			{
				acquiredFlagName = "isGoblinGruntPotionAcquired",
				discoveredFlagName = "isGoblinGruntPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinGruntPotion",
				itemName = "goblin_grunt_potion_item"
			},
			{
				acquiredFlagName = "isGoblinOverseerPotionAcquired",
				discoveredFlagName = "isGoblinOverseerPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinOverseerPotion",
				itemName = "goblin_overseer_potion_item"
			},
			{
				acquiredFlagName = "isGoblinShamanPotionAcquired",
				discoveredFlagName = "isGoblinShamanPotionDiscovered",
				shouldDropFlagName = "shouldDropGoblinShamanPotion",
				itemName = "goblin_shaman_potion_item"
			},
			{
				acquiredFlagName = "isDirewolfPotionAcquired",
				discoveredFlagName = "isDirewolfPotionDiscovered",
				shouldDropFlagName = "shouldDropDirewolfPotion",
				itemName = "direwolf_potion_item"
			},
			{
				acquiredFlagName = "isLindwurmPotionAcquired",
				discoveredFlagName = "isLindwurmPotionDiscovered",
				shouldDropFlagName = "shouldDropLindwurmPotion",
				itemName = "lindwurm_potion_item"
			},
			{
				acquiredFlagName = "isUnholdPotionAcquired",
				discoveredFlagName = "isUnholdPotionDiscovered",
				shouldDropFlagName = "shouldDropUnholdPotion",
				itemName = "unhold_potion_item"
			},
			{
				acquiredFlagName = "isWebknechtPotionAcquired",
				discoveredFlagName = "isWebknechtPotionDiscovered",
				shouldDropFlagName = "shouldDropWebknechtPotion",
				itemName = "webknecht_potion_item"
			},
			{
				acquiredFlagName = "isNachzehrerPotionAcquired",
				discoveredFlagName = "isNachzehrerPotionDiscovered",
				shouldDropFlagName = "shouldDropNachzehrerPotion",
				itemName = "nachzehrer_potion_item"
			},
			{
				acquiredFlagName = "isAlpPotionAcquired",
				discoveredFlagName = "isAlpPotionDiscovered",
				shouldDropFlagName = "shouldDropAlpPotion",
				itemName = "alp_potion_item"
			},
			{
				acquiredFlagName = "isHexePotionAcquired",
				discoveredFlagName = "isHexePotionDiscovered",
				shouldDropFlagName = "shouldDropHexePotion",
				itemName = "hexe_potion_item"
			},
			{
				acquiredFlagName = "isSchratPotionAcquired",
				discoveredFlagName = "isSchratPotionDiscovered",
				shouldDropFlagName = "shouldDropSchratPotion",
				itemName = "schrat_potion_item"
			},
			{
				acquiredFlagName = "isSerpentPotionAcquired",
				discoveredFlagName = "isSerpentPotionDiscovered",
				shouldDropFlagName = "shouldDropSerpentPotion",
				itemName = "serpent_potion_item"
			},
			{
				acquiredFlagName = "isKrakenPotionAcquired",
				discoveredFlagName = "isKrakenPotionDiscovered",
				shouldDropFlagName = "shouldDropKrakenPotion",
				itemName = "kraken_potion_item"
			},
			{
				acquiredFlagName = "isIjirokPotionAcquired",
				discoveredFlagName = "isIjirokPotionDiscovered",
				shouldDropFlagName = "shouldDropIjirokPotion",
				itemName = "ijirok_potion_item"
			},
			{
				acquiredFlagName = "isIfritPotionAcquired",
				discoveredFlagName = "isIfritPotionDiscovered",
				shouldDropFlagName = "shouldDropIfritPotion",
				itemName = "ifrit_potion_item"
			},
			{
				acquiredFlagName = "isHyenaPotionAcquired",
				discoveredFlagName = "isHyenaPotionDiscovered",
				shouldDropFlagName = "shouldDropHyenaPotion",
				itemName = "hyena_potion_item"
			}
		];

		foreach( buff in buffs )
		{
			if (!this.World.Statistics.getFlags().get(buff.acquiredFlagName) && this.World.Statistics.getFlags().get(buff.shouldDropFlagName))
			{
				this.World.Statistics.getFlags().set(buff.acquiredFlagName, true);
				this.World.Statistics.getFlags().set(buff.discoveredFlagName, true);
				_combatLoot.add(this.new("scripts/items/misc/anatomist/" + buff.itemName));
			}
		}
	}

	function onCombatFinished()
	{
		this.World.Statistics.getFlags().set("shouldDropNecromancerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropWiedergangerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropFallenHeroPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGeistPotion", false);
		this.World.Statistics.getFlags().set("shouldDropRachegeistPotion", false);
		this.World.Statistics.getFlags().set("shouldDropSkeletonWarriorPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHonorGuardPotion", false);
		this.World.Statistics.getFlags().set("shouldDropAncientPriestPotion", false);
		this.World.Statistics.getFlags().set("shouldDropNecrosavantPotion", false);
		this.World.Statistics.getFlags().set("shouldDropLorekeeperPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcYoungPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcWarriorPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcBerserkerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropOrcWarlordPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinGruntPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinOverseerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropGoblinShamanPotion", false);
		this.World.Statistics.getFlags().set("shouldDropDirewolfPotion", false);
		this.World.Statistics.getFlags().set("shouldDropLindwurmPotion", false);
		this.World.Statistics.getFlags().set("shouldDropUnholdPotion", false);
		this.World.Statistics.getFlags().set("shouldDropWebknechtPotion", false);
		this.World.Statistics.getFlags().set("shouldDropNachzehrerPotion", false);
		this.World.Statistics.getFlags().set("shouldDropAlpPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHexePotion", false);
		this.World.Statistics.getFlags().set("shouldDropSchratPotion", false);
		this.World.Statistics.getFlags().set("shouldDropSerpentPotion", false);
		this.World.Statistics.getFlags().set("shouldDropKrakenPotion", false);
		this.World.Statistics.getFlags().set("shouldDropIjirokPotion", false);
		this.World.Statistics.getFlags().set("shouldDropIfritPotion", false);
		this.World.Statistics.getFlags().set("shouldDropHyenaPotion", false);
		return true;
	}

});

