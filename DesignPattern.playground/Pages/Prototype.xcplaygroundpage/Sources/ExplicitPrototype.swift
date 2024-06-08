import Foundation

public protocol Copying
{
    // the 'required' keyword is only used in classes
    //init(copyFrom other: Self)
    func clone() -> Self
}

public class Address : CustomStringConvertible, Copying
{
    var streetAddress: String
    var city: String

    public init(_ streetAddress: String, _ city: String)
    {
        self.streetAddress = streetAddress
        self.city = city
    }

    public func clone() -> Self
    {
        return cloneImpl()
    }

    private func cloneImpl<T>() -> T
    {
        return Address(streetAddress, city) as! T
    }

    // required init(copyFrom other: Address)
    // {
    //   streetAddress = other.streetAddress
    //   city = other.city
    // }

   public var description: String
    {
        return "\(streetAddress), \(city)"
    }
}

public struct Employee: CustomStringConvertible, Copying
{
    var name: String
    var address: Address

    public init(_ name: String, _ address: Address)
    {
        self.name = name
        self.address = address
    }

    // C++ style copy constructor
    // required  init(copyFrom other: Employee)
    // {
    //   name = other.name

    //   // one option is to do this
    //   //address = Address(other.address.streetAddress, other.address.city)

    //   // and another option is to do this
    //   address = Address(copyFrom: other.address)
    // }

    public func clone() -> Employee
    {
        return cloneImpl()
    }

    private func cloneImpl<T>() -> T
    {
        return Employee(name, address.clone()) as! T
    }

    public var description: String
    {
        return "My name is \(name) and I live at \(address)"
    }
}

public func ExplicitPrototypeMain()
{
  var john = Employee("John", Address("123 London Road", "London"))


  // if employee is a class, these refer to the same obj
  // if it's a struct, a copy is made
  //var chris = john


  var chris = john.clone() // here
  chris.name = "Chris"
  chris.address.city = "Manchester"

  // if address is a class, they both end up in Manchester
  // if address is a struct, a copy is made

  print(chris.description)
  print(john.description)
}
