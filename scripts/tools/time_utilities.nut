

//
// The required timer class to make the above work  (might need to be a seperate file)
//

class TimerClass {
    constructor(_id) {
        this.ID = _id;
        this.Start = getExactTime();
        this.PauseStart = null;
        this.PauseIncrement = 0;
    }

    // Returns the elapsed time in milliseconds without logging
    function silentGet() {
        local pauseIncrement = this.PauseIncrement;
        if (this.PauseStart != null) {
            pauseIncrement += getExactTime() - this.PauseStart;
        }
        return (getExactTime() - this.Start - pauseIncrement) * 1000;
    }

    // Returns the elapsed time in milliseconds and logs the time
    // _msg: an optional message to include in the log
    // _stop: whether to stop the timer after getting the time
    function get(_msg = "", _stop = false) {
        local time = this.silentGet();
        local text = format("Timer: %s %s at %f ms", this.ID, _stop ? "stopped" : "currently", time);
        if (_msg != "") text += " | Msg: " + _msg;
        logInfo(text);
        return time;
    }

    // Pauses the timer
    function pause() {
        if (this.PauseStart != null) {
            printWarning(format("Timer %s paused despite already being paused!", this.ID), "performance");
        }
        this.PauseStart = getExactTime();
    }

    // Resumes the timer if it was paused
    function unpause() {
        if (this.PauseStart == null) {
            printWarning(format("Timer %s resumed despite not being paused!", this.ID), "performance");
            return;
        }
        this.PauseIncrement += getExactTime() - this.PauseStart;
        this.PauseStart = null;
    }

    // Stops the timer, logs the time, and removes it from the global timer list
    // _msg: an optional message to include in the log
    function stop(_msg = "") {
        delete Utils.Timers[this.ID];
        return this.get(_msg, true);
    }

    // Stops the timer without logging and removes it from the global timer list
    function silentStop() {
        delete Utils.Timers[this.ID];
        return this.silentGet();
    }
}


function testTimer() {
    local timer = TimerClass("TestTimer");

    // Simulate some elapsed time
    local startTime = getExactTime();
    ::time = function() { return startTime + 1; };

    // Test silentGet
    local elapsed = timer.silentGet();
    print("Elapsed time after 1 second: " + elapsed + " ms");
    assert(elapsed >= 1000 && elapsed < 1100);

    // Test pause and unpause
    timer.pause();
    ::time = function() { return startTime + 2; };
    timer.unpause();
    ::time = function() { return startTime + 3; };
    elapsed = timer.silentGet();
    print("Elapsed time after pause and unpause: " + elapsed + " ms");
    assert(elapsed >= 2000 && elapsed < 2100);

    // Test get
    local loggedTime = timer.get("Test message");
    print("Logged time: " + loggedTime + " ms");
    assert(loggedTime == elapsed);

    // Test stop
    loggedTime = timer.stop("Stopping timer");
    print("Time after stop: " + loggedTime + " ms");
    assert(loggedTime == elapsed);

    // Ensure timer is removed from global list
    assert(Utils.Timers["TestTimer"] == null);
}

// Simulate the exact time function
function getExactTime() {
    return time(); // Use the mock time function
}

// Mock time function
::time = function() {
    return os.time(); // Default to actual system time for real usage
};

// Assertion function for tests
function assert(condition, message = "Assertion failed") {
    if (!condition) {
        throw message;
    }
}

// Function to log informational messages
function logInfo(message) {
    print("Info: " + message);
}

// Function to print warning messages
function printWarning(message, category) {
    print("Warning [" + category + "]: " + message);
}




