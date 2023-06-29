//
//  DailyTableViewCell.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit

final class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var roundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    var diaryData: DiaryModel? {
        didSet {
            setupDailyCell()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupTableViewCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

private extension DailyTableViewCell {

    func setupTableViewCell() {
        roundView.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        roundView.layer.borderWidth = 1
        roundView.layer.cornerRadius = 5

        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = .black

        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textColor = .black

        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
    }

    func setupDailyCell() {
        titleLabel.text = diaryData?.title
        contentLabel.text = diaryData?.content
        dateLabel.text = diaryData?.dateString
    }
}
