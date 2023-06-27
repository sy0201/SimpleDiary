//
//  DiaryModel+CoreDataProperties.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//
//

import Foundation
import CoreData


extension DiaryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DiaryModel> {
        return NSFetchRequest<DiaryModel>(entityName: "DiaryModel")
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var date: Date?

}

extension DiaryModel : Identifiable {

}
