import Foundation


// A class should have only one reason to change
// Separation of concern - different classes handling different, independent tasks/ problem
public class Journal: CustomStringConvertible {
    var entries = [String]()
    var count = 0

    func addEntry(_ text: String) -> Int {
        count += 1
        entries.append("\(count): \(text)")
        return count - 1
    }

    func removeEntry(_ index: Int)
    {
        entries.remove(at: index)
    }

    public var description: String
    {
        return entries.joined(separator: "\n")
    }

    func save(_ filename: String, _ overwrite: Bool = false)
    {
        // save to a file
    }

    func load(_ filename: String) {}
}

public class Persistence
{
  func saveToFile(_ journal: Journal,
    _ filename: String, _ overwrite: Bool = false)
  {

  }
}

public func srpMain()
{
  let j = Journal()
  let _ = j.addEntry("I cried today")
  let bug = j.addEntry("I ate a bug")
  print(j)

  j.removeEntry(bug)
  print("===")
  print(j)

  let p = Persistence()
  let filename = "/mnt/c/sdjfhskdjhfg"
  p.saveToFile(j, filename, false)
}
