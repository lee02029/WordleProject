//
//  KeyCollectionViewCell.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/07/16.
//

import UIKit

class KeyCollectionViewCell: UICollectionViewCell {
    static let identifier = "KeyCell"

    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = hexStringToUIColor(hex: "#000000")
        label.textAlignment = .center
        label.font = UIFont(name: "MochiyPopOne-Regular", size: 40)
        return label
    }()
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray5
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }

    func configure(with letter: Character) {
        label.text = String(letter).uppercased()
    }
}
