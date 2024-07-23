/*
*
*  Extends existing tooltips to add in our mod settings 
*
*/


// Preserve and extend the notifyBackendQueryTooltipData function for custom tooltips
var notifyBackendQueryTooltipData = TooltipModule.prototype.notifyBackendQueryTooltipData;
TooltipModule.prototype.notifyBackendQueryTooltipData = function (_data, _callback) {
    if (this.mSQHandle !== null && _data !== null && 'contentType' in _data && _data.contentType.search("FU-") == 0) {
        SQ.call(this.mSQHandle, 'onQueryFUTooltipData', _data, _callback);
    } else {
        notifyBackendQueryTooltipData.call(this, _data, _callback);
    }
};
