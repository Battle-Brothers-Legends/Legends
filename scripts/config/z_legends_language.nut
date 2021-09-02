local gt = this.getroottable();

gt.Const.LegendMod.Pronouns <- [
	"They",
	"they",
	"Them",
	"them",
	"Their",
	"their",
	"Theirs",
	"theirs",
	"Themselves",
	"themselves",
	"Person",
	"person",
	"People",
	"people",
	"swordsman",
	"Swordsman",
	"noble",
	"Noble",
];

gt.Const.LegendMod.PronounTable <- {
	they = ["they", "he", "she"],
	them = ["them", "him", "her"],
	their = ["their", "his", "her"],
	theirs = ["theirs", "his", "hers"],
	themselves = ["themselves", "himself", "herself"],
	person = ["person", "man", "woman"],
	people = ["people", "men", "women"],
	swordsman = ["swordsman", "swordsman", "swordwoman"],
	noble = ["noble", "nobleman", "noblewoman"]
}

// _gender = -1 for neuter, 0 for male, 1 for female
gt.Const.LegendMod.getPronoun <- function( _gender, _neuter )
{
	local capitalized = _neuter[0] < 96;
	if (capitalized) _neuter = _neuter.tolower();
	local pronoun = this.Const.LegendMod.PronounTable[_neuter][_gender + 1];

	if (capitalized)
	{
		local first = pronoun.slice(0, 1);
		first = first.toupper();
		local second = pronoun.slice(1);
		pronoun = first + second;
	}
	return pronoun;
}

gt.Const.LegendMod.extendVarsWithPronouns <- function( _vars, _gender )
{
	foreach (pronoun in this.Const.LegendMod.Pronouns)
	{
		_vars.push([
			pronoun,
			this.Const.LegendMod.getPronoun(_gender, pronoun)
		]);
	}
}