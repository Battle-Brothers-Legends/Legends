::FU.Class.WeightedContainer <- class {
    // Constructor to initialize the container with a list of weighted elements
    constructor(elements = []) {
        this.weights = [];
        this.elements = [];
        this.totalWeight = 0;

        // Add initial elements if provided
        foreach (element in elements) {
            this.add(element[0], element[1]);
        }
    }

    // Adds an element with a specified weight to the container
    function add(weight, element) {
        this.totalWeight += weight;
        this.weights.push(weight);
        this.elements.push(element);
    }

    // Retrieves a random element from the container based on their weights
    function get() {
        local randWeight = math.rand() * this.totalWeight;
        local cumulativeWeight = 0;

        for (local i = 0; i < this.weights.len(); i++) {
            cumulativeWeight += this.weights[i];
            if (randWeight <= cumulativeWeight) {
                return this.elements[i];
            }
        }

        return null;  // Should not reach here
    }

    // Removes a specified element from the container
    function remove(element) {
        local index = this.elements.find(element);
        if (index != null) {
            this.totalWeight -= this.weights[index];
            this.weights.remove(index);
            return this.elements.remove(index);
        }
        return null;
    }

    // Clears all elements from the container
    function clear() {
        this.weights.clear();
        this.elements.clear();
        this.totalWeight = 0;
    }
}

// Test cases for the WeightedContainer class
function runWeightedContainerClassTests() {
    // Create a container
    local container = WeightedContainer([
        [10, "Element1"],
        [20, "Element2"],
        [30, "Element3"]
    ]);

    // Test getting a random element
    local element = container.get();
    loginfo("Weighted Container Element: " + element);

    // Test adding an element
    container.add(40, "Element4");
    element = container.get();
    loginfo("After adding, Weighted Container Element: " + element);

    // Test removing an element
    container.remove("Element2");
    element = container.get();
    loginfo("After removal, Weighted Container Element: " + element);

    // Test clearing the container
    container.clear();
    loginfo("After clearing, Container Total Weight: " + container.totalWeight);
}

