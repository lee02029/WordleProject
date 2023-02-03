//
//  BaseViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/13.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: - View Life Cycle
        
        override func viewDidLoad() {
            setupLayout()
            setupConstraints()
            setupAttributes()
            setupLocalization()
            setData()
            setupBinding()
        }
        
        func setupLayout() {
            // Override Layout
        }
        
        func setupConstraints() {
            // Override Constraints
        }
        
        func setupAttributes() {
            // Override Attributes
        }
        
        func setupLocalization() {
            // Override Localization
        }
        
        func setData() {
            // Override Set Data
        }

        func setupBinding() {
            // Override Binding
        }
}
