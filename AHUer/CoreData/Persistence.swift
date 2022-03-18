//
//  Persistence.swift
//  demo
//
//  Created by WeIHa'S on 2021/10/20.
//

import CoreData

/// CoreData展示仓库
struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let user = Student.insert(in: viewContext)?.update(of: ["studentName":"WHW",
                                      "studentID":"E01814133",
                                      "southisMen":"true"
                                     ])
        
        Exam.insert(in: viewContext)?.update(of: ["course":"高等数学",
                                   "location":"博北A408",
                                   "seatNum":"45",
                                   "time":"8:00-10:00",
                                   "schoolYear":"2020-2021",
                                   "schoolTerm":1
                                                 ])?.beHold(of: user!)
        
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "AHUerCoreModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}

extension NSManagedObjectContext{
    
    func saved(){
        guard self.hasChanges else { return }
        do {
            try self.save()
        }catch{
            print("📦CoreData Save Error")
        }
    }
}
