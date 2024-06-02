import Foundation
import XCTest

// A factory method is a static method to create obj
// a factory can take care of obj creation
// a factory can be external or reside inside the obj as an inner class
// hierarchies of factories can be used to create related obj

public class Person
{
    var id: Int
    var name: String

    init(called name: String, withId id: Int)
    {
        self.name = name
        self.id = id
    }
}

public class PersonFactory
{
    private var id = 0

    func createPerson(name: String) -> Person
    {
        let p = Person(called: name, withId: id)
        id += 1
        return p
    }
}

public class UMBaseTestCase : XCTestCase {}

//@testable import Test

public class Evaluate: UMBaseTestCase
{
    func simpleTest()
    {
        let pf = PersonFactory()

        let p1 = pf.createPerson(name: "Chris")
        XCTAssertEqual("Chris", p1.name)

        let p2 = pf.createPerson(name: "Sarah")
        XCTAssertEqual(1, p2.id)
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

public func exerciseMain()
{
    print(Evaluate.allTests)
}
