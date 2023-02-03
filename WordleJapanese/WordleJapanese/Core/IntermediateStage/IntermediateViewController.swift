//
//  intermediateViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/12.
//

import UIKit

class IntermediateGameViewController: UIViewController {
    let answers = ["かきかた", "にせもの", "さそもお", "くさすせ"]

    var answer = ""
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 4),
        count: 5
    )
    let keyboardVC = IntermediateKeyboardViewController()
    let boardVC = IntermediateBoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        answer = answers.randomElement() ?? ""
        view.backgroundColor = .systemGray6
        addChildren()
    }

    private func addChildren() {
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)

        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        boardVC.datasource = self
        view.addSubview(boardVC.view)

        addConstraints()
        didTapCustomBackButton()
    }

    func addConstraints() {
            NSLayoutConstraint.activate([
                boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
                boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.58),

                keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ])
    }
    
    private func didTapCustomBackButton() {
        var backImage = UIImage(systemName: "chevron.backward")
        backImage = backImage?.resizeImage(newWidth: 18)
            
        let backButton = UIButton()
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
            
        let backBtn = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    @objc private func didTapBackButton() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension IntermediateGameViewController: IntermediateKeyboardViewControllerDelegate {
    func IntermediatekeyboardViewController(_ vc: IntermediateKeyboardViewController, didTapKey letter: Character) {

        // Update guesses
        var stop = false

        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }

            if stop {
                break
            }
        }

        boardVC.reloadData()
    }
}

extension IntermediateGameViewController: IntermediateBoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }

    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 4 else {
            return nil
        }

        let indexedAnswer = Array(answer)

        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return hexStringToUIColor(hex: "#757575")
        }

        if indexedAnswer[indexPath.row] == letter {
            return hexStringToUIColor(hex: "#A0CE85")
        }
        
        for num in 0..<5 {
            if guesses[num] == indexedAnswer {
                let secondVC = storyboard?.instantiateViewController(withIdentifier: "SuccessVC")
                navigationController?.pushViewController(secondVC!, animated: true)
            }
        }

        return hexStringToUIColor(hex: "#EFC94C")
    }
}


