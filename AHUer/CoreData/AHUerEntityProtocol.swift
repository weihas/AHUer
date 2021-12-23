//
//  Student+Extension.swift
//  IOSTEST
//
//  Created by WeIHa'S on 2021/11/10.
//

import Foundation
import CoreData
import SwiftUI

/// CoreData增删改查
protocol AHUerEntityProtocol: NSManagedObject {
    associatedtype selfType
}

extension AHUerEntityProtocol{
    
    static var context: NSManagedObjectContext{
        get { PersistenceController.shared.container.viewContext }
    }
    
    static func insert() -> selfType?{
        return Self(context: Self.context) as? selfType
    }
    
    static func fetch(by predicate: NSPredicate?, sort: [String : Bool]? = nil, limit: Int? = nil) -> [selfType]? {
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
            guard let result = try context.fetch(request) as? [selfType] else { return nil }
            return result
        }catch {
            print("📦CoreData Fetch Error")
            return nil
        }
    }
    
    @discardableResult
    func delete() -> Bool{
        Self.context.delete(self)
        do {
            guard Self.context.hasChanges else { return true }
            try Self.context.save()
            return true
        }catch {
            print("📦CoreData Delete Error")
            return false
        }
    }
    
    @discardableResult
    func update(of attributeInfo: [String: Any?]) -> selfType?{
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
            if Self.context.hasChanges{
                try Self.context.save()
            }
        }catch {
            print("📦CoreData Updata Error")
        }
        
        return self as? Self.selfType
    }
}



// MARK: Student
extension Student: AHUerEntityProtocol {
    typealias selfType = Student
    
    
    static func fetch(studentId: String) -> [Student]?{
        let request = self.fetchRequest()
        request.predicate = NSPredicate(format: "studentID = %@", studentId)
        
        do {
            return try context.fetch(request)
        }catch {
            return nil
        }
    }
    
    static func nowUser() -> Student?{
        @AppStorage("AHUID", store: .standard) var userID = ""
        guard var students = fetch(studentId: userID), !students.isEmpty else { return nil }
        let student = students.removeFirst()
        students.forEach({$0.delete()})
        return student
    }
    
    
    @discardableResult
    static func cleanUp()-> Bool{
        guard let students = Student.fetch(by: nil) else {return false}
        return students.map({$0.delete()}).filter({!$0}).isEmpty
    }
    
    func updataCourses(courses: NSSet){
        self.courses = courses
        self.managedObjectContext?.saved()
//        Self.context.saved()
    }
    
    func updataExams(exams: NSSet){
        self.exams = exams
        Self.context.saved()
    }
}


// MARK: Course
extension Course: AHUerEntityProtocol{
    typealias selfType = Course
    
    static func fetch(courseName: String) -> [Course]?{
        let predicate = NSPredicate(format: "name = %@", courseName)
        return fetch(by: predicate)
    }
    
    @discardableResult
    func beHolded(by owner: Student) -> Course{
        owner.addToCourses(self)
        Self.context.saved()
        return self
    }
    
    static func inserts(courses: [[String:Any]]) -> NSSet{
        var result: Set<Course> = []
        for course in courses {
            guard let c = Course.insert()?.update(of: course) else { continue }
            result.insert(c)
        }
        return NSSet(set: result)
    }
    
}

// MARK: GPA
extension GPA: AHUerEntityProtocol{
    typealias selfType = GPA
    
    @discardableResult
    func beHolded(by owner: Grade) -> GPA{
        owner.addToGpas(self)
        Self.context.saved()
        return self
    }
    
    static func inserts(gpas: [[String:Any]?]?) -> NSSet{
        guard let gpas = gpas else { return NSSet() }
        var result: Set<GPA> = []
        for gpa in gpas {
            guard let gpa = gpa, let g = GPA.insert()?.update(of: gpa) else { continue }
            result.insert(g)
        }
        return NSSet(set: result)
    }
}


// MARK: Grade
extension Grade: AHUerEntityProtocol{
    typealias selfType = Grade
    
    static func fetch(schoolYear: String, schoolTerm: String) -> [Grade]?{
        let predicate = NSPredicate(format: "schoolYear = %@ AND schoolTerm = %@", schoolYear, schoolTerm)
        return fetch(by: predicate)
    }
    
    func addGpas(gpas: NSSet){
        self.addToGpas(gpas)
        Self.context.saved()
    }
    
    @discardableResult
    func beHold(of owner: Student) -> Grade{
        owner.addToGrades(self)
        Self.context.saved()
        return self
    }
}

// MARK: Exam
extension Exam: AHUerEntityProtocol{
    typealias selfType = Exam
    
    static func inserts(exmas: [[String:Any]]) -> NSSet{
        var result: Set<Exam> = []
        for exam in exmas {
            guard let e = Exam.insert()?.update(of: exam) else { continue }
            result.insert(e)
        }
        return NSSet(set: result)
    }
}
