import Foundation
import XCTest

/// Making a safe singleton is easy construct a static proterty and return a value
/// are difficult to test
/// Use a protocol DI
/// One in the system - db repo, obj factory
/// the init is expensive
/// we do it once, we provide everyone with same instance
/// prevent anyone creating additional copies
/// take care lazy init and thread safety
// A component which is instantiated only once

public protocol Database
{
    func getPopulation(name: String) -> Int
}

public class SingletonDatabase : Database
{
    var capitals = [String: Int]()
    static var instanceCount = 0
    static var instance = SingletonDatabase()

    private init()
    {
        type(of: self).instanceCount += 1
        print("Initializing database")

        let path = "/mnt/c/Dropbox/Projects/Demos/SwiftDesignPatterns/patterns/creational/singleton/capitals.txt"
        if let text = try? String(contentsOfFile: path as String,
                                  encoding: String.Encoding.utf8)
        {
            let strings = text.components(separatedBy: .newlines)
                .filter { !$0.isEmpty }
                .map { $0.trimmingCharacters(in: .whitespaces)}
            //print(strings.count)
            for i in 0..<(strings.count/2)
            {
                //print("`\(strings[i*2])` has population \(Int(strings[i*2+1])!)")
                capitals[strings[i*2]] = Int(strings[i*2+1])!
            }
        }
    }

    public func getPopulation(name: String) -> Int {
        return capitals[name]!
    }
}

public class SingletonRecordFinder {
    func totalPopulation(names: [String]) -> Int
    {
        var result = 0
        for name in names {
            // singleton database hardcoded here
            result += SingletonDatabase.instance.getPopulation(name: name);
        }
        return result
    }
}

public class ConfigurableRecordFinder {
    let database: Database
    init(database: Database)
    {
        self.database = database
    }
    func totalPopulation(names: [String]) -> Int
    {
        var result = 0
        for name in names {
            result += database.getPopulation(name: name);
        }
        return result
    }
}

public class DummyDatabase : Database
{
    public func getPopulation(name: String) -> Int {
        return ["alpha": 1, "beta": 2, "gamma": 3][name]!
    }
}

public class SingletonTests: XCTestCase
{
    static var allTests = [
        ("test_isSingletonTest", test_isSingletonTest),
        ("test_singletonTotalPopulationTest", test_singletonTotalPopulationTest),
        ("test_dependantTotalPopulationTest", test_dependantTotalPopulationTest)
    ]

    func test_isSingletonTest()
    {
        var db = SingletonDatabase.instance
        var db2 = SingletonDatabase.instance
        XCTAssertEqual(1, SingletonDatabase.instanceCount, "instance count must = 1")
    }

    func test_singletonTotalPopulationTest()
    {
        let rf = SingletonRecordFinder()
        let names = ["Seoul", "Mexico City"]
        let tp = rf.totalPopulation(names: names)
        XCTAssertEqual(17_500_000+17_400_000, tp, "population size must match")
    }

    func test_dependantTotalPopulationTest() {
        let db = DummyDatabase()
        let rf = ConfigurableRecordFinder(database: db)
        XCTAssertEqual(4, rf.totalPopulation(names: ["alpha", "gamma"]))
    }
}

public func SingletonMain()
{
    // cannot construct database directly
    //let mydb = SingletonDatabase()

    let db = SingletonDatabase.instance
    var city = "Tokyo"
    print("\(city) has population \(db.getPopulation(name: city))")
    city = "Manila"
    print("\(city) has population \(db.getPopulation(name: city))")
    print("SingletonDatabase has \(SingletonDatabase.instanceCount) instance(s)")
}
