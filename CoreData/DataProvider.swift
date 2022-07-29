import Foundation
import CoreData

class DataProvider {
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "DotaWiki")
    let repository: NetworkingManager = NetworkingManager()


    func fetchHeroes(completion: @escaping (Error?) -> Void) {
        repository.request(endpoint: HeroesAPI.heroes) { (result: Result<[Hero], NetworkingError>) in
            switch result {
            case .success(let dotaHeroes):
                print(dotaHeroes)
            case .failure(let error):
                print(error)
                
            }
            
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
            _ = self.syncHeroes(result: result, taskContext: taskContext)
        
        completion(nil)
            
        }
    }
    
    private func syncHeroes(result: Result<[Hero], NetworkingError>, taskContext: NSManagedObjectContext) -> Bool {
        var successfull = false
        taskContext.performAndWait {
            let matchingHeroRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
            let heroName = result.map { [$0[0].heroName] }
            matchingHeroRequest.predicate = NSPredicate(format: "heroName in %@", argumentArray: [heroName])

                do {
                   //try taskContext.save()
                } catch {
                    print("error")
                }
                taskContext.reset()
        
        successfull = true
    }
        return successfull
    }
}
