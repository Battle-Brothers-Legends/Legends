local gt = this.getroottable();

if (!("LegendMod" in gt.Const))
{
	gt.Const.LegendMod <- {};
}

gt.Const.LegendMod.FavoriteZombies <- [
	this.Const.EntityType.ZombieYeoman,
	this.Const.EntityType.Zombie,
	this.Const.EntityType.ZombieBetrayer,
	this.Const.EntityType.ZombieBoss,
	this.Const.EntityType.ZombieKnight,
	this.Const.EntityType.Necromancer,
	this.Const.EntityType.ZombieTreasureHunter,
];

gt.Const.LegendMod.FavoriteAlps <- [
	this.Const.EntityType.Alp,
	this.Const.EntityType.AlpShadow,
	this.Const.EntityType.LegendDemonAlp
];

gt.Const.LegendMod.FavoriteDirewolf <- [
	this.Const.EntityType.Direwolf,
	this.Const.EntityType.Wolf,
	this.Const.EntityType.GoblinWolfrider,
	this.Const.EntityType.LegendWhiteDirewolf
];

gt.Const.LegendMod.FavoriteGhoul <- [
	this.Const.EntityType.Ghoul,
	this.Const.EntityType.LegendSkinGhoul
];

gt.Const.LegendMod.FavoriteGoblin <- [
	this.Const.EntityType.GoblinFighter,
	this.Const.EntityType.GoblinAmbusher,
	this.Const.EntityType.GoblinLeader,
	this.Const.EntityType.GoblinShaman,
	this.Const.EntityType.GoblinWolfrider
];

gt.Const.LegendMod.FavoriteHexe <- [
	this.Const.EntityType.Hexe,
	this.Const.EntityType.LegendHexeLeader
];

gt.Const.LegendMod.FavoriteLindwurm <- [
	this.Const.EntityType.Lindwurm,
	this.Const.EntityType.LegendStollwurm
];

gt.Const.LegendMod.FavoriteOrc <- [
	this.Const.EntityType.OrcBerserker,
	this.Const.EntityType.OrcYoung,
	this.Const.EntityType.OrcWarrior,
	this.Const.EntityType.OrcWarlord,
	this.Const.EntityType.LegendOrcBehemoth,
	this.Const.EntityType.LegendOrcElite
];

gt.Const.LegendMod.FavoriteSchrat <- [
	this.Const.EntityType.Schrat,
	this.Const.EntityType.SchratSmall,
	this.Const.EntityType.LegendGreenwoodSchrat,
	this.Const.EntityType.LegendGreenwoodSchratSmall,
];

gt.Const.LegendMod.FavoriteSkeleton <- [
	this.Const.EntityType.SkeletonLight,
	this.Const.EntityType.SkeletonMedium,
	this.Const.EntityType.SkeletonHeavy,
	this.Const.EntityType.SkeletonBoss,
	this.Const.EntityType.SkeletonPriest,
	this.Const.EntityType.SkeletonLich,
	this.Const.EntityType.SkeletonLichMirrorImage,
	this.Const.EntityType.SkeletonPhylactery,
	this.Const.EntityType.SkeletonGladiator	];

gt.Const.LegendMod.FavoriteSpider <- [
	this.Const.EntityType.Spider,
	this.Const.EntityType.SpiderEggs,
	this.Const.EntityType.LegendRedbackSpider
];

gt.Const.LegendMod.FavoriteUnhold <- [
	this.Const.EntityType.Unhold,
	this.Const.EntityType.UnholdBog,
	this.Const.EntityType.UnholdFrost,
	this.Const.EntityType.BarbarianUnhold,
	this.Const.EntityType.BarbarianUnholdFrost,
	this.Const.EntityType.LegendRockUnhold
];

gt.Const.LegendMod.FavoriteVampire <- [
	this.Const.EntityType.Vampire,
	this.Const.EntityType.Ghost,
	this.Const.EntityType.LegendVampireLord,
	this.Const.EntityType.LegendBanshee
];

gt.Const.LegendMod.FavoriteSwordmaster <- [
	this.Const.EntityType.HedgeKnight,
	this.Const.EntityType.Knight,
	this.Const.EntityType.Greatsword,
	this.Const.EntityType.Swordmaster,
	this.Const.EntityType.BanditLeader,
	this.Const.EntityType.BanditVeteran,
	this.Const.EntityType.BanditWarlord,
	this.Const.EntityType.LegendFencer,
	this.Const.EntityType.BarbarianChampion,
	this.Const.EntityType.Sergeant,
	this.Const.EntityType.Officer,
	this.Const.EntityType.Gladiator,
	this.Const.EntityType.Assassin,
	this.Const.EntityType.NomadLeader,
    this.Const.EntityType.Executioner,
	this.Const.EntityType.DesertDevil
];

gt.Const.LegendMod.FavoriteArcher <- [
	this.Const.EntityType.MasterArcher,
	this.Const.EntityType.BanditMarksman,
	this.Const.EntityType.BanditRabblePoacher,
	this.Const.EntityType.BanditPoacher,
	this.Const.EntityType.MilitiaRanged,
	this.Const.EntityType.Arbalester,
	this.Const.EntityType.LegendSlinger,
	this.Const.EntityType.GoblinAmbusher,
	this.Const.EntityType.NomadSlinger,
	this.Const.EntityType.NomadArcher,
	this.Const.EntityType.Gunner,
	this.Const.EntityType.DesertStalker,
];

gt.Const.LegendMod.FavoriteBarbarian <- [
	this.Const.EntityType.Warhound,
	this.Const.EntityType.BarbarianThrall,
	this.Const.EntityType.BarbarianMarauder,
	this.Const.EntityType.BarbarianChampion,
	this.Const.EntityType.BarbarianChosen,
	this.Const.EntityType.BarbarianDrummer,
	this.Const.EntityType.BarbarianBeastmaster
];

gt.Const.LegendMod.FavoriteBandit <- [
	this.Const.EntityType.BanditRabble,
	this.Const.EntityType.BanditRabblePoacher,
	this.Const.EntityType.BanditThug,
	this.Const.EntityType.BanditPoacher,
	this.Const.EntityType.BanditMarksman,
	this.Const.EntityType.BanditRaider,
	this.Const.EntityType.BanditVeteran,
	this.Const.EntityType.BanditWarlord,
	this.Const.EntityType.BanditLeader
];

gt.Const.LegendMod.FavoriteCaravan <- [
	this.Const.EntityType.Peasant,
	this.Const.EntityType.LegendPeasantButcher,
	this.Const.EntityType.LegendPeasantBlacksmith,
	this.Const.EntityType.LegendPeasantMonk,
	this.Const.EntityType.LegendPeasantFarmhand,
	this.Const.EntityType.LegendPeasantMinstrel,
	this.Const.EntityType.LegendPeasantPoacher,
	this.Const.EntityType.LegendPeasantMiner,
	this.Const.EntityType.LegendPeasantSquire,
	this.Const.EntityType.LegendPeasantWitchHunter,
	this.Const.EntityType.CaravanHand,
	this.Const.EntityType.CaravanGuard,
	this.Const.EntityType.Militia,
	this.Const.EntityType.MilitiaVeteran,
	this.Const.EntityType.MilitiaCaptain,
	this.Const.EntityType.MilitiaRanged,
	this.Const.EntityType.Slave,
	this.Const.EntityType.Engineer,
	this.Const.EntityType.PeasantSouthern
];


gt.Const.LegendMod.FavoriteNoble <- [
	this.Const.EntityType.Footman,
	this.Const.EntityType.Greatsword,
	this.Const.EntityType.Billman,
	this.Const.EntityType.Arbalester,
	this.Const.EntityType.StandardBearer,
	this.Const.EntityType.Sergeant,
	this.Const.EntityType.LegendFencer,
	this.Const.EntityType.LegendHalberdier,
	this.Const.EntityType.LegendSlinger,
	this.Const.EntityType.Knight
];

gt.Const.LegendMod.FavoriteMercenary <- [
	this.Const.EntityType.Wardog,
	this.Const.EntityType.ArmoredWardog,
	this.Const.EntityType.Mercenary,
	this.Const.EntityType.MercenaryRanged,
	this.Const.EntityType.BountyHunter,
	this.Const.EntityType.Swordmaster,
	this.Const.EntityType.HedgeKnight,
	this.Const.EntityType.MasterArcher	
];

gt.Const.LegendMod.FavoriteSoutherners <- [
	this.Const.EntityType.Conscript,
	this.Const.EntityType.Gunner,
	this.Const.EntityType.Officer,
	this.Const.EntityType.Engineer,
	this.Const.EntityType.Assassin,
	this.Const.EntityType.Slave,
	this.Const.EntityType.Gladiator,
	this.Const.EntityType.NomadCutthroat,
	this.Const.EntityType.NomadOutlaw,
	this.Const.EntityType.NomadSlinger,
	this.Const.EntityType.NomadArcher,
	this.Const.EntityType.NomadLeader,
	this.Const.EntityType.DesertStalker,
	this.Const.EntityType.Executioner,
	this.Const.EntityType.DesertDevil,
	this.Const.EntityType.PeasantSouthern,
];

gt.Const.LegendMod.GetFavoriteEnemyValue <- function ( _type )
{
	switch(_type)
	{
		case "this.Const.EntityType.Lindwurm":
		value = 1;
		break;
		case "this.Const.EntityType.LegendStollwurm":
		value = 0.3;
		break;
		case "this.Const.EntityType.Alp":
		value = 3;
		break;
		case "this.Const.EntityType.LegendDemonAlp":
		value = 0.3;
		break;
		case "this.Const.EntityType.LegendGreenwoodSchrat":
		value = 0.3;
		break;
		case "this.Const.EntityType.LegendGreenwoodSchratSmall":
		value = 5;
		break;
		case "this.Const.EntityType.Schrat":
		value = 1;
		break;
		case "this.Const.EntityType.LegendRockUnhold":
		value = 0.5;
		break;
		case "this.Const.EntityType.Unhold":
		value = 2;
		break;
		case "this.Const.EntityType.UnholdBog":
		value = 2;
		break;
		case "this.Const.EntityType.UnholdFrost":
		value = 2;
		break;
		case "this.Const.EntityType.Hexe":
		value = 2;
		break;
		case "this.Const.EntityType.LegendHexeLeader":
		value = 0.5;
		break;
		case "this.Const.EntityType.Spider":
		value = 8;
		break;
		case "this.Const.EntityType.SpiderBodyguard":
		value = 8;
		break;
		case "this.Const.EntityType.LegendRedbackSpider":
		value = 1;
		break;
		case "this.Const.EntityType.Ghoul":
		value = 6;
		break;
		case "this.Const.EntityType.LegendSkinGhoul":
		value = 2;
		break;
		case "this.Const.EntityType.Direwolf":
		value = 6;
		break;
		case "this.Const.EntityType.LegendWhiteDirewolf":
		value = 0.5;
		break;
		case "this.Const.EntityType.Vampire":
		value = 2;
		break;
		case "this.Const.EntityType.LegendVampireLord":
		value = 1;
		break;
		case "this.Const.EntityType.SkeletonPriest":
		value = 2;
		break;
		case "this.Const.EntityType.SkeletonHeavy":
		value = 3;
		break;
		case "this.Const.EntityType.SkeletonMedium":
		value = 5;
		break;
		case "this.Const.EntityType.SkeletonLight":
		value = 7;
		break;
		case "this.Const.EntityType.Ghost":
		value = 4;
		break;
		case "this.Const.EntityType.LegendBanshee":
		value = 3;
		break;
		case "this.Const.EntityType.ZombieBoss":
		value = 1;
		break;
		case "this.Const.EntityType.ZombieBetrayer":
		value = 4;
		break;
		case "this.Const.EntityType.ZombieKnight":
		value = 5;
		break;
		case "this.Const.EntityType.ZombieYeoman":
		value = 10;
		break;
		case "this.Const.EntityType.Zombie":
		value = 20;
		break;
		case "this.Const.EntityType.Necromancer":
		value = 3;
		break;
		case "this.Const.EntityType.GoblinWolfrider":
		value = 5;
		break;
		case "this.Const.EntityType.GoblinShaman":
		value = 3;
		break;
		case "this.Const.EntityType.GoblinLeader":
		value = 3;
		break;
		case "this.Const.EntityType.GoblinFighter":
		value = 6;
		break;
		case "this.Const.EntityType.GoblinAmbusher":
		value = 5;
		break;
		case "this.Const.EntityType.OrcYoung":
		value = 6;
		break;
		case "this.Const.EntityType.OrcBerserker":
		value = 4;
		break;
		case "this.Const.EntityType.OrcElite":
		value = 2;
		break;
		case "this.Const.EntityType.OrcWarlord":
		value = 2;
		break;
		case "this.Const.EntityType.OrcBehemoth":
		value = 2;
		break;
		case "this.Const.EntityType.OrcWarrior":
		value = 3;
		break;
		case "this.Const.EntityType.Militia":
		value = 10;
		break;
		case "this.Const.EntityType.MilitiaArcher":
		value = 8;
		break;
		case "this.Const.EntityType.MilitiaCaptain":
		value = 5;
		break;
		case "this.Const.EntityType.MilitiaVeteran":
		value = 7;
		break;
		case "this.Const.EntityType.BountyHunter":
		value = 5;
		break;
		case "this.Const.EntityType.Peasant":
		value = 25;
		break;
		case "this.Const.EntityType.CaravanHand":
		value = 10;
		break;
		case "this.Const.EntityType.CaravanGaurd":
		value = 7;
		break;
		case "this.Const.EntityType.Wardog":
		value = 12;
		break;
		case "this.Const.EntityType.Mercenary":
		value = 4;
		break;
		case "this.Const.EntityType.HedgeKnight":
		value = 2;
		break;
		case "this.Const.EntityType.MasterArcher":
		value = 2;
		break;
		case "this.Const.EntityType.Footman":
		value = 5;
		break;
		case "this.Const.EntityType.Greatsword":
		value = 4;
		break;
		case "this.Const.EntityType.Swordmaster":
		value = 2;
		break;
		case "this.Const.EntityType.Billman":
		value = 5;
		break;
		case "this.Const.EntityType.Arbalester":
		value = 5;
		break;
		case "this.Const.EntityType.StandardBearer":
		value = 4;
		break;
		case "this.Const.EntityType.Sergeant":
		value = 3;
		break;
		case "this.Const.EntityType.Knight":
		value = 2;
		break;
		case "this.Const.EntityType.BanditRabble":
		value = 30;
		case "this.Const.EntityType.BanditRabblePoacher":
		value = 30;
		break;
		case "this.Const.EntityType.BanditThug":
		value = 15;
		break;
		case "this.Const.EntityType.BanditPoacher":
		value = 12;
		break;
		case "this.Const.EntityType.BanditMarksman":
		value = 7;
		break;
		case "this.Const.EntityType.BanditRaider":
		value = 5;
		break;
		case "this.Const.EntityType.BanditLeader":
		value = 3;
		break;
		case "this.Const.EntityType.Warhound":
		value = 10;
		break;
		case "this.Const.EntityType.BarbarianThrall":
		value = 8;
		break;
		case "this.Const.EntityType.BarbarianMarauder":
		value = 4;
		break;
		case "this.Const.EntityType.BarbarianChampion":
		value = 3;
		break;
		case "this.Const.EntityType.BarbarianChosen":
		value = 2;
		break;
		case "this.Const.EntityType.BarbarianDrummer":
		value = 3;
		break;
		case "this.Const.EntityType.BarbarianUnhold":
		value = 2;
		break;
		case "this.Const.EntityType.BarbarianUnholdFrost":
		value = 2;
		break;
		case "this.Const.EntityType.BarbarianBeastmaster":
		value = 5;
		break;
		case "this.Const.EntityType.BarbarianMadman":
		value = 1;
		break;
		case "this.Const.EntityType.Conscript":
		value = 5;
		break;
		case "this.Const.EntityType.Gunner":
		value = 5;
		break;
		case "this.Const.EntityType.Officer":
		value = 3;
		break;
		case "this.Const.EntityType.Engineer":
		value = 15;
		break;
		case "this.Const.EntityType.Assassin":
		value = 3;
		break;
		case "this.Const.EntityType.Slave":
		value = 30;
		break;
		case "this.Const.EntityType.Gladiator":
		value = 3;
		break;
		case "this.Const.EntityType.NomadCutthroat":
		value = 15;
		break;
		case "this.Const.EntityType.NomadOutlaw":
		value = 5;
		break;
		case "this.Const.EntityType.NomadSlinger":
		value = 12;
		break;
		case "this.Const.EntityType.NomadArcher":
		value = 7;
		break;
		case "this.Const.EntityType.NomadLeader":
		value = 3;
		break;
		case "this.Const.EntityType.DesertStalker":
		value = 2;
		break;
		case "this.Const.EntityType.Executioner":
		value = 2;
		break;
		case "this.Const.EntityType.DesertDevil":
		value = 2;
		break;
		case "this.Const.EntityType.PeasantSouthern":
		value = 25;
		break;
		case "this.Const.EntityType.SkeletonLich":
		value = 0.3;
		break;
		case "this.Const.EntityType.SkeletonLichMirrorImage":
		value = 0.5;
		break;
		case "this.Const.EntityType.SkeletonPhylactery":
		value = 5;
		break;
		case "this.Const.EntityType.ZombieTreasureHunter":
		value = 2;
		break;		
		default:
		value = 10;
	}

	return value
}

gt.Const.LegendMod.SetFavoriteEnemyKill <- function ( _actor, _target )
{
	local favKey = "Enemy" + _target.getType();
	_actor.getLifetimeStats().Tags.increment(favKey, 1);
}

gt.Const.LegendMod.GetFavoriteEnemyStats <- function ( _actor, _types )
{
	if (_actor == null)
	{
		{
			Kills = 0,
			Strength = 0,
			HitChance = 0,
			HitMult = 0
		}
	}

	local kills = 0;
	local str = 0;
	foreach (t in _types)
	{
		local mKills = 0;
		local favKey = "Enemy" + t;
		mKills = _actor.getLifetimeStats().Tags.get(favKey)
		if (mKills && mKills > 0)
		{
			kills += mKills;
			local troop = this.Const.World.Spawn.TroopsMap[t];
			str += (mKills * troop.Strength);
		}
	}
	local hitChance = this.Math.floor(this.Math.pow(0.3 * str, 0.5));
	local hitMult = 1.0 + ((hitChance * 1.0) / 100.0);
	return {
		Kills = kills,
		Strength = str,
		HitChance = hitChance,
		HitMult = hitMult
	}
}

gt.Const.LegendMod.FavEnemyPerkMap <- {
	Enemy1 = []

	function getPerks( _id)
	{
		local key = "Enemy" + _id;
		if (!(key in this))
		{
			return [];
		}
		return this[key];
	}

	function addPerk( _key, _perk)
	{
		local p = this[_key];
		foreach (perk in p)
		{
			if (_perk == perk)
			{
				return;
			}
		}
		p.push(_perk);
	}

	function addEnemies( _enemies, _perk)
	{
		foreach (_e in _enemies)
		{
			local key = "Enemy" + _e;
			if (!(key in this))
			{
				this[key] <- [];
			}
			this.addPerk(key, _perk);
		}

	}
}

gt.Const.LegendMod.GetFavEnemyBossChance <- function (_id)
{
	if (!this.Const.DLC.Wildmen)
	{
		return 0;
	}

	local perks = this.Const.LegendMod.FavEnemyPerkMap.getPerks(_id)
	if( perks.len() == 0)
	{
		return 0;
	}

	local bonus = 0;
	local roster = this.World.getPlayerRoster().getAll();
	foreach (bro in roster)
	{
		foreach (perk in perks)
		{
			if (!bro.getSkills().hasSkill(perk))
			{
				continue
			}

			local P = bro.getSkills().getSkillByID(perk)

			local stats = this.Const.LegendMod.GetFavoriteEnemyStats(bro, P.m.ValidTypes);
			bonus += this.Math.floor((stats.Kills * 1.0) / 10.0)
			break;
		}
	}
	return bonus;
}

