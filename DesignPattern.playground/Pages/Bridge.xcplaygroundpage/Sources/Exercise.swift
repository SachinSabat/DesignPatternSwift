//import Foundation
//import XCTest
//
//public protocol Renderer
//{
//    var whatToRenderAs: String { get }
//}
//
//public class Shape : CustomStringConvertible
//{
//    private let renderer: Renderer
//
//   public init(_ renderer: Renderer)
//    {
//        self.renderer = renderer
//    }
//
//    var name: String = ""
//
//    var description: String
//    {
//        return "Drawing \(name) as \(renderer.whatToRenderAs)"
//    }
//}
//
//public class Triangle : Shape
//{
//    override init(_ renderer: Renderer)
//    {
//        super.init(renderer)
//        name = "Triangle"
//    }
//}
//
//public class Square : Shape
//{
//    override init(_ renderer: Renderer)
//    {
//        super.init(renderer)
//        name = "Square"
//    }
//}
//
//public class RasterRenderer : Renderer
//{
//    var whatToRenderAs: String {
//        return "pixels"
//    }
//}
//
//public class VectorRenderer : Renderer
//{
//    var whatToRenderAs: String
//    {
//        return "lines"
//    }
//}
//
//public class UMBaseTestCase : XCTestCase {}
//
////@testable import Test
//
//public class Evaluate: UMBaseTestCase
//{
//    func simpleTest()
//    {
//        XCTAssertEqual(
//            "Drawing Square as lines",
//            Square(VectorRenderer()).description
//        )
//    }
//}
//
//public extension Evaluate
//{
//    static var allTests : [(String, (Evaluate) -> () throws -> Void)]
//    {
//        return [
//            ("simpleTest", simpleTest)
//        ]
//    }
//}
//
//public func BridgeExerciseMain()
//{
//    print(Evaluate.allTests)
//}
