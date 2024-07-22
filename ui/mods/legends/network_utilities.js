/**
 * Utility function to convert a Squirrel table to JSON.
 * @param {object} table - The Squirrel table to convert.
 * @returns {string} - The JSON string representation of the table.
 */
function tableToJSON(table) {
    const json = { modID: table.modID, fields: {} };
    for (const key in table) {
        if (key !== 'modID') {
            json.fields[key] = table[key];
        }
    }
    return JSON.stringify(json);
}

/**
 * Utility function to convert a JSON string to a Squirrel table.
 * @param {string} jsonString - The JSON string to convert.
 * @returns {object} - The Squirrel table representation of the JSON string.
 */
function jsonToTable(jsonString) {
    const json = JSON.parse(jsonString);
    const table = { modID: json.modID };
    for (const key in json.fields) {
        table[key] = json.fields[key];
    }
    return table;
}

/**
 * Function to send data from Squirrel to a URL using XMLHttpRequest.
 * @param {string} url - The URL to send the data to.
 * @param {object} table - The Squirrel table to send.
 */
function sendDataToURL(url, table) {
    const jsonString = tableToJSON(table);
    const xhr = new XMLHttpRequest();
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.send(jsonString);
}

/**
 * Function to fetch data from a URL and return it to Squirrel.
 * @param {string} url - The URL to fetch data from.
 * @param {object} requestTable - The Squirrel table to send as a request.
 * @param {function} callback - The callback function to handle the response.
 */
function fetchDataFromURL(url, requestTable, callback) {
    const jsonString = tableToJSON(requestTable);
    const xhr = new XMLHttpRequest();
    xhr.open("POST", url, true);
    xhr.setRequestHeader("Content-Type", "application/json");
    xhr.onload = function() {
        if (xhr.status === 200) {
            const responseTable = jsonToTable(xhr.responseText);
            callback(responseTable);
        } else {
            console.error("Failed to fetch data from URL: " + url);
        }
    };
    xhr.send(jsonString);
}

// Registering the JavaScript functions with the Squirrel backend
SQ.register("sendDataToURL", function(data) {
    sendDataToURL(data.url, data.table);
});

SQ.register("fetchDataFromURL", function(data) {
    fetchDataFromURL(data.url, data.table, function(responseTable) {
        SQ.call(data.sqHandle, "onIncomingDataTable", responseTable);
    });
});

/**
 * Function to handle incoming data from external sources.
 * @param {string} url - The URL from which data is received.
 * @param {string} jsonData - The JSON data received.
 */
function handleIncomingData(url, jsonData) {
    const table = jsonToTable(jsonData);
    SQ.call("onIncomingDataTable", { url: url, table: table });
}

/**
 * Function to handle incoming data requests from external sources.
 * @param {string} url - The URL from which the request is received.
 * @param {string} jsonData - The JSON data request received.
 */
function handleIncomingDataRequest(url, jsonData) {
    const table = jsonToTable(jsonData);
    SQ.call("onIncomingDataRequest", { url: url, table: table });
}

// Registering the additional JavaScript functions
SQ.register("handleIncomingData", function(data) {
    handleIncomingData(data.url, data.jsonData);
});

SQ.register("handleIncomingDataRequest", function(data) {
    handleIncomingDataRequest(data.url, data.jsonData);
});

// Example usage for sending data
//const exampleDataTable = {
//    modID: "mod_FU",
//    fieldName1: ["fieldData1"],
//    fieldName2: ["fieldData2", "fieldData3"]
//};
//sendDataToURL("http://example.com/api/send", exampleDataTable);

// Example usage for fetching data
//const exampleRequestTable = {
//    modID: "mod_FU",
//    requestedFieldName1: "fieldName1",
//    requestedFieldName2: "fieldName2"
//};
//fetchDataFromURL("http://example.com/api/get", exampleRequestTable, function(responseTable) {
//    console.log("Received data:", responseTable);
//});

