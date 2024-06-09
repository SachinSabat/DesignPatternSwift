import Foundation
import XCTest

public class SingletonTester
{
    static func isSingleton(factory: () -> AnyObject) -> Bool
    {
        let obj1 = factory()
        let obj2 = factory()
        return obj1 === obj2
    }
}

public class UMBaseTestCase : XCTestCase {}

//@testable import Test

public class Evaluate: UMBaseTestCase
{
    func simpleTest()
    {
        let obj = SingletonTester() // hehe, inception!
        XCTAssert(type(of: obj).isSingleton{obj})
        XCTAssertFalse(type(of: obj).isSingleton{ SingletonTester() })
    }
}

public extension Evaluate
{
    static var allTests : [(String, (Evaluate) -> () throws -> Void)]
    {
        return [
            ("simpleTest", simpleTest)
        ]
    }
}

public func SingletonExerciseMain()
{
    print(Evaluate.allTests)
}
