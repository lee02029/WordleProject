//
//  HardKeyboardViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/13.
//

import UIKit

protocol HardKeyboardViewControllerDelegate: AnyObject {
    func HardkeyboardViewController(
        _ vc: HardKeyboardViewController,
        didTapKey letter: Character
    )
}

class HardKeyboardViewController: UIViewController {
    // MARK: - Properties
    
    weak var delegate: HardKeyboardViewControllerDelegate?
    
    let letters = ["あいうもおか", "きくけこさし", "すせそたちつ", "てとなにぬの"]
    private var keys: [[Character]] = []
    
    let keyboardCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(KeyboardCollectionViewCell.self, forCellWithReuseIdentifier: KeyboardCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardCollectionView.delegate = self
        keyboardCollectionView.dataSource = self
        addViews()
        setConstraints()
        backButton()

        for row in letters {
            let chars = Array(row)
            keys.append(chars)
        }
    }
    
    // MARK: - Handlers
    
    private func addViews(){
        view.addSubview(keyboardCollectionView)
    }
    
    private func setConstraints(){
        keyboardCollectionViewConstranints()
    }
    
    private func backButton() {
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward")
    }
    
    // MARK: - Constraints
    
    private func keyboardCollectionViewConstranints() {
        keyboardCollectionView.translatesAutoresizingMaskIntoConstraints = false
        keyboardCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        keyboardCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 40).isActive = true
        keyboardCollectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        keyboardCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 90).isActive = true
    }
}


extension HardKeyboardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return keys.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keys[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyboardCollectionViewCell.identifier, for: indexPath) as? KeyboardCollectionViewCell else {
            fatalError()
        }
        let letter = keys[indexPath.section][indexPath.row]
        cell.configure(with: letter)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size: CGFloat = (collectionView.frame.size.width)/7.3
        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        var left: CGFloat = 1
        var right: CGFloat = 1

        let margin: CGFloat = 30
        let size: CGFloat = (collectionView.frame.size.width-margin)/5.8
        let count: CGFloat = CGFloat(collectionView.numberOfItems(inSection: section))

        let inset: CGFloat = (collectionView.frame.size.width - (size * count) - (2 * count))/2

        left = inset
        right = inset

        return UIEdgeInsets(top: 2, left: left, bottom: 2, right: right)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
        collectionView.deselectItem(at: indexPath, animated: true)
        let letter = keys[indexPath.section][indexPath.row]
        delegate?.HardkeyboardViewController(self,didTapKey: letter)
    }
}

