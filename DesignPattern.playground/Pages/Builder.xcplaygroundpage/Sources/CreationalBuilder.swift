// A builder is a separate component for building an object
// can either give builder a init or return it via static func
// to make builder fluent return self
// diff facets of an obj can be built with diff builders wokring in tandem via base class

/*

Builder provide a API to construct an obj step by step

*/

import Foundation

public class HtmlElement : CustomStringConvertible
{
    var name = ""
    var text = ""
    var elements = [HtmlElement]()
    private let indentSize = 2

    init() {}
    init(name: String, text: String)
    {
        self.name = name
        self.text = text
    }

    private func description
    (_ indent:Int) -> String
    {
        var result = ""
        let i = String(repeating: " ", count: indent)
        result += "\(i)<\(name)>\n"

        if (!text.isEmpty)
        {
            result += String(repeating: " ", count: indentSize * (indent + 1))
            result += text
            result += "\n"
        }

        for e in elements
        {
            result += e.description(indent+1)
        }

        result += "\(i)</\(name)>\n"

        return result
    }

    public var description: String
    {
        return description(0)
    }
}

public class HtmlBuilder : CustomStringConvertible
{
    private let rootName: String
    var root = HtmlElement()

    init(rootName: String)
    {
        self.rootName = rootName
        root.name = rootName
    }

    // not fluent
    func addChild
    (name: String, text: String)
    {
        let e = HtmlElement(name:name, text:text)
        root.elements.append(e)
    }

    func addChildFluent
    (childName: String, childText: String)
    -> HtmlBuilder
    {
        let e = HtmlElement(name:childName, text:childText)
        root.elements.append(e)
        return self
    }

    public var description: String
    {
        return root.description
    }

    func clear()
    {
        root = HtmlElement(name: rootName, text: "")
    }
}

public func builderMain()
{
    // if you want to build a simple HTML paragraph
    // using an ordinary string
    let hello = "hello"
    var result = "<p>\(hello)</p>"
    print(result)

    // now I want an HTML list with 2 words in it
    let words = ["hello", "world"]
    result = "<ul>"
    for word in words
    {
        result.append("<li>\(word)</li>")
    }
    result.append("</ul>")
    print(result)

    // ordinary non-fluent builder
    let builder = HtmlBuilder(rootName: "ul")
    builder.addChild(name:"li", text:"hello")
    builder.addChild(name:"li", text:"world")
    print(builder)
}

/// Builder facet

public class Person : CustomStringConvertible
{
    // address
    var streetAddress = "", postcode = "", city = ""

    // employment
    var companyName = "", position = ""
    var annualIncome = 0

    public var description: String {
        return "I live at \(streetAddress), \(postcode), \(city). " +
        "I work at \(companyName) as a \(position) earning \(annualIncome)."
    }
}

public class PersonBuilder
{
    var person = Person()
    var lives : PersonAddressBuilder {
        return PersonAddressBuilder(person)
    }
    var works : PersonJobBuilder {
        return PersonJobBuilder(person)
    }

    // no implicit conversions, so...
    func build() -> Person
    {
        return person
    }
}

public class PersonJobBuilder : PersonBuilder
{
    internal init(_ person:Person)
    {
        super.init()
        self.person = person
    }

    func at(_ companyName: String) -> PersonJobBuilder
    {
        person.companyName = companyName
        return self
    }

    func asA(_ position: String) -> PersonJobBuilder
    {
        person.position = position
        return self
    }

    func earning(_ annualIncome: Int) -> PersonJobBuilder
    {
        person.annualIncome = annualIncome
        return self
    }
}

public class PersonAddressBuilder : PersonBuilder
{
    internal init(_ person: Person)
    {
        super.init()
        self.person = person
    }

    func at(_ streetAddress: String) -> PersonAddressBuilder
    {
        person.streetAddress = streetAddress
        return self
    }

    func withPostcode(_ postcode: String) -> PersonAddressBuilder
    {
        person.postcode = postcode
        return self
    }

    func inCity(_ city: String) -> PersonAddressBuilder
    {
        person.city = city
        return self
    }
}

public func builderFacetmain()
{
  let pb = PersonBuilder()
  let p = pb
    .lives.at("123 London Road").inCity("London").withPostcode("SW12BC")
    .works.at("Fabrikam").asA("Engineer").earning(123000)
    .build();
  print(p)
}
