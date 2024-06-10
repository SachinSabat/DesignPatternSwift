import Foundation

/// Connecting components thorugh abstraction
/// A mechanism that decouples an interface from an implementation (hierarchy)
/// Decouple abstraction from implementation
/// A stronger form of encapsulation
/// Both can exist as heirarchy

public protocol Renderer
{
    func renderCircle(_ radius: Float)
}

public class VectorRenderer : Renderer
{
    public func renderCircle(_ radius: Float)
    {
        print("Drawing a circle or radius \(radius)")
    }
}

public class RasterRenderer : Renderer
{
    public func renderCircle(_ radius: Float)
    {
        print("Drawing pixels for circle of radius \(radius)")
    }
}

public protocol Shape
{
    func draw()
    func resize(_ factor: Float)
}

public class Circle : Shape
{
    var radius: Float
    var renderer: Renderer

    init(_ renderer: Renderer, _ radius: Float)
    {
        self.renderer = renderer
        self.radius = radius
    }

    public func draw()
    {
        renderer.renderCircle(radius)
    }

    public func resize(_ factor: Float)
    {
        radius *= factor
    }
}

public func BridgeMain()
{
    let raster = RasterRenderer()
    let vector = VectorRenderer()
    let circle = Circle(vector, 5)
    circle.draw()
    circle.resize(2)
    circle.draw()

    let circleRaster = Circle(vector, 5)
    circleRaster.draw()
    circleRaster.resize(5)
    circleRaster.draw()

    // todo DI
}
