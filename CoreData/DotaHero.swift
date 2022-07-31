import Foundation
import CoreData

final class DotaHero: NSManagedObject {
    @NSManaged var heroName: String
    @NSManaged var heroPortraitImageURL: String
    
    func update(with jsonDictionary: [String: Any]) throws {
        guard let heroName = jsonDictionary["heroName"] as? String,
              let heroPortraitImageURL = jsonDictionary["heroPortraitImageURL"] as? String
        else {
            throw NSError(domain: "", code: 100, userInfo: nil)
        }
        self.heroName = heroName
        self.heroPortraitImageURL = heroPortraitImageURL
    }

}
