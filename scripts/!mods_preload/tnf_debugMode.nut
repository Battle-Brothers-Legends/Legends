//https://www.nexusmods.com/battlebrothers/mods/69?tab=files

/*


WORLD MAP
3  to 9                  Sets the game speed from 4x to 256x
B  for BOX OF SUPPLIES   Gives supplies except food up to the maximum allowance
E  for EVENT             Triggers a random event among possible ones
F1 for FOG               Removes the fog of war and shows all entities (parties and locations)
G  for GLORY             Adds 500 Renown
H  for HUNGRY OR NOT     Toggles consumption of assets (food, tools, etc.)
J  for JUMP              Teleports the player to the hovered tile
K  for KILL              Destroys the last hovered entity (location or party)
L  for LOVE              Increases relations with all civilian and noble factions by 10%
M  for MONEY             Adds 10k Crowns
N  for ENEMIES           Spawns a group of attacking Orcs
U  for UNKILLABLE        Toggles the ability to be attacked by enemies
V  for VELOCITY          Toggles a movement speed increase
Y  for YMPORTANT YNFO    Prints information in the log about the seed roster and named items

WORLD CHARACTER SCREEN
B for BODY ARMOR   Gives a random named armor
E for ELIXIRS      Gives a selection of potions and flasks
F for FOOD         Gives one stack of food
G for GIFTED       Increases all attributes values of the selected character by their maximum level up range
H for HEAD ARMOR   Gives a random named helmet
J for JUNK         Destroys the last item in the inventory
L for LEVEL        Gives one level to the selected character
M for MULE         Increases the stash capacity by 9
N for NECKLACES    Gives a selection of trophy necklaces
O for OBLIVION     Gives a potion of oblivion
P for PERK         Gives a perk point to the selected character
Q for QUIT TRAIT   Removes the last trait of the selected character
R for REPAIR       Repairs all items and refills all ammunition
S for SHIELD       Gives a random named shield
T for TRAIT        Gives a random positive trait to the selected character
U for UPGRADES     Gives a selection of armor attachments
V for VITALITY     Heals all afflictions from the selected character and raises up his mood to the maximum
W for WEAPON       Gives a random named weapon
Z for ZERO         Adds a random recruit to the roster

TACTICAL MAP
F1 to F11                    Sets combat speed from x1 to x11
E for EXPLORE                Uncovers the fog of war and gives full vision
G for GREENSKIN              Summons a random enemy Greenskin
H for HEAL                   Heals all player characters, repairs all items and refills all ammunition
J for JUMP                   Teleports the player to the hovered tile
K for KILL                   Kills the hovered actor
L for LEAVE                  Leaves battle
M for MONSTER                Summons a random enemy beast
N for NAMED CHAMPION         Summons a random enemy champion
O for OBLITERATE             Kills all enemies
P for PRIMITIVES & PIRATES   Summons a random enemy Barbarian or Brigand
U for UNDEAD                 Summons a random enemy Undead
V for VETERANS               Summons a random enemy militia, soldier or mercenary
X for XBOW                   Summons a henchman to fight for you
Z for debug enemy list
*/


local gt = this.getroottable();

local files = clone gt.tnf_debug.files;
gt.tnf_debug.fillFileList(files);
local purgedFiles = gt.tnf_debug.purgeFileList(files);

local virtualSpeed = 1.0;

::mods_registerJS("tnf_debugMode.js");

::mods_hookNewObject("ui/screens/character/character_screen", function (o) {

  o.tnf_onGiveActiveCharacter <- function ( _data )
  {
    local bro = this.Tactical.getEntityByID(_data[0]);
    switch(_data[1]) {
      case "Level":
        bro.addXP(gt.Const.LevelXP[bro.getLevel()] - bro.getXP(), false);
        bro.updateLevel();
        break;
      case "Perk":
        bro.m.PerkPoints++;
        break;
      case "Stats":
        foreach (index, attribute in gt.tnf_debug.attributes)
        {
          bro.getBaseProperties()[attribute] += gt.Const.AttributesLevelUp[index].Max;
          bro.getCurrentProperties()[attribute] += gt.Const.AttributesLevelUp[index].Max;
        }
        bro.setHitpointsPct(1);
        break;
      case "Heal":
        bro.setHitpointsPct(1);
        bro.getSkills().removeByType(this.Const.SkillType.Injury);
        bro.getSkills().removeByID("trait.old");
        bro.getSkills().removeByID("trait.addict");
        bro.getSkills().removeByID("effects.hangover");
        bro.getSkills().removeByID("effects.exhausted");
        bro.getSprite("permanent_injury_1").Visible = false;
        bro.getSprite("permanent_injury_2").Visible = false;
        bro.getSprite("permanent_injury_3").Visible = false;
        bro.getSprite("permanent_injury_4").Visible = false;
        bro.getSprite("permanent_injury_scarred").Visible = false;
        bro.getSprite("permanent_injury_burned").Visible = false;
        bro.improveMood(10.0, "Has enjoyed Vilain's debug mode");
        break;
      case "Trait":
        local trait = gt.tnf_debug.positiveTraits[this.Math.rand(0, gt.tnf_debug.positiveTraits.len() - 1)];
        bro.getSkills().add(this.new("scripts/skills/traits/" + trait + "_trait"));
        break;
      case "RTrait":
        local traits = gt.tnf_debug.getTraits(bro);
        local trait = traits[traits.len() - 1];
        bro.getSkills().removeByID(trait);
        break;
    }
  };
});

::mods_hookNewObjectOnce("states/world_state", function (o) {

local keyHandler = o.helper_handleContextualKeyInput;

o.helper_handleContextualKeyInput = function(_key)
{
  /* keyHandler(_key) will always return true in char screen */
  if (!this.isInCharacterScreen()) {if (keyHandler(_key)) return;}
  if (_key.getState() != 0) return; //key pressed and released

  if (_key.getKey() == 14 && _key.getModifier() == 2) //CTRL + D
  {
    this.Const.LegendMod.DebugMode = !this.Const.LegendMod.DebugMode;
    if (this.Const.LegendMod.DebugMode)
    {
      this.logDebug(" *** DEBUG MODE ENABLED ***");
    }
    else
    {
      this.logDebug(" *** DEBUG MODE DISABLED ***");
    }
    return;
  }

  if (this.isInCharacterScreen())
  {
    switch(_key.getKey()) {

      // DEFAULT HOTKEYS //

			case 11:
			case 48:
				this.m.CharacterScreen.switchToPreviousBrother();
				break;

			case 38:
			case 14:
			case 50:
				this.m.CharacterScreen.switchToNextBrother();
				break;

			case 19:
			case 13:
			case 41:
				this.toggleCharacterScreen();
				break;
    }
  }

  if (!this.Const.LegendMod.DebugMode) return;

  //------------------//
  // CHARACTER SCREEN //
  //------------------//

  if (this.isInCharacterScreen())
  {
    switch(_key.getKey()) {

      // HOTKEYS USED: A, C, D, I //

      case 12: //B for BODY ARMOR (Named)
        local type = "named_armors";
        local file = purgedFiles[type][this.Math.rand(0, purgedFiles[type].len() - 1)];
        this.World.Assets.getStash().add(this.new(file));
        this.m.CharacterScreen.loadStashList();
        return;

      case 15: //E for ELIXIRS
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/antidote_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/cat_potion_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/iron_will_potion_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/lionheart_potion_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/night_vision_elixir_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/recovery_potion_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/spider_poison_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/misc/potion_of_knowledge_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/tools/acid_flask_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/tools/holy_water_item"));
        this.m.CharacterScreen.loadStashList();
        return;

      case 16: //F for FOOD
        this.World.Assets.getStash().add(this.new("scripts/items/supplies/fermented_unhold_heart_item"));
        this.m.CharacterScreen.loadStashList();
        return;

      case 17: //G for GIFTED (Super)
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "Stats");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 18: //H for HEAD ARMOR (Named)
        local type = "named_helmets";
        local file = purgedFiles[type][this.Math.rand(0, purgedFiles[type].len() - 1)];
        this.World.Assets.getStash().add(this.new(file));
        this.m.CharacterScreen.loadStashList();
        return;

      case 20: //J for JUNK
      local inventory = this.World.Assets.getStash().getItems();
      for (local slot = inventory.len() - 1; slot != 0; slot--)
      {
        if (inventory[slot] == null) continue;
        this.World.Assets.getStash().removeByIndex(slot);
        break;
      }
      this.m.CharacterScreen.loadStashList();
      return;

      case 22: //L for LEVEL
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "Level");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 23: //M for MULE
        this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);
        this.m.CharacterScreen.loadData();
        return;

      case 24: //N for NECKLACES
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/goblin_trophy_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/orc_trophy_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/sergeant_badge_item"));
        this.World.Assets.getStash().add(this.new("scripts/items/accessory/undead_trophy_item"));
        this.m.CharacterScreen.loadStashList();
        return;

      case 25: //O for OBLIVION
        this.World.Assets.getStash().add(this.new("scripts/items/misc/potion_of_oblivion_item"));
        this.m.CharacterScreen.loadStashList();
        return;

      case 26: //P for PERK
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "Perk");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 27: //Q for QUIT TRAIT
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "RTrait");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 28: //R for REPAIR
        local inventory = this.World.Assets.getStash().getItems();
        local roster = this.World.getPlayerRoster().getAll();
        foreach (item in inventory)
        {
          if (item == null) continue;
          if (item.getCondition() < item.getConditionMax()) item.setCondition(item.getConditionMax());
        }
        foreach(bro in roster)
        {
          foreach (item in bro.getItems().getAllItems())
          {
            if (item.getCondition() < item.getConditionMax()) item.setCondition(item.getConditionMax());
            if (item.isItemType(this.Const.Items.ItemType.Ammo) && item.getAmmo() < item.getAmmoMax())
              item.setAmmo(item.getAmmoMax());
          }
        }
        this.m.CharacterScreen.loadData();
        return;

      case 29: //S for SHIELD (Named)
        local type = "named_shields";
        local file = purgedFiles[type][this.Math.rand(0, purgedFiles[type].len() - 1)];
        this.World.Assets.getStash().add(this.new(file));
        this.m.CharacterScreen.loadStashList();
        return;

      case 30: //T for TRAIT
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "Trait");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 31: //U for UPGRADES
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/additional_padding_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/bone_platings_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/direwolf_pelt_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/light_padding_replacement_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/lindwurm_scales_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/protective_runes_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/armor_upgrades/unhold_fur_upgrade"));
        this.World.Assets.getStash().add(this.new("scripts/items/misc/wardog_heavy_armor_upgrade_item"));
        this.m.CharacterScreen.loadStashList();
        return;

      case 32: //V for VIGOR & VITALITY
        local playerRoster = this.World.getPlayerRoster().getAll();
        if (this.m.CharacterScreen.m.JSDataSourceHandle != null)
        {
          this.m.CharacterScreen.m.JSDataSourceHandle.asyncCall("tnf_giveActiveCharacter", "Heal");
        }
        this.m.CharacterScreen.loadBrothersList();
        return;

      case 33: //W for WEAPON (Named)
        local type = "named_weapons";
        local file = purgedFiles[type][this.Math.rand(0, purgedFiles[type].len() - 1)];
        this.World.Assets.getStash().add(this.new(file));
        this.m.CharacterScreen.loadStashList();
        return;

      case 36: //Z for ZERO
        local backgrounds = clone purgedFiles.backgrounds;
        function slice(string) {return string.slice(gt.tnf_debug.directories.backgrounds.len());}
        backgrounds.apply(slice); //file name

        local roster = this.World.getPlayerRoster();
        local bros = roster.getAll();
        if (bros.len() >= this.World.Assets.m.BrothersMax) return;

        local bro = roster.create("scripts/entity/tactical/player");
        bro.m.HireTime = this.Time.getVirtualTimeF();
        bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
        bro.setStartValuesEx(backgrounds); //array of backgrounds
        bro.getBackground().buildDescription(true);
        bro.m.Attributes = [];
        bro.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
        bro.getSkills().update();
        this.World.Assets.updateFormation();
        this.m.CharacterScreen.loadBrothersList();
        return;
    }
  }

  //-----------//
  // WORLD MAP //
  //-----------//

  /* No default hotkey for this key, key pressed and released and not in a menu */
  if(!this.m.MenuStack.hasBacksteps())
  {
    switch (_key.getKey()) {

      //WORLD SPEED SETTINGS//
      case 3:
        this.setPause(false);
				this.World.setSpeedMult(4.0);
        this.logDebug("tnf_debugMode | World Speed set to x4.0");
        return;

      case 4:
        this.setPause(false);
				this.World.setSpeedMult(8.0);
        this.logDebug("tnf_debugMode | World Speed set to x8.0");
        return;

      case 5:
        this.setPause(false);
				this.World.setSpeedMult(16.0);
        this.logDebug("tnf_debugMode | World Speed set to x16.0");
        return;

      case 6:
        this.setPause(false);
				this.World.setSpeedMult(32.0);
        this.logDebug("tnf_debugMode | World Speed set to x32.0");
        return;

      case 7:
        this.setPause(false);
				this.World.setSpeedMult(64.0);
        this.logDebug("tnf_debugMode | World Speed set to x64.0");
        return;

      case 8:
        this.setPause(false);
				this.World.setSpeedMult(128.0);
        this.logDebug("tnf_debugMode | World Speed set to x128.0");
        return;

      case 9:
        this.setPause(false);
				this.World.setSpeedMult(256.0);
        this.logDebug("tnf_debugMode | World Speed set to x256.0");
        return;

      //case 11: //A (Movement FR)

      case 12: //B for BOX OF SUPPLIES
        local difficulty = this.World.Assets.getEconomicDifficulty();
        local maxResources = gt.Const.Difficulty.MaxResources;
        this.World.Assets.m.ArmorParts = maxResources[difficulty].ArmorParts;
        this.World.Assets.m.Medicine = maxResources[difficulty].Medicine;
        this.World.Assets.m.Ammo = maxResources[difficulty].Ammo;
        this.updateTopbarAssets();
        return;

      //case 13: //C (CharacterScreen)
      //case 14: //D (right)

      case 15: //E for EVENT
        local score = 0;
        local eventToFire;
        local events = this.World.Events.m.Events;

        for( local i = 0; i < events.len(); i = ++i )
        {
          events[i].update();
          //events[i].onClear();
          //events[i].onUpdateScore();
          score = score + events[i].getScore();
        }

        local pick = this.Math.rand(1, score);
        //this.logInfo(pick);

        for( local i = 0; i < events.len(); i = ++i )
        {
          //if (events[i].getScore() > 0) this.logInfo(events[i].getID() + events[i].getScore());
          if (pick <= events[i].getScore())
          {
            eventToFire = events[i];
            //this.logInfo(eventToFire.getID());
            break;
          }
          pick = pick - events[i].getScore();
        }
        if (eventToFire == null)
        {
          this.logDebug("tnf_debugMode | The pool of possible events has been emptied. No event left to fire!");
          return;
        }
        this.World.Events.fire(eventToFire.getID());
        return;

      //case 16: //F (Follow Tracks)

      case 17: //G for GLORY (Renown)
        this.World.Assets.addBusinessReputation(500);
        return;

      case 18: //H for HUNGRY OR NOT
        this.World.Assets.setConsumingAssets(!this.World.Assets.isConsumingAssets());
        if (this.World.Assets.isConsumingAssets())
        {
          this.logDebug("tnf_debugMode | Player is consuming assets.");
        }
        else
        {
          this.logDebug("tnf_debugMode | Player is NOT consuming assets.");
        }
        return;

      //case 19: //I (CharacterScreen)

      case 20: //J for JUMP
        if (this.m.LastTileHovered != null)
        {
          local tilePos = this.m.LastTileHovered.Pos;
          this.World.State.getPlayer().setPos(tilePos);
          this.World.setPlayerPos(tilePos);
        }
        return;

      case 21: //K for KILL
        if (this.m.LastEntityHovered != null)
        {
          local e = this.m.LastEntityHovered;
          if (e.isLocation())
          {
            if (e.m.LocationType == this.Const.World.LocationType.Settlement)
            {
              this.logDebug("tnf_debugMode | Settlement destroyed");
              e.destroy();
            }
            else if (e.m.LocationType == this.Const.World.LocationType.AttachedLocation)
            {
              this.logDebug("tnf_debugMode | Attached location destroyed");
              e.setActive(false);
            }
            else
            {
              this.logDebug("tnf_debugMode | Enemy location destroyed");
              e.onCombatLost();
            }
          }
          else
          {
            this.logDebug("tnf_debugMode | Party destroyed");
            e.onCombatLost();
          }
        }
        return;

      case 22: //L for LOVE (Relations)
        local factionTypes = {
          villages = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.Settlement),
          nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse)
        };
        local reason = "Used Vilain's debug mode with discretion";
        foreach(factionType, factions in factionTypes)
        {
          foreach(faction in factions) {faction.addPlayerRelation(10, reason);}
        }
        return;

      case 23: //M for MONEY
        this.World.Assets.addMoney(10000);
        this.updateTopbarAssets();
        return;

      case 24: //N for ENEMIES (Orcs)
        if (this.m.LastTileHovered != null)
        {
          local faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs);
          local party = faction.spawnEntity(this.m.LastTileHovered, "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, 200);
          party.getSprite("banner").setBrush("banner_orcs_04");
          party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
          local c = party.getController();
          local ambush = this.new("scripts/ai/world/orders/ambush_order");
          c.addOrder(ambush);
          return;
        }

      //case 25: //O (Obituary)
      //case 26: //P (Pause)
      //case 27: //Q (Movement FR)
      //case 28: //R (Relations screen)
      //case 29: //S (Movement)
      //case 30: //T (Camp)

      case 31: //U for UN-KILLABLE
        this.m.Player.setAttackable(!this.m.Player.isAttackable());
        if (this.m.Player.isAttackable())
        {
          this.logDebug("tnf_debugMode | Player can now be attacked.");
        }
        else
        {
          this.logDebug("tnf_debugMode | Player can NOT be attacked.");
        }
        return;

      case 32: //V for VELOCITY
        if (this.World.State.getPlayer().m.BaseMovementSpeed > 1000)
        {
          if (this.World.Assets.getOrigin().getID() == "scenario.rangers")
          {
            this.World.State.getPlayer().m.BaseMovementSpeed = 111;
          }
          else
          {
            this.World.State.getPlayer().m.BaseMovementSpeed = 105;
          }
          return;
        }
        this.World.State.getPlayer().m.BaseMovementSpeed *= 2;
        return;

      //case 33: //W (Movement)
      //case 34: //X (Lock camera)

      case 35: //Y for YMPORTANT YNFO
        gt.tnf_debug.logSeedFertility();
        return;

      //case 36: //Z (Movement FR)

      case 71: //F1 for FOG
        this.World.setFogOfWar(!this.World.isUsingFogOfWar());
        if (this.World.isUsingFogOfWar())
        {
          this.logDebug("tnf_debugMode | Fog Of War activated.");
        }
        else
        {
          this.logDebug("tnf_debugMode | Fog Of War deactivated.");
        }
        return;

      //case 75: //F5 (Quick save)
      //case 79: //F9 (Quick load)
    }
  }
}
});

::mods_hookExactClass("states/tactical_state", function (o) {

local updateCurrentEntity = o.updateCurrentEntity;
o.updateCurrentEntity = function()
{
  updateCurrentEntity();
  if (this.Time.getVirtualSpeed != virtualSpeed) this.Time.setVirtualSpeed(virtualSpeed);
}

local keyHandler = o.helper_handleContextualKeyInput;
o.helper_handleContextualKeyInput = function(_key)
{
  /* keyHandler(_key) will always return true in char screen */
  /* or if input is ignored (enemy turn) */

  if (!this.isInputLocked()) {if (keyHandler(_key)) return;}
  if (_key.getState() != 0) return; //key pressed and released

  if (_key.getKey() == 14 && _key.getModifier() == 2) //CTRL + D
  {
    this.Const.LegendMod.DebugMode = !this.Const.LegendMod.DebugMode;
    if (this.Const.LegendMod.DebugMode)
    {
      this.logDebug("*** DEBUG MODE ENABLED ***");
    }
    else
    {
      this.logDebug("*** DEBUG MODE DISABLED ***");
    }
    return;
  }

  if (!this.Const.LegendMod.DebugMode || this.m.MenuStack.hasBacksteps()) return;

  switch (_key.getKey()) {

    //SPEED SETTINGS//
    case 71:
      virtualSpeed = 1.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x1.0");
      return;
    case 72:
      virtualSpeed = 2.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x2.0");
      return;

    case 73:
      virtualSpeed = 3.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x3.0");
      return;

    case 74:
      virtualSpeed = 4.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x4.0");
      return;

    case 75:
      virtualSpeed = 5.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x5.0");
      return;

    case 76:
      virtualSpeed = 6.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x6.0");
      return;

    case 77:
      virtualSpeed = 7.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x7.0");
      return;

    case 78:
      virtualSpeed = 8.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x8.0");
      return;

    case 79:
      virtualSpeed = 9.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x9.0");
      return;

    case 80:
      virtualSpeed = 10.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x10.0");
      return;

    case 81:
      virtualSpeed = 11.0;
      this.logDebug("tnf_debugMode | Virtual Speed set to x11.0");
      return;

    ///////////////////////////////////
    //  HOTKEYS TAKEN: C, F, I, R, T //
    //  MVT: AZQSDW                  //
    ///////////////////////////////////

    //case 12: //B (Blocked tiles)

    case 14: //D (Movement)

    case 15: //E for EXPLORE
      this.m.IsFogOfWarVisible = !this.m.IsFogOfWarVisible;
      if (this.m.IsFogOfWarVisible)
      {
        this.Tactical.fillVisibility(this.Const.Faction.Player, false);
        local heroes = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
        foreach (i, hero in heroes) hero.updateVisibilityForFaction();
        local activeEntity = this.Tactical.TurnSequenceBar.getActiveEntity();
        if (activeEntity != null) activeEntity.updateVisibilityForFaction();
      }
      else {this.Tactical.fillVisibility(this.Const.Faction.Player, true);}
      return;

    case 17: //G for GREENSKIN
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
			{
        local faction = this.Math.rand(0, 1) ? "Orcs" : "Goblins";
        local actor = gt.tnf_debug.getRandomActor(faction);
        local script = this.Const.World.Spawn.Troops[actor[1]].Script;
				local entity = this.Tactical.spawnEntity(script);
				entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType[faction]).getID());
				entity.assignRandomEquipment();
			}
      return;

    case 18: //H for HEAL
      local instances = this.Tactical.Entities.getAllInstancesAsArray();
      foreach (actor in instances)
      {
        if (actor.isAlive() && actor.isPlayerControlled())
        {
          actor.setHitpointsPct(1);
          actor.setActionPoints(9);
          actor.setFatigue(0);
          actor.setMoraleState(this.Const.MoraleState.Confident);
          local skills = actor.getSkills();
          skills.removeByType(this.Const.SkillType.Injury);
          foreach (effect in gt.tnf_debug.negativeStatusEffects)
          {
            if (!skills.hasSkill("effects." + effect)) continue;
            if (effect == "bleeding")
            {
              while (skills.hasSkill("effects.bleeding")) {skills.removeByID("effects.bleeding");}
              continue;
            }
            skills.removeByID("effects." + effect);
          }
          foreach(item in actor.getItems().getAllItems())
          {
            if (item.getCondition() < item.getConditionMax()) item.setCondition(item.getConditionMax());
            if (item.isItemType(this.Const.Items.ItemType.Ammo) && item.getAmmo() < item.getAmmoMax())
              item.setAmmo(item.getAmmoMax());
					}
          this.Tactical.TurnSequenceBar.updateEntity(actor.getID());
        }
      }
      return;

    case 20: //J for JUMP
      local tile = this.m.LastTileHovered;
      if (tile != null && tile.IsEmpty)
      {
        local entity = this.Tactical.TurnSequenceBar.getActiveEntity();
        this.Tactical.getNavigator().teleport(entity, tile, null, null, false, 0.0);
      }
      return;

    case 21: //K for KILL
      if (this.m.LastTileHovered != null && !this.m.LastTileHovered.IsEmpty)
      {
        local entity = this.m.LastTileHovered.getEntity();
        if (entity != null && this.isKindOf(entity, "actor"))
        {
          if (entity == this.Tactical.TurnSequenceBar.getActiveEntity()) {this.cancelEntityPath(entity);}
          entity.kill();
        }
      }
      return;

    case 22: //L for LEAVE
      //this.Tactical.Entities.makeAllHostilesRetreat();
      this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyRetreated);
      this.Tactical.Entities.checkCombatFinished(true);
      return;

    case 23: //M for MONSTER
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
			{
        local actor = gt.tnf_debug.getRandomActor("M");
        local script = this.Const.World.Spawn.Troops[actor[1]].Script;
				local entity = this.Tactical.spawnEntity(script);
				entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
				entity.assignRandomEquipment();
			}
      return;

    case 24: //N for NAMED CHAMPION
      local actors = gt.Const.World.Spawn.Troops;
      local champions = [];
      foreach (actor, properties in actors) {if (properties.Variant > 0) champions.push([actor, properties]);}
      local champion = champions[this.Math.rand(0, champions.len() - 1)];
      local name = gt.Const.World.Common.generateName(champion[1].NameList);
      name += champion[1].TitleList != null ? " " + champion[1].TitleList[this.Math.rand(0, champion[1].TitleList.len() - 1)] : "";
      local entity = this.Tactical.spawnEntity(champion[1].Script);
      local faction = gt.tnf_debug.getActorFaction(champion[0]);
      (faction == "Settlement" || faction == "NobleHouse") ? entity.setFaction(this.Const.Faction.Enemy): entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType[faction]).getID());
      entity.setName(name);
      entity.makeMiniboss();
      entity.assignRandomEquipment();
      return;

    case 25: //O for OBLITERATE
      local factions = this.Tactical.Entities.m.Instances;
      for (local f = this.Const.Faction.Player + 1; f != factions.len(); f++)
      {
      	if (factions[f].len() != 0 && !this.World.FactionManager.isAlliedWithPlayer(f))
      	{
      		local instances = clone factions[f];
      		foreach (e in instances) {e.kill();}
      	}
      }
      return;

    case 26: //P for PRIMITIVES & PIRATES
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
			{
        local faction = this.Math.rand(0, 1) ? "Barbarians" : "Bandits";
        local actor = gt.tnf_debug.getRandomActor(faction);
        local script = this.Const.World.Spawn.Troops[actor[1]].Script;
				local entity = this.Tactical.spawnEntity(script);
				entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType[faction]).getID());
				entity.assignRandomEquipment();
			}
      return;

    case 28: //R (Mass Pass Turn)
    case 29: //S (Movement)

    case 31: //U for UNDEAD
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
			{
        local faction = this.Math.rand(0, 1) ? "Undead" : "Zombies";
        local actor = gt.tnf_debug.getRandomActor(faction);
        local script = this.Const.World.Spawn.Troops[actor[1]].Script;
				local entity = this.Tactical.spawnEntity(script);
				entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType[faction]).getID());
				entity.assignRandomEquipment();
			}
      return;

    case 32: //V for VETERANS
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
			{
        local faction = this.Math.rand(0, 1) ? "Settlement" : "NobleHouse";
        local actor = gt.tnf_debug.getRandomActor(faction);
        local script = this.Const.World.Spawn.Troops[actor[1]].Script;
				local entity = this.Tactical.spawnEntity(script);
				//entity.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType[faction]).getID());
				entity.setFaction(this.Const.Faction.Enemy);
				entity.assignRandomEquipment();
			}
      return;

    case 34: //X for CROSSBOW
      if (this.m.LastTileHovered != null && this.m.LastTileHovered.IsEmpty)
      {
        local e = this.Tactical.spawnEntity("scripts/entity/tactical/player");
        this.World.getGuestRoster().add(e);
        e.setFaction(this.Const.Faction.Player);
        e.setScenarioValues();
        e.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
        e.assignRandomRangedEquipment();
      }
      return;

    case 35: //Y
  }
}
});

/******************************

*************
*    KEYS   *
*************

1 > 0 = 1 > 10
A > Z = 11 > 36

backspace = 37
tab = 38
enter = 39
space = 40
escape = 41
page down/up = 46/47
left, up, right, down arrows = 48 > 51
del = 54

F1 > F12 = 71 > 82

shift = 96 as modifier = 1
ctrl = 95 as modifier = 2
alt = 97 as modifier = 4
alt gr = 95 + 97 as modifier = 6

******************************/