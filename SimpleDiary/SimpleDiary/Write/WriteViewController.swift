//
//  WriteViewController.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit

final class WriteViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var saveButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setButton()
    }
}

private extension WriteViewController {

    func setupView() {
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
        saveButton.addTarget(self, action: #selector(backTapped(_ :)), for: .touchUpInside)
    }

    @objc func backTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
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
