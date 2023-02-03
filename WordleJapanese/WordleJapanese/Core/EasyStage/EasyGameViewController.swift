//
//  GameViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/07/16.
//

import UIKit
import RealmSwift

class EasyGameViewController: UIViewController {
    // MARK: - Properties
    let answers = ["あおい", "きかう","あかく", "おおい"]
    
    let localRealm = try! Realm()
    var tasks: Results<WordList>!
    
    var answer = ""
    private var guesses: [[Character?]] = Array(
        repeating: Array(repeating: nil, count: 3),
        count: 5
    )
    let keyboardVC = EasyKeyboardViewController()
    let boardVC = EasyBoardViewController()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answer = answers.randomElement() ?? ""
        view.backgroundColor = .systemGray6
        addChildren()
        setConstraints()
        didTapCustomBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    // MARK: - Handlers
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
    }
    
    private func setConstraints(){
        addConstraints()
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
    
    // MARK: - Constraints

    func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),

            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension EasyGameViewController: EasyKeyboardViewControllerDelegate {
    func EasykeyboardViewController(_ vc: EasyKeyboardViewController, didTapKey letter: Character) {

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

extension EasyGameViewController: EasyBoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }

    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section

        let count = guesses[rowIndex].compactMap({ $0 }).count
        guard count == 3 else {
            return nil
        }

        let indexedAnswer = Array(answer)

        guard let letter = guesses[indexPath.section][indexPath.row], indexedAnswer.contains(letter) else {
            return hexStringToUIColor(hex: "#757575")
        }
        
        if indexedAnswer[indexPath.row] == letter {
            return hexStringToUIColor(hex: "#A0CE85")
        }
        return hexStringToUIColor(hex: "#EFC94C")
    }
}
