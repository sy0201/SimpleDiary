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

    var originalButtonFrame: CGRect?

    let diaryManager = DiaryDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setButton()
        setKeyboardObserver()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){

        self.view.endEditing(true)
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
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
    }

    func setButton() {
        saveButton.addTarget(self, action: #selector(saveTapped(_ :)), for: .touchUpInside)
    }

    @objc func saveTapped(_ sender: UIButton) {
        diaryManager.saveDiaryData(title: titleTextField.text ?? "", content: contentTextView.text, date: Date()) {
            self.navigationController?.popViewController(animated: true)
        }
    }

    func setKeyboardObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height

            if originalButtonFrame == nil {
                originalButtonFrame = saveButton.frame
            }

            let newY = UIScreen.main.bounds.height - keyboardHeight - saveButton.frame.size.height - 60
            let newButtonFrame = CGRect(x: saveButton.frame.origin.x, y: newY, width: saveButton.frame.size.width, height: saveButton.frame.size.height)

            UIView.animate(withDuration: 0.3) {
                self.saveButton.frame = newButtonFrame
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let originalFrame = originalButtonFrame {
            UIView.animate(withDuration: 0.3) {
                self.saveButton.frame = originalFrame
            }
            originalButtonFrame = nil
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
