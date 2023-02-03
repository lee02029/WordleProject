//
//  CollectionViewLeft.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/31.
//

import UIKit
import Foundation

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) ->  [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?.map { $0.copy() as! UICollectionViewLayoutAttributes }
        var leftMargin: CGFloat = 15.0
        var maxY: CGFloat = -1.0
    
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }

            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = 15.0
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
