import Foundation

// Classes should be open for extension but closed for modification, use inheritance here

public enum Color
{
  case red
  case green
  case blue
}

public enum Size
{
  case small
  case medium
  case large
  case yuge
}

public class Product
{
  var name: String
  var color: Color
  var size: Size

  init(_ name: String, _ color: Color, _ size: Size)
  {
    self.name = name
    self.color = color
    self.size = size
  }
}

public class ProductFilter
{
  func filterByColor(_ products: [Product], _ color: Color) -> [Product]
  {
    var result = [Product]()
    for p in products
    {
      if p.color == color
      {
        result.append(p)
      }
    }
    return result
  }

  func filterBySize(_ products: [Product], _ size: Size) -> [Product]
  {
    var result = [Product]()
    for p in products
    {
      if p.size == size
      {
        result.append(p)
      }
    }
    return result
  }

  func filterBySizeAndColor(_ products: [Product],
    _ size: Size, _ color: Color) -> [Product]
  {
    var result = [Product]()
    for p in products
    {
      if (p.size == size) && (p.color == color)
      {
        result.append(p)
      }
    }
    return result
  }
}

public protocol Specification {
    associatedtype T
    func isSatisfied(_ item: T) -> Bool
}

public protocol Filter {
    associatedtype T
    func filter<Spec: Specification>(_ item: [T], _ spec: Spec) -> [T] where Spec.T == T
}

public class ColorSpecification : Specification
{
    public typealias T = Product
  let color: Color
  init(_ color: Color)
  {
    self.color = color
  }
    public func isSatisfied(_ item: Product) -> Bool
  {
    return item.color == color
  }
}

public class SizeSpecification : Specification
{
    public typealias T = Product
  let size: Size
  init(_ size: Size)
  {
    self.size = size
  }
    public func isSatisfied(_ item: Product) -> Bool
  {
    return item.size == size
  }
}

public class AddSpecification<T,
                       SpecA: Specification,
                       SpecB: Specification> : Specification where SpecA.T == SpecB.T, T == SpecA.T, T == SpecB.T
{
  let first: SpecA
  let second: SpecB
  init(_ first: SpecA, _ second: SpecB)
  {
    self.first = first
    self.second = second
  }
    public func isSatisfied(_ item: T) -> Bool
  {
    return first.isSatisfied(item) && second.isSatisfied(item)
  }
}

public class BetterFilter : Filter
{
    public typealias T = Product

    public func filter<Spec: Specification>(_ items: [Product], _ spec: Spec)
    -> [T] where Spec.T == T
  {
    var result = [Product]()
    for i in items
    {
      if spec.isSatisfied(i)
      {
        result.append(i)
      }
    }
    return result
  }
}

public func ocpMain()
{
  let apple = Product("Apple", .green, .small)
  let tree = Product("Tree", .green, .large)
  let house = Product("House", .blue, .large)

  let products = [apple, tree, house]

  let pf = ProductFilter()
  print("Green products (old):")
  for p in pf.filterByColor(products, .green)
  {
    print(" - \(p.name) is green")
  }

  let bf = BetterFilter()
  print("Green products (new):")
  for p in bf.filter(products, ColorSpecification(.green))
  {
    print(" - \(p.name) is green")
  }

  print("Large blue items")
  for p in bf.filter(products,
    AddSpecification(
      ColorSpecification(.blue),
      SizeSpecification(.large)
    ))
  {
    print(" - \(p.name) is large and blue")
  }
}
