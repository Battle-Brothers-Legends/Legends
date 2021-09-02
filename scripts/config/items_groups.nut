local gt = this.getroottable();

if (!("Items" in gt.Const))
{
	gt.Const.Items <- {};
}

gt.Const.Items.MusicalItems <- [
 	"weapon.lute",
	"weapon.named_lute",
	"weapon.barbarian_drum",
	"weapon.legend_drum"
];

gt.Const.Items.MusicalBannerItems <- [
 	"weapon.lute",
	"weapon.named_lute",
	"weapon.barbarian_drum",
	"weapon.legend_drum",
	"weapon.player_banner"
];