this.intensive_training_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
	HitpointsAdded =0,
	StaminaAdded = 0,
	BraveAdded = 0,
	IniAdded = 0,
	MatkAdded = 0,
	RatkAdded = 0,
	MdefAdded = 0,
	RdefAdded = 0,
	TraitGained = "",
	BonusXP = 0.0,
	MaxSkillsCanBeAdded = 15
	},
	function create()
	{
		this.m.ID = "trait.intensive_training_trait";
		this.m.Name = "Training progress";
		this.m.Icon = "ui/traits/IntensiveTraining.png";
		this.m.Description = "This character can increase their abilities if you upgrade your camp training facilities.";
		this.m.Order = this.Const.SkillOrder.Background + 1;
		this.m.Type = this.Const.SkillType.Background | this.Const.SkillType.Trait;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = true;
	}

	function addRandomSkills( _bro, _skillsNum )
	{
		for( local i = 0; i < _skillsNum; i++ )
		{
			local attr = this.Math.rand(0, this.Const.Attributes.COUNT-1);

			switch(attr)
			{
			case 0:
				_bro.getBaseProperties().Hitpoints += 1;
				this.addHitpoint();
				break;

			case 1:
				_bro.getBaseProperties().Bravery += 1;
				this.addBrave();
				break;

			case 2:
				_bro.getBaseProperties().Stamina += 1;
				this.addStamina();
				break;

			case 3:
				_bro.getBaseProperties().Initiative += 1;
				this.addIni();
				break;

			case 4:
				if ( _bro.getBaseProperties().MeleeSkill > _bro.getBaseProperties().RangedSkill )
				{
					_bro.getBaseProperties().MeleeSkill += 1;
					this.addMatk();
				}else
				{
					_bro.getBaseProperties().RangedSkill += 1;
					this.addRatk();
				}
				break;

			case 5:
				_bro.getBaseProperties().MeleeDefense += 1;
				this.addMdef();
				break;

			default:
				_bro.getBaseProperties().RangedDefense += 1;
				this.addRdef();
				break;

			}
		}

		_bro.getSkills().update();
	}

	function getBonusXP()
	{
		return this.m.BonusXP;
	}

	function finishedTraining( _traitGained )
	{
		this.m.Description = "This character completed training and can't get any more skills from training. Training experience is slightly improved.";
		this.m.TraitGained = _traitGained;
		this.m.BonusXP = 0.05;
	}

	function addHitpoint()
	{
		this.m.HitpointsAdded++;
	}
	function addStamina()
	{
		this.m.StaminaAdded++;
	}
	function addBrave()
	{
		this.m.BraveAdded++;
	}
	function addIni()
	{
		this.m.IniAdded++;
	}
	function addMatk()
	{
		this.m.MatkAdded++;
	}
	function addRatk()
	{
		this.m.RatkAdded++;
	}
	function addMdef()
	{
		this.m.MdefAdded++;
	}
	function addRdef()
	{
		this.m.RdefAdded++;
	}

	function getDescription()
	{
		return this.m.Description;
	}

	function getStatsIncreased()
	{
		return this.m.HitpointsAdded + this.m.StaminaAdded + this.m.BraveAdded + this.m.IniAdded + this.m.MatkAdded + this.m.RatkAdded + this.m.MdefAdded + this.m.RdefAdded;
	}

	function isMaxReached()
	{
		return this.getStatsIncreased() >= this.m.MaxSkillsCanBeAdded;
	}

	function getMaxSkillsCanBeAdded()
	{
		return this.m.MaxSkillsCanBeAdded;
	}

	function successfullyTrained( _bro )
	{

	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
			tooltip.push({
				id = 6,
				type = "text",
				icon = "",
				text = ""
				});
//		this.logInfo(this.getContainer().getActor().getBackground().getNameOnly());

		if ( this.getContainer().getActor().getBackground().getNameOnly()=="Donkey" )
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Donkeys don't train"
			});
		}else
		if (getStatsIncreased() > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "",
				text = "Training results so far:"
				});

			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + getStatsIncreased() + "[/color] skill points"
				});

				if ( this.isMaxReached() )
				{
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + 1 + "[/color] Perk point"
					});
				tooltip.push({
					id = 6,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.TraitGained + "[/color] trait"
					});
				}
		}
		else
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "This character has not started training"
			});
		}
		return tooltip;
	}
	
    function isHidden()
    {
        if (this.getStatsIncreased() == 0)
        {
        return true;
        }
        else
        {
        return false;
        }
    }	

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU16(this.m.HitpointsAdded);
		_out.writeU16(this.m.StaminaAdded);
		_out.writeU16(this.m.BraveAdded);
		_out.writeU16(this.m.IniAdded);
		_out.writeU16(this.m.MatkAdded);
		_out.writeU16(this.m.RatkAdded);
		_out.writeU16(this.m.MdefAdded);
		_out.writeU16(this.m.RdefAdded);
		_out.writeF32(this.m.BonusXP);
		_out.writeString(this.m.TraitGained);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.HitpointsAdded = _in.readU16();
		this.m.StaminaAdded = _in.readU16();
		this.m.BraveAdded = _in.readU16();
		this.m.IniAdded = _in.readU16();
		this.m.MatkAdded = _in.readU16();
		this.m.RatkAdded = _in.readU16();
		this.m.MdefAdded = _in.readU16();
		this.m.RdefAdded = _in.readU16();
		this.m.BonusXP = _in.readF32();
		this.m.TraitGained = _in.readString();
	}

});

