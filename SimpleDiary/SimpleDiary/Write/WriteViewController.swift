//
//  WriteViewController.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit
import CoreData

final class WriteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!

    var titleText: String = ""
    var contentText: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setButton()
    }
}

private extension WriteViewController {

    func setupView() {
//        print("saveResult:", saveCoreData(title: "일기제목저장", content: "일기내용저장~~"))
//        do {
//            let array: [NSManagedObject] = try readCoreData()!
//            print(array)
//        } catch {
//            print(error)
//        }
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .black
        titleLabel.text = "제목"

        titleTextField.placeholder = "제목을 입력해주세요."

        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.textColor = .black
        contentLabel.text = "내용"

        contentTextView.delegate = self

        contentTextView.text = "내용을 입력해주세요."
        contentTextView.textColor = .gray

        contentTextView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 5

        dateTitle.font = .systemFont(ofSize: 15)
        dateTitle.textColor = .black
        dateTitle.text = "날짜를 선택해주세요."

        saveButton.setTitle("저장", for: .normal)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.backgroundColor = .gray
    }

    func setButton() {
        saveButton.addTarget(self, action: #selector(saveTapped(_ :)), for: .touchUpInside)
    }

    @objc func saveTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }

    func saveCoreData(title: String, content: String) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }

        let newDiaryContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "DiaryModel", in: newDiaryContext)!

        let object = NSManagedObject(entity: entity, insertInto: newDiaryContext)

        object.setValue(title, forKey: "title")
        object.setValue(content, forKey: "content")
        object.setValue(Date(), forKey: "date")

        do {
            // data 저장
            try newDiaryContext.save()
            return true
        } catch let error as NSError {
            // 에러 발생시
            print("Could not save. \(error), \(error.userInfo)")
            return false
        }
    }

    func readCoreData() throws -> [NSManagedObject]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        let newDiaryContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DiaryModel")

        do {
            // fetchRequest를 통해 newDiaryContext로부터 결과 배열을 가져오기
            let resultCDArray = try newDiaryContext.fetch(fetchRequest)
            return resultCDArray
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            throw error
        }
    }
}

extension WriteViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        guard contentTextView.textColor == .gray else { return }

        contentTextView.text = nil
        contentTextView.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text == "" {
            contentTextView.text = "내용을 입력해주세요."
            contentTextView.textColor = .gray
        }
    }
}
