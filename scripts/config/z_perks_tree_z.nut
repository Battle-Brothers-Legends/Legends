local gt = this.getroottable();

local map = {};

foreach (name, group in gt.Const.Perks)
{
	if (!("Name" in group)) continue;
	for (local i = 0; i < group.Tree.len(); ++i) 
	{
		for (local j = 0; j < group.Tree[i].len(); ++j) 
		{
			//this.logInfo(name);
			local c = gt.Const.Perks.TempiToConst[group.Tree[i][j]];

			if (!(c in map)) map[c] <- {Groups = [], Const = group.Tree[i][j]};
			map[c].Groups.push(group.Name);
		}
	}
}

foreach (perk, table in map)
{
	local array = table.Groups;
	local pre = "\n[color=#0b0084]From the ";
	local ap = "perk group[/color]";
	local mid = "";
	if (array.len() == 1) mid += array[0] + " ";
	else
	{
		for (local i = 0; i < array.len() - 2; i++) mid += array[i] + ", ";
		mid += array[array.len()-2] + " or ";
		mid += array[array.len()-1] + " ";
	}
	gt.Const.Strings.PerkDescription[perk] += pre + mid + ap;
	gt.Const.Perks.PerkDefObjects[table.Const].Tooltip += pre + mid + ap;
}

delete gt.Const.Perks.TempiToConst;