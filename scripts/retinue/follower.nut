this.follower <- {
	m = {
		ID = "",
		Name = "",
		Description = "",
		Effects = [],
		Requirements = [],
		Image = "",
		Cost = 0,
		RequiredSkills = [],
		LinkedBro = null,
		WasOwned = false
	},
	function getID()
	{
		return this.m.ID;
	}

	function getOrder()
	{
		return this.m.Order;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getImage()
	{
		return this.m.Image;
	}

	function getEffects()
	{
		return this.m.Effects;
	}

	function getLinkedBro()
	{
		return this.m.LinkedBro;
	}

	function setOwned()
	{
		this.m.WasOwned = true;
	}

	function getCost()
	{
		return this.m.WasOwned ? 0 : this.m.Cost;
	}

	function getRequirements()
	{
		return this.m.Requirements;
	}

	function getRequirementsForUI()
	{
		local ret = [];

		foreach (r in this.m.Requirements)
		{
			ret.push(this.cloneValue(r));
		}

		ret.sort(this.sortByPriority);
		return ret;
	}

	function isValid()
	{
		return true;
	}

	function isVisible()
	{
		return true;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 4,
				type = "description",
				text = this.getDescription()
			}
		];

		foreach( i, e in this.m.Effects )
		{
			ret.push({
				id = i,
				type = "text",
				icon = "ui/icons/special.png",
				text = e
			});
		}

		ret.push({
			id = 1,
			type = "hint",
			icon = "ui/icons/mouse_left_button.png",
			text = "Open Hiring Screen to replace"
		});
		return ret;
	}

	function create()
	{
	}

	function update()
	{
		this.onUpdate();
	}

	function resetLinkedBro()
	{
		this.m.LinkedBro = null;
	}

	function evaluate()
	{
		for( local i = 0; i < this.m.Requirements.len(); i = ++i )
		{
			this.m.Requirements[i].IsSatisfied = false;
		}

		this.onEvaluate();
	}

	function onEvaluate()
	{
		foreach (r in this.m.Requirements)
		{
			r.IsSatisfied = r.CheckRequirement();

			if ("UpdateText" in r) r.UpdateText();
		}
	}

	function isUnlocked()
	{
		local hasSecondary = false;
		local isSecondaryFulfilled = false;

		foreach (r in this.m.Requirements)
		{
			if (r.NotImportant)
			{
				hasSecondary = true;

				if (isSecondaryFulfilled || !r.IsSatisfied) continue;
			
				isSecondaryFulfilled = true;
				continue;
			}

			// primary requirement (must fulfill this)
			if (!r.IsSatisfied) return false;
		}

		if (hasSecondary) return isSecondaryFulfilled;

		return true;
	}

	function isEnabled()
	{
		local hasSecondary = false;
		local isSecondaryFulfilled = false;

		foreach (r in this.m.Requirements)
		{
			// secondary requirement (only need to fulfill one among all secondary requirements)
			if (r.NotImportant)
			{
				hasSecondary = true;

				if (isSecondaryFulfilled || !r.CheckRequirement()) continue;
			
				isSecondaryFulfilled = true;
				continue;
			}

			// primary requirement (must fulfill this)
			if (!r.CheckRequirement()) return false;
		}

		if (hasSecondary) return isSecondaryFulfilled;

		return true;
	}

	function addRequirement( _text, _function, _isNotImportant = false, _afterAddRequirementFunction = null)
	{
		local requirement = {};
		requirement.Text <- _text;
		requirement.IsSatisfied <- false;
		requirement.CheckRequirement <- _function.bindenv(this);
		requirement.NotImportant <- _isNotImportant;

		this.m.Requirements.push(requirement);

		if (typeof _afterAddRequirementFunction == "function") _afterAddRequirementFunction.call(this, requirement);
	}

	function addSkillRequirement( _text, _requiredSkills, _isNotImportant = false, _afterAddRequirementFunction = null )
	{
		this.m.RequiredSkills = _requiredSkills;
		this.addRequirement(_text, this.checkRequiredSkills, _isNotImportant, _afterAddRequirementFunction);
	}

	function checkRequiredSkills()
	{
		if (this.m.RequiredSkills.len() == 0)
		{
			return true;
		}

		local isCorrectSkill = function( _skill )
		{
			if (this.m.RequiredSkills.find(_skill.getID()) != null) return true;

			return false;
		}

		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getSkills().getSkillsByFunction(isCorrectSkill.bindenv(this)).len() != 0)
			{
				this.m.LinkedBro = bro;
				break;
			}
		}

		return this.m.LinkedBro != null && this.m.LinkedBro.isAlive();
	}

	function clear()
	{
	}

	function onUpdate()
	{
	}

	function onNewDay()
	{
	}

	function onSerialize( _out )
	{
	}

	function onDeserialize( _in )
	{
	}

	// clone the value for the ui, the return table should not contain any function
	function cloneValue( _r )
	{
		local ret = clone _r;
		local garbage = [];

		// collect stuffs
		foreach(k, v in ret)
		{
			if (typeof v != "function") continue;

			garbage.push(k);
		}

		// dump stuffs
		foreach(k in garbage)
		{
			ret.rawdelete(k);
		}

	    return ret;
	}

	function sortByPriority( _a, _b )
	{
		if (!_a.NotImportant && _b.NotImportant)
		{
			return -1;
		}
		else if (_a.NotImportant && !_b.NotImportant)
		{
			return 1;
		}

		return 0;
	}

};

