//
//  DiaryDataManager.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/28.
//

import UIKit
import CoreData

class DiaryDataManager {

    static let shared: DiaryDataManager = DiaryDataManager()
    private init() {}

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    lazy var context = appDelegate?.persistentContainer.viewContext

    let modelName: String = "DiaryModel"

    // MARK: - 데이터 생성

    func saveDiaryData(title: String, content: String, date: Date, completion: @escaping () -> ()) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {

                if let diaryModel = NSManagedObject(entity: entity, insertInto: context) as? DiaryModel {

                    diaryModel.title = title
                    diaryModel.content = content
                    diaryModel.date = date

                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }

    // MARK: - 데이터 읽기

    func readDiaryData() -> [DiaryModel]{
        var diaryList: [DiaryModel] = []

        if let context = context {
            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            let date = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [date]

            do {
                if let resultDiaryList = try context.fetch(request) as? [DiaryModel] {
                    diaryList = resultDiaryList
                }
            } catch {
                print("읽기 실패")
            }
        }
        return diaryList
    }

    //MARK: - 데이터 삭제

    func deleteDiaryData(diaryModel: DiaryModel, completion: @escaping () -> ()) {
        guard let date = diaryModel.date else {
            completion()
            return
        }
        // 저장된 데이터가 있는지 확인
        if let context = context {

            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)

            do {
                if let fetchedDiaryList = try context.fetch(request) as? [DiaryModel] {

                    if let targetDiary = fetchedDiaryList.first {
                        context.delete(targetDiary)

                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("삭제 실패")
                completion()
            }
        }
    }

    // MARK: - 데이터 업데이트

    func updateDiary(newData: DiaryModel, completion: @escaping () -> ()) {
        guard let date = newData.date else {
            completion()
            return
        }

        if let context = context {

            let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)

            do {
                if let fetchDiaryList = try context.fetch(request) as? [DiaryModel] {

                    if var targetDiary = fetchDiaryList.first {

                        targetDiary = newData

                        if context.hasChanges {
                            do {
                                try context.save()
                                completion()
                            } catch {
                                print(error)
                                completion()
                            }
                        }
                    }
                }
                completion()
            } catch {
                print("업데이트 실패")
                completion()
            }
        }
    }
}
