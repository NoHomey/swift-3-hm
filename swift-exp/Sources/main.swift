protocol Expresion {
    func eval() -> Double
}

class Number : Expresion {
    var expValue: Double;

    init(value: Double) {
        self.expValue = value
    }

    func eval() -> Double {
        return self.expValue
    }
}

class AritmeticExpresion: Expresion {
    var leftExpresion: Expresion
    var rightExpresion: Expresion

    init(leftExpr: Expresion, rightExpr: Expresion) {
        self.leftExpresion = leftExpr
        self.rightExpresion = rightExpr
    }

    func eval() -> Double {
        return 0
    }
}

class Add: AritmeticExpresion {
    override func eval() -> Double {
        return self.leftExpresion.eval() + self.rightExpresion.eval()
    }
}

class Sub: AritmeticExpresion {
    override func eval() -> Double {
        return self.leftExpresion.eval() - self.rightExpresion.eval()
    }
}

class Mul: AritmeticExpresion {
    override func eval() -> Double {
        return self.leftExpresion.eval() * self.rightExpresion.eval()
    }
}

class Div: AritmeticExpresion {
    override func eval() -> Double {
        return self.leftExpresion.eval() / self.rightExpresion.eval()
    }
}

enum AritmeticOperation {
    case Add
    case Sub
    case Mul
    case Div
}

enum OperatorPrecedence {
    case Lowest
    case Middle
    case Biggest
}

func operation(leftExpr: Expresion,
                operation: AritmeticOperation,
                    rightExpr: Expresion)-> AritmeticExpresion {
    switch operation {
        case AritmeticOperation.Add: return Add(leftExpr: leftExpr, rightExpr: rightExpr)
        case AritmeticOperation.Sub: return Sub(leftExpr: leftExpr, rightExpr: rightExpr)
        case AritmeticOperation.Mul: return Mul(leftExpr: leftExpr, rightExpr: rightExpr)
        case AritmeticOperation.Div: return Div(leftExpr: leftExpr, rightExpr: rightExpr)
    }
}

func precedence(operation: AritmeticOperation) -> OperatorPrecedence {
    switch operation {
        case AritmeticOperation.Add: return OperatorPrecedence.Lowest
        case AritmeticOperation.Sub: return OperatorPrecedence.Lowest
        case AritmeticOperation.Mul: return OperatorPrecedence.Middle
        case AritmeticOperation.Div: return OperatorPrecedence.Middle
    }
}

let expr: Expresion = Add(leftExpr: Mul(leftExpr:Number(value: 3),
                                    rightExpr: Number(value: 6)),
                                    rightExpr: Number(value: 5))

print(expr.eval())