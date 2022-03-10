//
//  Student+Extension.swift
//  IOSTEST
//
//  Created by WeIHa'S on 2021/11/10.
//

import Foundation
import CoreData
import SwiftUI
import SwiftyJSON

/// CoreData增删改查
protocol AHUerPrimaryEntity: NSManagedObject {
    
}

extension AHUerPrimaryEntity{
    
    static var defaultcontext: NSManagedObjectContext {
        return PersistenceController.shared.container.viewContext
    }
    
    /// 增
    static func insert(in context: NSManagedObjectContext = defaultcontext) -> Self? {
        return Self(context: context)
    }
    

    /// 查
    /// - Parameters:
    ///   - predicate: 谓词
    ///   - sort: 排序规则
    ///   - limit: 限制个数
    ///   - context: 查询上下文
    /// - Returns: 查询结果
    static func fetch(by predicate: NSPredicate?, sort: [String : Bool]? = nil, limit: Int? = nil, in context: NSManagedObjectContext = defaultcontext) -> [Self]? {
        let request = Self.fetchRequest()
        
        // predicate
        if let myPredicate = predicate {
            request.predicate = myPredicate
        }
        
        // sort
        if let mySort = sort {
            var sortArr: [NSSortDescriptor] = []
            for (key, ascending) in mySort {
//                sortArr.append(NSSortDescriptor(keyPath: key, ascending: ascending))
                sortArr.append(NSSortDescriptor(key: key, ascending: ascending))
            }
            request.sortDescriptors = sortArr
        }
        
        
        // limit
        if let limitNumber = limit {
            request.fetchLimit = limitNumber
        }
        
        do {
            guard let result = try context.fetch(request) as? [Self] else { return nil }
            return result
        }catch {
            print("📦CoreData Fetch Error")
            return nil
        }
    }
    
    
    /// 删
    /// - Returns: 删除结果
    @discardableResult
    func delete() -> Bool {
        guard let context = self.managedObjectContext else { return false }
        context.delete(self)
        do {
            if context.hasChanges {
                try context.save()
                return true
            }
        }catch {
            print("📦CoreData Delete Error")
        }
        return false
    }
    
   
    /// 改
    @discardableResult
    func update(of attributeInfo: JSON) -> Self? {
        guard let context = self.managedObjectContext else { return self }
        for (key,value) in attributeInfo.dictionaryValue {
            guard let type = self.entity.attributesByName[key]?.attributeType else { continue }
            switch type {
            case .integer16AttributeType: fallthrough
            case .integer32AttributeType: fallthrough
            case .integer64AttributeType:
                self.setValue(value.intValue, forKey: key)
            case .doubleAttributeType:
                self.setValue(value.doubleValue, forKey: key)
            case .booleanAttributeType:
                self.setValue(value.boolValue, forKey: key)
            case .stringAttributeType:
                self.setValue(value.stringValue, forKey: key)
            default:
                guard let str = value.string else { break }
                self.setValue(str, forKey: key)
            }
        }
        
        do {
            if context.hasChanges {
                try context.save()
            }
        }catch {
            print("📦CoreData Update Error")
        }
        return self
    }
    
    @discardableResult
    func update(of attributeInfo: [String:Any]) -> Self?{
        let json = JSON(attributeInfo)
        return update(of: json)
    }
    

    /// 打包,用于同时生成许多个无主实例
    /// - Parameter attributes: 原始参数json
    /// - Returns: 打包结果集合
    static func pack(attributes: [JSON], in context: NSManagedObjectContext) -> NSSet {
        var result: Set<Self> = []
        for attribute in attributes {
            guard let A = Self.insert(in: context)?.update(of: attribute) else { continue }
            result.insert(A)
        }
        
        return NSSet(set: result)
    }
    
    
    /// 保存
    func toSaved(){
        guard let context = self.managedObjectContext, context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            print("📦CoreData Save Error")
        }
    }
    

}

protocol AHUerChildEntity: AHUerPrimaryEntity {
    associatedtype ownerType: NSManagedObject
    var owner: ownerType? { get set }
}

extension AHUerChildEntity {
    @discardableResult
    func beHold(of owner: ownerType) -> Self?{
        self.owner = owner
        toSaved()
        return self
    }
}


// MARK: Student
extension Student: AHUerPrimaryEntity {

    static func fetch(studentId: String, in context: NSManagedObjectContext = defaultcontext) -> Student? {
        let request = self.fetchRequest()
        request.predicate = NSPredicate(format: "studentID = %@", studentId)
        do {
            let students = try context.fetch(request)
            for (index,student) in students.enumerated() where index != 0 {
                student.delete()
            }
            return students.first
        }catch {
            return nil
        }
    }
    
    static func nowUser(in context: NSManagedObjectContext = defaultcontext) -> Student? {
        @AppStorage(UserDefaultsKey.AHUID.rawValue, store: .standard) var userID = ""
        return fetch(studentId: userID, in: context)
    }
    
    
    static func cleanUp(in context: NSManagedObjectContext = defaultcontext){
        guard let students = Student.fetch(by: nil, in: context) else { return }
        return students.forEach({$0.delete()})
    }
    
    func updataCourses(courses: NSSet){
        self.courses = courses
        self.toSaved()
    }
    
    func updataExams(exams: NSSet){
        self.exams = exams
        self.toSaved()
    }
}



// MARK: Course
extension Course: AHUerChildEntity {
    typealias ownerType = Student

    static func fetch(courseName: String, in context: NSManagedObjectContext = defaultcontext) -> [Course]?{
        let predicate = NSPredicate(format: "name = %@", courseName)
        return fetch(by: predicate, in: context)
    }
    
}


// MARK: GPA
extension GPA: AHUerChildEntity{
    typealias ownerType = Grade
}



// MARK: Grade
extension Grade: AHUerChildEntity{
    typealias ownerType = Student
    
    static func fetch(schoolYear: String, schoolTerm: String, in context: NSManagedObjectContext = defaultcontext) -> [Grade]?{
        let predicate = NSPredicate(format: "schoolYear = %@ AND schoolTerm = %@", schoolYear, schoolTerm)
        return fetch(by: predicate,in: context)
    }
}

// MARK: Exam
extension Exam: AHUerChildEntity{
    typealias ownerType = Student
}
