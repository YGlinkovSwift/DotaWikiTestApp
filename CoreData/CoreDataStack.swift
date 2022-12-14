import Foundation
import CoreData

final class CoreDataStack {

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataEnums.containerName)
        container.loadPersistentStores(completionHandler:  { (_, error) in
            guard let error = error as NSError? else {
                return
            }
            self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
}
