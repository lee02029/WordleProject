//
//  IntermediateBoardViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/13.
//

import UIKit
import SnapKit

// datasource를 추가하기 위하여 프로토콜 선언 -> 데이터를 받아 뷰를 그려주는 역할
protocol IntermediateBoardViewControllerDatasource: AnyObject {
    var currentGuesses: [[Character?]] { get }
    func boxColor(at indexPath: IndexPath) -> UIColor?
}

class IntermediateBoardViewController: UIViewController {
    // MARK: - Properties
    
    weak var datasource: IntermediateBoardViewControllerDatasource?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        let collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.backgroundColor = .clear
        collectionVIew.register(KeyCollectionViewCell.self, forCellWithReuseIdentifier: KeyCollectionViewCell.identifier)
        return collectionVIew
    }()
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        addViews()
        setConstraints()
    }
    
    public func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: - Handlers
    
    private func addViews(){
        view.addSubview(collectionView)
    }
    
    private func setConstraints(){
        collectionViewConstranints()
    }
    
    // MARK: - Constraints
    
    private func collectionViewConstranints() {
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 60).isActive = true
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension IntermediateBoardViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datasource?.currentGuesses.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let guesses = datasource?.currentGuesses ?? []
        return guesses[section].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeyCollectionViewCell.identifier, for: indexPath) as? KeyCollectionViewCell else {
            fatalError()
        }

        cell.backgroundColor = datasource?.boxColor(at: indexPath)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.systemGray3.cgColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10

        let guesses = datasource?.currentGuesses ?? []
        if let letter = guesses[indexPath.section][indexPath.row] {
            cell.configure(with: letter)
        }

        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 20
        let size: CGFloat = (collectionView.frame.size.width-margin)/5

        return CGSize(width: size, height: size)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 2,left: 2,bottom: 2,right: 2)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //
    }
}
