import Foundation

class DatabaseDataSource {
    
    private let coreDataStack = CoreDataStack()
    lazy var managedContext = coreDataStack.persistentContainer.viewContext
    
    func getItems(completion: ([ToDoListItem]) -> Void) {
        do {
            let items = try managedContext.fetch(ToDoListItem.fetchRequest())
            completion(items)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func createItem(name: String, completion: (Bool) -> Void) {
        let newItem = ToDoListItem(context: managedContext)
        newItem.name = name
        newItem.createdAt = Date()
        
        do {
            try managedContext.save()
            completion(true)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteItem(item: ToDoListItem) {
        managedContext.delete(item)
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func updateItem(item: ToDoListItem, newName: String, completion: (Bool) -> Void) {
        item.name = newName
        
        do {
            try managedContext.save()
            completion(true)
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
}
