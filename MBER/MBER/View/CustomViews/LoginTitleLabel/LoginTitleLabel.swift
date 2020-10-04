//
//  LoginTitleLabel.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/28.
//

import UIKit

final class AuthTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        text = "MBER"
        textAlignment = .center
        font = UIFont(name: "Avenir-Light", size: 42)
        textColor = UIColor(white: 1, alpha: 0.8)
    }
}
