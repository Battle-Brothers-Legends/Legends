::Const.Perks.PerkGroup <- {};
::Const.Perks.PerkGroup.LookupMap <- {};
::Const.Perks.PerkGroup.findById( _id )
{
	if (_id in this.LookupMap) return this.LookupMap[_id];
	return null;
}

::Const.Perks.SpecialPerks <- {};
::Const.Perks.SpecialPerks.LookupMap <- {};
::Const.Perks.SpecialPerks.findById( _id )
{
	if (_id in this.LookupMap) return this.LookupMap[_id];
	return null;
}

::Const.Perks.DefaultDynamicPerkTree <- {
	Weapon = [
		::Const.Perks.SwordTree,
		::Const.Perks.DaggerTree,
		::Const.Perks.PolearmTree
	],
	Defense = [::Const.Perks.MediumArmorTree],
	Traits = [
		::Const.Perks.FitTree,
		::Const.Perks.IntelligentTree,
		::Const.Perks.AgileTree,
		::Const.Perks.FastTree
	],
	Enemy = [],
	Class = [],
	Magic = []
};

::Const.Perks.DefaultStaticPerkTree <- array(::Const.Perks.Perks.len());
::Const.Perks.PerkDefs <- [];

foreach (i, row in ::Const.Perks.Perks)
{
	::Const.Perks.DefaultStaticPerkTree[i] = array(row.len());
	foreach (j, perkDef in row)
	{
		::Const.Perks.DefaultStaticPerkTree[i][j] = perkDef.ID;
		::Const.Perks.PerkDefs.push(perkDef);
	}
}

::Const.Perks.PerkGroup < {};
::Const.Perks.PerkGroup.ButcherProfession <- ::new("scripts/config/legends/perks/perk_group").init(
	"perk_group.butcher_profession",
	"Butcher",
	[
		"worked at a butcher\'s shop",
		"butchered animals and sold meat to make a livelihood",
		"claims to be well-experienced in butchering animals"
	],
	[
		[
			"perk.legend_specialist_butcher_skill"
		],
		[],
		[
			"perk.legend_specialist_butcher_damage"
		],
		[],
		[
			"perk.legend_prepare_bleed"
		],
		[
			"perk.legend_prepare_graze"
		],
		[
			"perk.legend_slaughter"
		]
	],
	1.0,
	[
		[3, ::Const.Perks.PerkGroup.Vicious],
		[2, ::Const.Perks.PerkGroup.Organized],
		[5, ::Const.Perks.PerkGroup.ChefClass],
		[-1, ::Const.Perks.PerkGroup.OneHandedStyles],
		[-1, ::Const.Perks.PerkGroup.Cleaver],
		[2, ::Const.Perks.PerkGroup.Sword],
		[3, ::Const.Perks.PerkGroup.Axe]
	]
);

gt.Const.Perks.ButcherProfessionTree <- {
	ID = "ButcherProfessionTree",
	Descriptions = [
		"worked at a butcher\'s shop",
		"butchered animals and sold meat to make a livelihood",
		"claims to be well-experienced in butchering animals"
	],
	Name = "Butcher",
	PerkGroupMultipliers = [
		[3, ::Const.Perks.ViciousTree],
		[2, ::Const.Perks.OrganisedTree],
		[5, ::Const.Perks.ChefClassTree],
		[-1, ::Const.Perks.OneHandedTree],
		[-1, ::Const.Perks.CleaverTree],
		[2, ::Const.Perks.SwordTree],
		[3, ::Const.Perks.AxeTree]
	],
	Tree = [
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistButcherSkill
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendSpecialistButcherDamage
		],
		[],
		[
			gt.Const.Perks.PerkDefs.LegendPrepareBleed
		],
		[
			gt.Const.Perks.PerkDefs.LegendPrepareGraze
		],
		[
			gt.Const.Perks.PerkDefs.LegendSlaughter
		]
	]
};

::Const.Perks.OrderOfAssignment <- ["Profession", "Enemy", "Traits", "Class", "Defense", "Weapon", "Styles"];

::Const.Perks.addPerkDefObjects <- function( _perkDefObjects )
{
	local i = gt.Const.Perks.PerkDefs.len();

	::Const.Perks.PerkDefs.extend(_perkDefObjects);

	foreach (perkDefObject in _perkDefObjects)
	{
		::Const.Perks.LookupMap[perkDefObject.ID] <- perkDefObject;
		i++;
	}
}

::Const.Perks.updatePerkGroupTooltips <- function( _perkID = null, _groups = null )
{
	local map = {};

	foreach (group in ::Const.Perks)
	{
		if (::MSU.isKindOf("perk_group", group))
		{
			foreach (row in group.getTree())
			{
				foreach (perkID in row)
				{
					if (_perkID == null || perkID == _perkID)
					{
						if (!(perkID in map))
						{
							map[perkID] <- [];
						}
						map[perkID].push(group.getName());
					}
				}
			}
		}
	}

	foreach (perkID, groups in map)
	{
		groups = _groups == null ? groups : _groups;

		local desc = ::Const.Perks.findById(perkID).Tooltip;
		local pre = "[color=#0b0084]From the ";
		local mid = "";
		local ap = "perk group[/color]";

		if (groups.len() == 1)
		{
			mid += groups[0] + " ";
		}
		else
		{
			for (local i = 0; i < groups.len() - 2; i++)
			{
				 mid += groups[i] + ", ";
			}
			mid += groups[groups.len()-2] + " or ";
			mid += groups[groups.len()-1] + " ";
			ap = "perk groups[/color]";
		}

		if (desc.find(pre) == null)
		{
			local text = "\n\n" + pre + mid + ap;
			::Const.Perks.findById(perkID).Tooltip += text;
		}
		else
		{
			local strArray = split(desc, "[");

			strArray.pop();
			strArray.apply(@(a) a += "[" );

			strArray[strArray.len()-1] = "color=#0b0084]From the " + mid + ap;

			if (strArray[0].find("color=") != null)
			{
				strArray[0] = "[" + strArray[0];
			}

			local ret = "";
			foreach (s in strArray)
			{
				ret += s;
			}

			if (ret.find("\n\n" + pre) == null)
			{
				local prefix = ret.find("\n" + pre) == null ? "\n\n" : "\n";
				ret = this.MSU.String.replace(ret, pre, prefix + pre);
			}

			::Const.Perks.findById(perkID).Tooltip += text;
		}
	}
}
