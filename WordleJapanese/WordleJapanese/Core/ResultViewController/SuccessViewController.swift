//
//  SuccessViewController.swift
//  WordleJapanese
//
//  Created by Yoonjae on 2022/08/13.
//

import UIKit

class SuccessViewController: UIViewController {
    
    // MARK: - UI
    
    let titleLabel = UILabel()
    let button = UIButton()
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupLayout() {
        view.addSubview(titleLabel)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        
    }
    
    func setupLocalization() {
        
    }
    
    func setData() {
    }
    

}
