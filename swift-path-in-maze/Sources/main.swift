enum SquareInMaze {
    case start
    case end
    case wall
    case tile
}

func constructMaze(maze: [String]) -> [[SquareInMaze]] {
    return maze.map {row in row.characters.map {element in switch element {
        case "1": return SquareInMaze.wall
        case "^": return SquareInMaze.start
        case "*": return SquareInMaze.end
        default: return SquareInMaze.tile
    }}}
}

func createSolutionMatrix(height: Int, width: Int) -> [[Bool]] {
    return Array(repeating: Array(repeating: false, count: width), count: height)
}

func findStart(maze: [[SquareInMaze]]) -> (x: Int, y: Int) {
    let n = maze.count
    let m = maze[0].count
    for i in 0..<n {
        for j in 0..<m {
            if maze[i][j] == SquareInMaze.start {
                return (x: i, y: j)
            }
        }
    }

    return (0, 0)
}

func isValid(dim: Int, size: Int) -> Bool {
    return dim >= 0 && dim < size
}

func canStep(maze: [[SquareInMaze]], pos: (x: Int, y: Int), solution: [[Bool]]) -> Bool {
    return isValid(dim: pos.x, size: maze.count) && isValid(dim: pos.y, size: maze[0].count)
           && maze[pos.x][pos.y] != SquareInMaze.wall && !solution[pos.x][pos.y]
}

func findSolution(maze: [[SquareInMaze]], pos: (x: Int, y: Int), solution: inout [[Bool]]) -> Bool {
    if !canStep(maze: maze, pos: pos, solution: solution) {
        return false
    }
    if maze[pos.x][pos.y] == SquareInMaze.end {
        solution[pos.x][pos.y] = true
        return true
    }
    solution[pos.x][pos.y] = true
    if findSolution(maze: maze, pos: (x: pos.x + 1, y: pos.y), solution: &solution) {
        return true
    }
    if findSolution(maze: maze, pos: (x: pos.x, y: pos.y + 1), solution: &solution) {
        return true
    }
    if findSolution(maze: maze, pos: (x: pos.x - 1, y: pos.y), solution: &solution) {
        return true
    }
    if findSolution(maze: maze, pos: (x: pos.x, y: pos.y - 1), solution: &solution) {
        return true
    }
    solution[pos.x][pos.y] = false
    return false
}

func printSolution(solution: [[Bool]]) {
    let n = solution.count
    let m = solution[0].count
    for i in 0..<n {
        for j in 0..<m {
            if solution[i][j] {
                print("(\(i), \(j))")
            }
        }
    }
    print()
    solution.forEach {row in print(row.map {e in e ? 1 : 0})}
}
 
func findPathIn(maze: [String]) {
    let mazeMatrix = constructMaze(maze: maze)
    let start = findStart(maze: mazeMatrix)
    var solutionMatrix = createSolutionMatrix(height: mazeMatrix.count, width: mazeMatrix[0].count)
    if findSolution(maze: mazeMatrix, pos: start, solution: &solutionMatrix) {
        printSolution(solution: solutionMatrix)
    }
}

findPathIn(maze: [
    "^0000001",
    "01111100",
    "00000111",
    "01110100",
    "01010001",
    "0001010*"
])
