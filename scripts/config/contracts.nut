local gt = this.getroottable();

if (!("Contracts" in gt.Const))
{
	gt.Const.Contracts <- {};
}

gt.Const.Contracts.Settings <- {
	NegotiationMaxAnnoyance = 9,
	NegotiationAnnoyanceGainMin = 1,
	NegotiationAnnoyanceGainMax = 3,
	NegotiationRefuseChance = 10,
	PaymentOnCompletionMult = 1.0,
	PaymentInAdvanceMult = 0.75,
	PaymentPerHeadMult = 0.05,
	IntroChance = 20
};

