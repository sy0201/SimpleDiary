//
//  ViewController.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var writeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    let diaryManager = DiaryDataManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
}

private extension MainViewController {

    func setButton() {
        writeButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }

    @objc func buttonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Write", bundle: nil)

        guard let pushVC = storyboard.instantiateViewController(withIdentifier: "WriteViewController") as? WriteViewController else { return }
        self.navigationController?.pushViewController(pushVC, animated: true)
    }

    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "DailyTableViewCell", bundle: nil), forCellReuseIdentifier: "DailyTableViewCell")
    }
}

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        diaryManager.readDiaryData().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell", for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }

        let diaryData = diaryManager.readDiaryData()
        cell.diaryData = diaryData[indexPath.row]

        return cell
    }
}

extension MainViewController: UITableViewDelegate {

}
