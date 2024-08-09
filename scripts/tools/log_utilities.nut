// Queuing Errors 
class QueueErrors {
    constructor() {
        this.Errors = "";
    }

    // Adds an error string to the log and stores it
    function add(_string) {
        requireString(_string);
        logError(_string);
        this.Errors += _string + "<br><br>";
    }
}

// Logging 
::FU.Class.Log <- class{
    // Prints the stack trace
    function printStackTrace(_maxDepth = 0, _maxLen = 10, _advanced = false) {
        local count = 2;
        local string = "<div class=\"stacktrace-container value-container\">";
        while (getstackinfos(count) != null) {
            string += "<div class=\"function-container\"><div style=\"color:green;\" class=\"label\">Function:</div><div class=\"value\">"
            local line = getstackinfos(count++);
            if (line.func != "unknown") {
                string += line.func + " ";
            }
            string += "-> " + line.src + " : " + line.line + "</div></div><div class=\"function-container\"><div style=\"color:green;\" class=\"label\">Variables:</div><div class=\"valueVar\">";
            local fixCounter = 0;
            foreach (key, value in line.locals) {
                if (key == "this" || key == "_release_hook_DO_NOT_delete_it_") {
                    fixCounter++;
                    continue;
                }
                string += format("%s = %s, ", key, this.getLocalString(value, _maxLen, _maxDepth, _advanced, false));
            }
            if (line.locals.len() - fixCounter != 0) string = string.slice(0, string.len() - 2);
            else string += "&nbsp;"
            string += "</div></div>";
        }
        string += "</div>"
        logInfo(string);
    }

    // Prints the formatted data
    function printData(_data, _maxDepth = 1, _advanced = false, _maxLenMin = 1, _printClasses = true) {
        local stackinfos = getstackinfos(2);
        logInfo(format("%s -> %s : %i printData: %s", stackinfos.func == "unknown" ? "" : stackinfos.func, stackinfos.src, stackinfos.line, this.formatData(_data, _maxDepth, _advanced, _maxLenMin, _printClasses).tostring()));
    }

    // Formats the data for printing
    function formatData(_data, _maxDepth = 1, _advanced = false, _maxLenMin = 1, _printClasses = true) {
        if (["array", "table"].find(typeof _data) != null && _data.len() > _maxLenMin) {
            _maxLenMin = _data.len();
        } else if (["class", "instance"].find(typeof _data) != null) {
            local len = 0;
            local classed = typeof _data == "instance" ? _data.getclass() : _data;
            foreach (key, value in classed) ++len;
            if (len > _maxLenMin) _maxLenMin = len;
        }
        return this.getLocalString(_data, _maxLenMin, _maxDepth, _advanced, _printClasses);
    }

    // Gets the local string representation of a value
    function getLocalString(_value, _maxLen, _depth, _advanced, _printClasses) {
        local ret = "";

        if (typeof _value == "array" && _value.len() <= _maxLen && _depth > 0) {
            ret = "[";
            foreach (idx, value in _value) {
                ret += this.getLocalString(value, _maxLen, _depth - 1, _advanced, _printClasses) + ", ";
            }
            if (_value.len() != 0) ret = ret.slice(0, -2);
            ret += "]";
        } else if (typeof _value == "table" && _value.len() <= _maxLen && _depth > 0) {
            ret += "{";
            foreach (key, value in _value) {
                ret += format("%s = %s, ", key.tostring(), this.getLocalString(value, _maxLen, _depth - 1, _advanced, _printClasses));
            }
            if (_value.len() != 0) ret = ret.slice(0, -2);
            ret += "}";
        } else if (["instance", "class"].find(typeof _value) != null && _depth > 0 && _printClasses) {
            ret += "&lt;";
            local valueClass = typeof _value == "instance" ? _value.getclass() : _value;
            local len = 0;
            foreach (key, value in valueClass) {
                ret += format("%s = %s, ", key, this.getLocalString(_value[key], _maxLen, _depth - 1, _advanced, _printClasses));
                len++;
            }
            if (len != 0) ret = ret.slice(0, -2);
            ret += "&gt;";
        } else if (!_advanced && ["function", "instance", "table", "array", "null", "class"].find(typeof _value) != null) {
            ret += capitalizeFirst(typeof _value);
        } else if (typeof _value == "string") {
            ret += format("\"%s\"", _value);
        } else if (typeof _value == "bool") {
            ret += capitalizeFirst(_value.tostring());
        } else {
            ret += _value;
        }
        return ret;
    }
}

