//
//  Student+Extension.swift
//  IOSTEST
//
//  Created by WeIHa'S on 2021/11/10.
//

import Foundation
import CoreData

/// CoreData增删改查
protocol AHUerEntityProtocol: NSManagedObject {
    associatedtype selfType
}

extension AHUerEntityProtocol{
    static func insert(context: NSManagedObjectContext?) -> selfType?{
        if let context = context,
           let entityName = self.entity().name,
           let insetData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? selfType {
            return insetData
        } else {
            return nil
        }
    }
    
    
    static func fetch(context: NSManagedObjectContext?, predicate: NSPredicate?, sort: [String: Bool]? = nil, limit: Int? = nil) -> [selfType]? {
        guard let context = context else {return nil}
        let request = self.fetchRequest()
        // predicate
        if let myPredicate = predicate {
            request.predicate = myPredicate
        }
        
        // limit
        if let limitNumber = limit {
            request.fetchLimit = limitNumber
        }
        
        do {
            guard let result = try context.fetch(request) as? [selfType] else { return nil }
            return result
        }catch {
            NSLog("查找失败")
            return nil
        }
    }
    
    @discardableResult
    func delete(context: NSManagedObjectContext?) -> Bool{
        guard let context = context else {return false}
        do {
            context.delete(self)
            try context.save()
            return true
        }catch{
            NSLog("删除失败")
            return false
        }
    }
    
    @discardableResult
    func update(context: NSManagedObjectContext?, attributeInfo: [String: Any?]) -> selfType?{
        guard let context = context else {return nil}
        for (key,value) in attributeInfo {
            guard let type = self.entity.attributesByName[key]?.attributeType else { continue }
            switch type {
            case .integer16AttributeType: fallthrough
            case .integer32AttributeType: fallthrough
            case .integer64AttributeType:
                self.setValue(Int("\(value ?? "nil")"), forKey: key)
            case .doubleAttributeType:
                self.setValue(Double("\(value ?? "nil")"), forKey: key)
            case .booleanAttributeType:
                self.setValue(Bool("\(value ?? "nil")"), forKey: key)

            default:
                self.setValue(value, forKey: key)
            }
        }
        
        do {
            try context.save()
            return self as? Self.selfType
        } catch{
            NSLog("保存失败")
            return nil
        }
    }
}




extension Student: AHUerEntityProtocol {
    typealias selfType = Student
    
    
    static func fetch(context: NSManagedObjectContext?, studentId: String) -> [Student]?{
        guard let context = context else {return nil}
        let request = self.fetchRequest()
        
        request.predicate = NSPredicate(format: "studentID = %@", studentId)
        
        do {
            return try context.fetch(request)
        }catch {
            return nil
        }
    }
    
    static func nowUser(_ context: NSManagedObjectContext?) -> Student?{
        @SetStorage(key: "AHUID", default: "") var studentID: String
        guard var students = fetch(context: context, studentId: studentID), !students.isEmpty else { return nil }
        let student = students.removeFirst()
        students.forEach({$0.delete(context: context)})
        return student
    }
    
}

extension Course: AHUerEntityProtocol{
    typealias selfType = Course
    
    static func fetch(context: NSManagedObjectContext?, courseName: String) -> [Course]?{
        let predicate = NSPredicate(format: "name = %@", courseName)
        return fetch(context: context, predicate: predicate)
    }
}

extension GPA: AHUerEntityProtocol{
    typealias selfType = GPA
}

extension Grade: AHUerEntityProtocol{
    typealias selfType = Grade
    
    static func fetch(context: NSManagedObjectContext?, schoolYear: String, schoolTerm: String) -> [Grade]?{
        let predicate = NSPredicate(format: "schoolYear = %@ AND schoolTerm = %@", schoolYear, schoolTerm)
        return fetch(context: context, predicate: predicate)
    }
}

extension Examination: AHUerEntityProtocol{
    typealias selfType = Examination
}
