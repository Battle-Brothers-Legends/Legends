// Returns the floored logarithm base 2 of a number
// _num: the number to calculate the log2 for
// Returns the floored log2 value as an integer
::log2int <- function(_input) {
    local count = 0;
    if (_input <= 0) {
        loginfo("Invalid input for log2int: _input must be a positive integer.");
    }

    while (_input > 1) {
        _input = _input >> 1;
        count++;
    }
    return count;
}

::testLog2int <- function() {
    loginfo("log2int(1): " + log2int(1)); // Should be 0
    loginfo("log2int(2): " + log2int(2)); // Should be 1
    loginfo("log2int(4): " + log2int(4)); // Should be 2
    loginfo("log2int(8): " + log2int(8)); // Should be 3
}


// Returns the normalized value of the normal distribution at _x
// _x: the value to calculate the distribution for (must be a number)
// _mean: the mean (average) of the distribution (must be a number)
// _std: the standard deviation of the distribution (must be a positive number)
// Returns the normalized value of the normal distribution at _x
::normalDistNorm <- function(_x, _mean, _std) {
    return exp(-0.5 * pow((_x - _mean) / _std.tofloat(), 2));
}


::testNormalDistFunctions <- function() {
    local mean = 0.0;
    local std = 1.0;
    local x = 0.0;

    loginfo("normalDistNorm(0): " + normalDistNorm(x, mean, std)); // Should be 1
    loginfo("normalDist(0): " + normalDist(x, mean, std)); // Should be approx 0.3989
}



// Returns the value of the normal distribution at _x
// _x: the value to calculate the distribution for (must be a number)
// _mean: the mean (average) of the distribution (must be a number)
// _std: the standard deviation of the distribution (must be a positive number)
// Returns the value of the normal distribution at _x
::normalDist <- function(_x, _mean, _std) {
    return exp(-0.5 * pow((_x - _mean) / (_std * 1.0), 2)) / (_std * sqrt(2 * 3.14));
}

//Test normalDistNorm and normalDist
::testNormalDistFunctions <- function() {
    try {
        local mean = 0.0;
        local std = 1.0;
        local x = 0.0;

        loginfo("normalDistNorm(0): " + normalDistNorm(x, mean, std)); // Should be 1
        loginfo("normalDist(0): " + normalDist(x, mean, std)); // Should be approx 0.3989
    } catch (e) {
        loginfo("Error in testNormalDistFunctions: " + e);
    }
}

// Returns a random float between _min and _max
// _min: the minimum value of the range (must be a number)
// _max: the maximum value of the range (must be a number and greater than _min)
// Returns a random float between _min and _max
::randf <- function(_min, _max) {
    ::FU.requireFloat(_min, _max);
    return _min + (::Math.rand(0, 2147483647) / 2147483647.0) * (_max - _min);
}

::testRandf <- function() {
    local min = 0.0;
    local max = 1.0;

    for (local i = 0; i < 5; i++) {
        loginfo("randf(" + min + ", " + max + "): " + randf(min, max));
    }
}


// Returns the cumulative distribution function value for normal distribution at _x
// _x: the value to calculate the CDF for (must be a number)
// _mean: the mean (average) of the distribution (must be a number)
// _std: the standard deviation of the distribution (must be a positive number)
// Returns the CDF value at _x
::normalDistCDF <- function(_x, _mean, _std) {
    local z = (_x - _mean) / (_std * sqrt(2));
    local t = 1 / (1 + 0.3275911 * abs(z));
    local erf = 1 - (((((1.061405429 * t - 1.453152027) * t) + 1.421413741) * t - 0.284496736) * t + 0.254829592) * t * exp(-z * z);
    return 0.5 * (1 + (z >= 0 ? erf : -erf));
}

// Generates a random number from a normal distribution using Box-Muller transform
// _mean: the mean (average) of the distribution (must be a number)
// _std: the standard deviation of the distribution (must be a positive number)
// Returns a random number from the normal distribution
::randNormal <- function(_mean, _std) {
    if (typeof _mean != "number" || typeof _std != "number" || _std <= 0) {
        throw "Invalid input: _mean must be a number, _std must be a positive number.";
    }
    local u1 = randf(0.0, 1.0);
    local u2 = randf(0.0, 1.0);
    local z0 = sqrt(-2.0 * log(u1)) * cos(2.0 * 3.141592653589793 * u2);
    return _mean + z0 * _std;
}

::testNormalCDFFunctions <- function() {
    try {
        loginfo("exp2int(3): " + exp2int(3)); // Should be 8

        local mean = 0.0;
        local std = 1.0;
        local x = 0.0;

        loginfo("normalDistCDF(0): " + normalDistCDF(x, mean, std)); // Should be approx 0.5

        for (local i = 0; i < 5; i++) {
            loginfo("randNormal(0, 1): " + randNormal(mean, std));
        }
    } catch (e) {
        loginfo("Error in testAdditionalFunctions: " + e);
    }
}

