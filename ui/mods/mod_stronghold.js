
$.fn.changeDialogFooterRows = function(_rows, _big)
{
	this.removeClass('has-one-row-footer has-two-rows-footer has-three-rows-footer has-four-rows-footer has-five-rows-footer has-six-rows-footer has-seven-rows-footer has-eight-rows-footer has-nine-rows-footer has-ten-rows-footer has-eleven-rows-footer has-twelve-rows-footer has-big-footer');
    switch(_rows)
    {
        case 1: this.addClass('has-one-row-footer'); break;
        case 2: this.addClass('has-two-rows-footer'); break;
        case 3: this.addClass('has-three-rows-footer'); break;
    	case 4: this.addClass('has-four-rows-footer'); break;
    	case 5: this.addClass('has-five-rows-footer'); break;
    	case 6: this.addClass('has-six-rows-footer'); break;
		case 7: this.addClass('has-seven-rows-footer'); break;
    	case 8: this.addClass('has-eight-rows-footer'); break;
		case 9: this.addClass('has-nine-rows-footer'); break;
		case 10: this.addClass('has-ten-rows-footer'); break;
    	case 11: this.addClass('has-eleven-rows-footer'); break;
		case 12: this.addClass('has-twelve-rows-footer'); break;
		
        default: this.addClass('has-one-row-footer'); break;
    }

    if(_big !== null && _big === true)
    {
        this.addClass('has-big-footer');
    }

    return this;
};