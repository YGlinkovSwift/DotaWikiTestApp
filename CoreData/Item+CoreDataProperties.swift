import Foundation
import CoreData

extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var heroName: String?
    @NSManaged public var heroPortraitImageURL: String?

}

extension Item : Identifiable {

}
