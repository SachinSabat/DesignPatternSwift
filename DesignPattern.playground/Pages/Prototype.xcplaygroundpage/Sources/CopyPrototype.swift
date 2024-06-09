import Foundation

/// A partially or fully init obj that we can copy/ clone make use of
/// Complicated obj car arent desinged from sctracth they reuse the prev design
/// An existing desing is the prototype
/// We make a cpoy/ clone prototype and and customise it
/// We make cloning convinient (eg. via factory)

public protocol CopyingEx
{
    // the 'required' keyword is only used in classes
    init(copyFrom other: Self)
}

public class Addresss : CustomStringConvertible, CopyingEx
{
    var streetAddress: String
    var city: String

    init(_ streetAddress: String, _ city: String)
    {
        self.streetAddress = streetAddress
        self.city = city
    }

    required public init(copyFrom other: Addresss)
    {
        streetAddress = other.streetAddress
        city = other.city
    }

    public var description: String
    {
        return "\(streetAddress), \(city)"
    }
}

public struct Employeee: CustomStringConvertible, CopyingEx
{
    var name: String
    var address: Addresss

    init(_ name: String, _ address: Addresss)
    {
        self.name = name
        self.address = address
    }

    // C++ style copy constructor
    /* required */ public init(copyFrom other: Employeee)
    {
        name = other.name

        // one option is to do this
        //address = Address(other.address.streetAddress, other.address.city)

        // and another option is to do this
        address = Addresss(copyFrom: other.address)
    }

    public var description: String
    {
        return "My name is \(name) and I live at \(address)"
    }
}

public func CopyPrototypeMain()
{
    let john = Employeee("John", Addresss("123 London Road", "London"))


  // if employee is a class, these refer to the same obj
  // if it's a struct, a copy is made
  //var chris = john


  var chris = Employeee(copyFrom: john)
  chris.name = "Chris"
  chris.address.city = "Manchester"

  // if address is a class, they both end up in Manchester
  // if address is a struct, a copy is made

  print(chris.description)
  print(john.description)
}
