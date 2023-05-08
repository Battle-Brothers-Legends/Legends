this.archery_contest_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.archery_contest";
		this.m.Name = "Archery Contest";
		this.m.Description = "A contest in archery has attracted anyone proficient with a bow. A good time, perhaps, to look for according recruits.";
		this.m.Icon = "ui/settlement_status/settlement_effect_31.png";
		this.m.Rumors = [
			"If you\'re a skilled archer, you might want to head to that big contest over in %settlement% and let fly some arrows!",
			"You know, I myself was once the best archer near and far, I swear! Until a damned donkey stepped on my hand, that is. Otherwise, I\'d be in %settlement% for the archery contest right now...",
			"Anyone skilled with a bow is making their way to %settlement% these days for some contest. Most of them poachers and other lowlifes, I imagine."
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
	}

	function getAddedString( _s )
	{
		return _s + " now has " + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + " no longer has " + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RecruitsMult *= 1.25;
	}


	function onUpdateDraftList( _draftList, _gender = null)
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");

		if (_gender)
		{
		_draftList.push("female_adventurous_noble_background");
		_draftList.push("female_adventurous_noble_background");
		_draftList.push("female_disowned_noble_background");

		}

		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");

		if (this.Const.DLC.Unhold)
		{
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
		}
	}

});

