import Foundation
import XCTest

// Getting the interface you want from the interface you have
/// A construct which adapts an existing interface X to conform to the required interface Y
/// Determine the API you have and the API you need
/// Create a component which has reference too adaptee
/// Intermediate reference can pile up use caching and other opt
/// 

public class Square
{
    var side = 0

    init(side: Int)
    {
        self.side = side
    }
}

public protocol Rectangle
{
    var width: Int { get }
    var height: Int { get }
}

public extension Rectangle
{
    var area: Int
    {
        return self.width * self.height
    }
}

public class SquareToRectangleAdapter : Rectangle
{
    private let square: Square

    init(_ square: Square)
    {
        self.square = square
    }

    public var width: Int { return square.side }
    public var height: Int { return square.side }
}

public class UMBaseTestCase : XCTestCase {}

//@testable import Test

public class Evaluate: UMBaseTestCase
{
    func simpleTest()
    {
        let sq = Square(side: 11)
        let adapter = SquareToRectangleAdapter(sq)
        XCTAssertEqual(121, adapter.area)
    }
}

extension Evaluate
{
    static var allTests : [(String, (Evaluate) -> () throws -> Void)]
    {
        return [
            ("simpleTest", simpleTest)
        ]
    }
}

public func ExerciseMain()
{
    print(Evaluate.allTests)
}
