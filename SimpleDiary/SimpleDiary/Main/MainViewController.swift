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

    override func viewDidLoad() {
        super.viewDidLoad()

        setButton()
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
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: model에 데이터 개수만큼 cell 반환
        5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyTableViewCell", for: indexPath)
        // TODO: model에 데이터가 있는 cell 반환
        return cell
    }
}
