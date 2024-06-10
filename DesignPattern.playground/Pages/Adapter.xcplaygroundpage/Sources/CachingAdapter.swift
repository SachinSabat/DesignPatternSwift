import Foundation

public class Point : CustomStringConvertible, Hashable
{
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int)
    {
        self.x = x
        self.y = y
    }

    public var description: String
    {
        return "(\(x), \(y))"
    }

    public var hashValue: Int
    {
        return (x * 397) ^ y
    }

    public static func == (lhs: Point, rhs: Point) -> Bool
    {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

public class Line : CustomStringConvertible, Hashable
{
    var start: Point
    var end: Point

    init(_ start: Point, _ end: Point)
    {
        self.start = start
        self.end = end
    }

    public var description: String
    {
        return "Line from \(start) to \(end)"
    }

    public var hashValue: Int
    {
        return (start.hashValue * 397) ^ end.hashValue
    }

    public static func == (lhs: Line, rhs: Line) -> Bool
    {
        return lhs.start == rhs.start && lhs.end == rhs.end
    }
}

public class VectorObject : Sequence
{
    var lines = [Line]()

    public func makeIterator() -> IndexingIterator<Array<Line>>
    {
        return IndexingIterator(_elements: lines)
    }
}

public class VectorRectangle : VectorObject
{
    init(_ x: Int, _ y: Int, _ width: Int, _ height: Int)
    {
        super.init()
        lines.append(Line(Point(x,y), Point(x+width, y)))
        lines.append(Line(Point(x+width, y), Point(x+width, y+height)))
        lines.append(Line(Point(x,y), Point(x,y+height)))
        lines.append(Line(Point(x,y+height), Point(x+width, y+height)))
    }
}

public class LineToPointAdapter : Sequence
{
    private static var count = 0

    // hash of line -> points for line
    static var cache = [Int: [Point]]()
    var hash: Int

    init(_ line: Line)
    {
        // if the line is cached, don't add it
        hash = line.hashValue
        if type(of: self).cache[hash] != nil { return }

        type(of: self).count += 1
        print("\(type(of: self).count): Generating points for \(line)")

        let left = Swift.min(line.start.x, line.end.x)
        let right = Swift.max(line.start.x, line.end.x)
        let top = Swift.min(line.start.y, line.end.y)
        let bottom = Swift.max(line.start.y, line.end.y)
        let dx = right - left
        let dy = line.end.y - line.start.y

        var points = [Point]()

        if dx == 0
        {
            for y in top...bottom
            {
                points.append(Point(left, y))
            }
        } else if dy == 0
        {
            for x in left...right
            {
                points.append(Point(x,top))
            }
        }

        type(of: self).cache[hash] = points
    }

    public func makeIterator() -> IndexingIterator<Array<Point>>
    {
        return IndexingIterator(_elements: type(of: self).cache[hash]!)
    }
}

public func drawPoint(_ p: Point)
{
    print(".", terminator: "")
}

public let vectorObjects = [
    VectorRectangle(1,1,10,10),
    VectorRectangle(3,3,6,6)
]

public func draw()
{
    // unfortunately, can only draw points
    for vo in vectorObjects
    {
        for line in vo
        {
            let adapter = LineToPointAdapter(line)
            adapter.forEach{ drawPoint($0) }
        }
    }
}

public func CachingMain()
{
    draw()
    draw() // shows why we need caching
}
