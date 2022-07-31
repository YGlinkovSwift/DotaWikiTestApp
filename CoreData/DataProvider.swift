import Foundation
import CoreData

class DataProvider {
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    let persistentContainer: NSPersistentContainer = NSPersistentContainer(name: "DotaWiki")
    let repository: NetworkingManager = NetworkingManager()
    
    lazy var fetchedResultsController: NSFetchedResultsController<Item> = {
        let fetchRequest = Item.fetchRequest()
        //let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        //fetchRequest.sortDescriptors = [NSSortDescriptor(key: "heroName", ascending: true)]

        let sort = [NSSortDescriptor(key: #keyPath(Item.heroName), ascending: false), NSSortDescriptor(key: #keyPath(Item.heroPortraitImageURL), ascending: false)]
       fetchRequest.sortDescriptors = sort
       let fetchedController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext:viewContext, sectionNameKeyPath: nil, cacheName: nil)
       

       do {
           try fetchedController.performFetch()
       } catch {
           let nserror = error as NSError
           fatalError("\(nserror)")
       }

        
       return fetchedController

   }()

    //MARK: - Methods
    
    
    
    func fetchHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        repository.request(endpoint: HeroesAPI.heroes) { (result: Result<[Hero], NetworkingError>) in
            switch result {
            case .success(let dotaHeroes):
                completion(.success(dotaHeroes))
            case .failure(let error):
                completion(.failure(error))
            }
            
        let taskContext = self.persistentContainer.newBackgroundContext()
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        taskContext.undoManager = nil
        
            _ = self.syncHeroes(result: result, taskContext: taskContext)
        
        }
    }
    
    func fetchHeroesPredicate(for name: String, completion: @escaping (Result<[Hero], Error>) -> Void) {
        repository.request(endpoint: HeroesAPI.heroes) { (result: Result<[Hero], NetworkingError>) in
            switch result {
            case .success(let dotaHeroes):
                completion(.success(dotaHeroes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
        var predicate: NSPredicate?
        if !name.isEmpty {
            predicate = NSPredicate(format: "name contains[c] '\(name)' ")
        } else {
            predicate = nil
        }
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            completion(.failure(error as! NetworkingError))
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
                //taskContext.reset()
        
        successfull = true
    }
        return successfull
    }

}
