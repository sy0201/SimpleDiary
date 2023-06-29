//
//  WriteViewController.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit
import CoreData

final class EditViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!

    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var editButton: UIButton!

    var originalButtonFrame: CGRect?

    let diaryManager = DiaryDataManager.shared
    var diaryData: DiaryModel?

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

private extension EditViewController {

    func setupView() {
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .red
        titleLabel.text = "제목을 수정해주세요."

        if let diarydate = self.diaryData {
            titleTextField.text = diaryData?.title
            contentTextView.text = diaryData?.content
        } else {

        }

        contentLabel.font = .systemFont(ofSize: 15)
        contentLabel.textColor = .red
        contentLabel.text = "내용을 수정해주세요."

        contentTextView.delegate = self

        contentTextView.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.1)
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.cornerRadius = 5

        dateTitle.font = .systemFont(ofSize: 15)
        dateTitle.textColor = .black
        dateTitle.text = "날짜를 선택해주세요."

        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.setTitleColor(.white, for: .normal)
        deleteButton.backgroundColor = .lightGray
        deleteButton.clipsToBounds = true
        deleteButton.layer.cornerRadius = 8

        editButton.setTitle("수정", for: .normal)
        editButton.setTitleColor(.white, for: .normal)
        editButton.backgroundColor = .blue
        editButton.clipsToBounds = true
        editButton.layer.cornerRadius = 8
    }

    func setButton() {
        deleteButton.addTarget(self, action: #selector(deleteTapped(_:)), for: .touchUpInside)

        editButton.addTarget(self, action: #selector(editTapped(_ :)), for: .touchUpInside)
    }

    @objc func deleteTapped(_ sender: UIButton) {

//        diaryManager.deleteDiaryData(diaryModel: <#T##DiaryModel#>, completion: <#T##() -> ()#>)

    }

    @objc func editTapped(_ sender: UIButton) {

        if let diaryData = self.diaryData {
            diaryData.title = titleTextField.text
            diaryData.content = contentTextView.text

            diaryManager.updateDiary(newData: diaryData) {
                print("수정 완료")
                self.navigationController?.popViewController(animated: true)
            }
        } else {

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
                originalButtonFrame = buttonStackView.frame
            }

            let newY = UIScreen.main.bounds.height - keyboardHeight - buttonStackView.frame.size.height - 60
            let newButtonFrame = CGRect(x: buttonStackView.frame.origin.x, y: newY, width: buttonStackView.frame.size.width, height: buttonStackView.frame.size.height)

            UIView.animate(withDuration: 0.3) {
                self.buttonStackView.frame = newButtonFrame
            }
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        if let originalFrame = originalButtonFrame {
            UIView.animate(withDuration: 0.3) {
                self.buttonStackView.frame = originalFrame
            }
            originalButtonFrame = nil
        }
    }
}

extension EditViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        guard contentTextView.textColor == .gray else { return }

        contentTextView.text = nil
        contentTextView.textColor = .black
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text == "" {
            contentTextView.text = "내용을 수정해주세요."
            contentTextView.textColor = .gray
        }
    }
}
