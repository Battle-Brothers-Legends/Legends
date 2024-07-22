//
// Network Utilities  
// Warning, this can get spicy. 
// Please be transparent with your users about what you're using this for
// No authentication layer is provided, there are plenty of js libraries for that
// 
class NetworkUtils {
    //
    // We establish a whitelist up front
    // This is to stop squirrel code pulling from arbitrary sites
    // Please be judicious and careful with which sites you allow
    //
    static function isWhitelisted(url) {
        local whitelist = [
            "http://example.com/api/send",
            "http://example.com/api/get"
            // Add other URLs here
        ];
        return (url in whitelist);
    }

    //
    // Here we handle an incoming data table
    // We check the whitelist first
    // Then we decide what to do with it
    // 
    static function onIncomingDataTable(url, IncomingTableData) {
        if (!NetworkUtils.isWhitelisted(url)) return;
        print("Received data from " + url + ": " + IncomingTableData);
        // Insert additional processing logic here
        // the data format is in the examples below
    }

    // 
    // An incoming data request would be received in tabular form
    // We aren't just automatically sending out data process the request first
    // And we aren't accepting requests from outside the whitelist 
    //
    
    static function onIncomingDataRequest(url, RequestTableData) {
        if (!NetworkUtils.isWhitelisted(url)) return;
        print("Received request from " + url + ": " + RequestTableData);
        // Insert request processing logic here
    }
    
    //
    // Sending data to URL is also pretty simple
    // As always, we check the whitelist first to stop data leaking out
    // The table is expected in the same format as below 
    // We turn the table into JSON in the javascript layer 
    // 
    static function sendData(url, TableData) {
        if (!NetworkUtils.isWhitelisted(url)) return;
        ::SQ.call(::SQ.getUIHandle(), "sendDataToURL", { url = url, table = TableData });
    }
    //
    // Getting data from URL uses the same request format
    // And we remember to check the whitelist
    //
    
    static function getData(url, RequestTableData) {
        if (!NetworkUtils.isWhitelisted(url)) return;
        ::SQ.call(::SQ.getUIHandle(), "fetchDataFromURL", { url = url, table = RequestTableData, sqHandle = ::SQ.getUIHandle() });
    }

}

// Register the Squirrel functions with the JavaScript frontend
::SQ.register("onIncomingDataTable", NetworkUtils.onIncomingDataTable);
::SQ.register("onIncomingDataRequest", NetworkUtils.onIncomingDataRequest);

// Example usage for sending data
//local exampleDataTable = {
//    modID = "mod_FU",
//    fieldName1 = ["fieldData1"],
//    fieldName2 = ["fieldData2", "fieldData3"]
//};
//NetworkUtils.sendData("http://example.com/api/send", exampleDataTable);
//
//
// Example usage for fetching data
//local exampleRequestTable = {
//    modID = "mod_FU",
//    requestedFieldName1 = "fieldName1",
//    requestedFieldName2 = "fieldName2"
//};
//NetworkUtils.getData("http://example.com/api/get", exampleRequestTable);

