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
    
    static func fetch(context: NSManagedObjectContext?, predicate: (String,String)?, sort: [String: Bool]? = nil, limit: Int? = nil) -> [selfType]? {
        guard let context = context else {return nil}
        let request = self.fetchRequest()
        // predicate
        if let myPredicate = predicate {
            request.predicate = NSPredicate(format: myPredicate.0, myPredicate.1)
        }
        
        // limit
        if let limitNumber = limit {
            request.fetchLimit = limitNumber
        }
        
        do {
            guard let result = try context.fetch(request) as? [selfType] else { return nil }
            return result
        }catch {
            fatalError("\(error)")
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
            return false
        }
    }
    
    @discardableResult
    func update(context: NSManagedObjectContext?, attributeInfo: [String: Any?]) -> selfType?{
        guard let context = context else {return nil}
        for (key,value) in attributeInfo {
            guard let val = value as? String else { self.setNilValueForKey(key); continue }
            let type = self.entity.attributesByName[key]?.attributeType
            switch type {
            case .integer16AttributeType: fallthrough
            case .integer32AttributeType: fallthrough
            case .integer64AttributeType:
                self.setValue(Int(val), forKey: key)
            case .doubleAttributeType:
                self.setValue(Double(val), forKey: key)
            case .booleanAttributeType:
                self.setValue(Bool(val), forKey: key)

            default:
                self.setValue(val, forKey: key)
            }
        }
        
        do {
            try context.save()
            return self as? Self.selfType
        } catch{
            fatalError("\(error)")
        }
    }
}




extension Student: AHUerEntityProtocol {
    typealias selfType = Student
}

extension Course: AHUerEntityProtocol{
    typealias selfType = Course
}

extension GPA: AHUerEntityProtocol{
    typealias selfType = GPA
}

extension GradeScore: AHUerEntityProtocol{
    typealias selfType = GradeScore
}

extension Exam: AHUerEntityProtocol{
    typealias selfType = Exam
}
