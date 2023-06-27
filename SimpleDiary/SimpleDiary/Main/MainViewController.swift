//
//  ViewController.swift
//  SimpleDiary
//
//  Created by siyeon park on 2023/06/27.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet weak var writeButton: UIButton!

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
}
