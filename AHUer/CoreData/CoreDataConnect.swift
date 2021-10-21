//
//  CoreDataConnect.swift
//  IOSTEST
//
//  Created by WeIHa'S on 2021/10/21.
//

import Foundation
import CoreData

class CoreDataConnect{
    let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext){
        self.context = context
    }
    
    @discardableResult
    /// CoreData仓库插值
    /// - Parameters:
    ///   - myEntityName: 仓库名称
    ///   - attributeInfo: 属性
    /// - Returns: 是否成功
    func insert(myEntityName: String, attributeInfo: [String: String]) -> Bool {
        let insetData = NSEntityDescription.insertNewObject(forEntityName: myEntityName, into: self.context)
        for (key,value) in attributeInfo {
            let type = insetData.entity.attributesByName[key]?.attributeType
            switch type{
            case .integer16AttributeType: fallthrough
            case .integer32AttributeType: fallthrough
            case .integer64AttributeType:
                insetData.setValue(Int(value), forKey: key)
            case .booleanAttributeType:
                insetData.setValue(Bool(value), forKey: key)
            default:
                insetData.setValue(value, forKey: key)
            }
            do{
                try context.save()
                return true
            }catch{
                fatalError("\(error)")
            }
        }
        return false
    }
    
    @discardableResult
    /// 查找仓库值
    /// - Parameters:
    ///   - myEntityName: 仓库名
    ///   - predicate: p
    ///   - sort: 排序
    ///   - limit: 限制
    /// - Returns: 查找结果
    func fetch(myEntityName: String, predicate: String?, sort: [String: Bool]?, limit: Int?) -> Any?{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: myEntityName)
        
        // predicate
          if let myPredicate = predicate {
              request.predicate =
                NSPredicate(format: myPredicate)
          }

          // limit
          if let limitNumber = limit {
              request.fetchLimit = limitNumber
          }
        
        do {
            let result = try context.fetch(request)
            return result
        }catch {
            fatalError("\(error)")
            return nil
        }
    }
    
    
    
    
    
}
