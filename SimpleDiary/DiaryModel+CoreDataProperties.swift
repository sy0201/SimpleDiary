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

    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let date = self.date else { return ""}
        let savedDateString = dateFormatter.string(from: date)
        return savedDateString
    }
}

extension DiaryModel : Identifiable {

}
