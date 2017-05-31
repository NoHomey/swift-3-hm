extension String {
    subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
}

func preparaForParse(text: String) -> [String] {
    var result: [String] = [];
    text.characters.split { $0 == "\n" }.flatMap(String.init).forEach { string in
        if string.characters.isEmpty {
            return
        }
        if string.characters.first == "#" {
            return
        }
        result.append(string)
    }
    return result;
}

func isDigit(char: Character) -> Bool {
    return char >= "0" && char <= "9"
}

func isLetter(char: Character) -> Bool {
    if char == "_" {
        return true
    }
    return (char >= "a" && char <= "z") || (char >= "A" && char <= "Z")
}

func isWordCharacter(char: Character) -> Bool {
    return isLetter(char: char) || isDigit(char: char)
}

func extractIdentifier(text: String) -> String {
    var result: String
    let chars = text.characters
    for i in 2..<chars.count {
        if chars[i] == " " {
            break
        }
        result += chars[i]
    }
    return result
}

func isValidIdentifier(text: String) -> Bool {
    let first = text.characters.first
    if isDigit(char: first!) || !isLetter(char: first!) {
        return false
    }
    for char in  text.characters {
        if !isWordCharacter(char: char) {
            return false
        }
    }

    return true
}

print(preparaForParse(text: "some text\n\n\n\n#this is \nand this is other\n#coomment"))

print(isValidIdentifier(text: "aaA"))
print(isValidIdentifier(text: "9aaa"))
print(isValidIdentifier(text: "9aaa&aa*"))
print(isValidIdentifier(text: "@aA"))
