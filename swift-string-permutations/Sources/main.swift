func permutate(n: Int, elements: inout [Character], generated: inout [String]) {
    if(n == 1) {
        generated.append(String(elements))
    } else {
        let prev = n - 1
        for i in 0..<prev {
            permutate(n: prev, elements: &elements, generated: &generated)
            swap(&elements[(n % 2) == 1 ? 0 : i], &elements[prev])
        }
        permutate(n: prev, elements: &elements, generated: &generated)
    }
}

func generatePermutations(elements: String) -> [String] {
    var permutations = [String]()
    var input = [Character](elements.characters)
    permutate(n: input.count, elements: &input, generated: &permutations)

    return permutations
}

var permutations = generatePermutations(elements: "abcdef")

print(permutations, permutations.count)