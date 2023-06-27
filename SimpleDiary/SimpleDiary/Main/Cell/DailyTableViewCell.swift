//
//  DailyTableViewCell.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit

class DailyTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setDailyCell(_ data: DiaryModel) {

        titleLabel.font = .boldSystemFont(ofSize: 12)
        titleLabel.textColor = .black
        titleLabel.text = data.title

        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.textColor = .black
        contentLabel.text = data.content

        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.textColor = .gray
        dateLabel.text = data.content
    }
}
