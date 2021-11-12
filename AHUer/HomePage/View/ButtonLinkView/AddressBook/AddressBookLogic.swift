//
//  AddressBookLogic.swift
//  AHUer
//
//  Created by WeIHa'S on 2021/9/12.
//

import Foundation

class AddressBookLogic: ObservableObject {
    @Published var model: [AddressBookData]
    fileprivate var sources: [String] = ["常用","教务处","团委","学生处","财务处","保卫处","宿舍","物业","校医院"]
    
    fileprivate var addresses: [[(String,String)]] = [
        [("网络服务中心","0551-63861118"),
         ("一卡通办公室","0551-63861077"),
         ("报警电话","0551-63861110"),
         ("校医院值班电话","0551-63861120"),
         ("物业办公室","0551-63861044"),
         ("物业修缮服务室","0551-63861114"),
         ("考试考务中心","0551-63861053"),
         ("学生资助管理中心","0551-63861008"),
         ("大学生勤俭中心","0551-63861181"),
         ("校园图书","0551-63861109")],
        
        [("综合办公室","0551-63861055"),
         ("考试考务中心","0551-63861053"),
         ("教学质量科","0551-63861235"),
         ("教学运行中心","0551-63861203"),
         ("学籍管理科","0551-63861202")],
        
        [("团委办公室","0551-63861121"),
         ("创服中心","0551-63861550"),
         ("社团联合员会","0551-63861182"),
         ("大学生勤俭中心","0551-63861181"),
         ("团学宣传中心","0551-63861662")],
        
        [("学生思想教育科","0551-63861054"),
         ("学生管理科","0551-63861900"),
         ("学生资助管理中心","0551-63861008"),
         ("就业指导中心","0551-63861355")],
        
        [("办公室","0551-63861569"),
         ("收费管理科","0551-63861561")],
        
        [("办公室","0551-63861224"),
         ("户籍室","0551-63861184"),
         ("报警电话","0551-63861110")],
        
        [("桃园","0551-63861034"),
         ("李园","0551-63861037"),
         ("桔园","0551-63861036"),
         ("枣园","0551-63861218"),
         ("榴园","0551-63861217"),
         ("杏园","0551-63861219"),
         ("松园","0551-63861160"),
         ("竹园","0551-63861115"),
         ("梅园","0551-63861113"),
         ("桂园","0551-63861097"),
         ("枫园","0551-63861096"),
         ("槐园","0551-63861081")],
        
        [("办公室","0551-63861044"),
         ("修缮服务室","0551-63861114")],
        
        [("24小时值班电话","0551-63861120"),
         ("校医疗保障办公室","0551-65108781")],
    ]
    
    init() {
        model = []
        for (index,source) in sources.enumerated() {
            var content: [AddressBookData.Tel] = []
            for (j,tel) in addresses[index].enumerated() {
                content.append(AddressBookData.Tel(id: j, title: tel.0, telNum: tel.1))
            }
            model.append(AddressBookData(id: index, title: source, content: content))
        }
    }
    
    var sourceName: [String]{
        return model.map({$0.title})
    }
    
    deinit {
        print("🌀AddressBookLogic released")
    }
    
}


struct AddressBookData: Identifiable {
    var id: Int
    var title: String
    var content: [Tel]

    struct Tel: Identifiable{
        var id: Int
        var title: String
        var telNum: String
    }
}

