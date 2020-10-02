//
//  GeneralConfirmButton.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/28.
//

import UIKit

final class GeneralConfirmButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, color: UIColor ,titleColor: UIColor = UIColor.white) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = color
        setTitleColor(titleColor, for: .normal)
        layer.cornerRadius = 6
        clipsToBounds = true
        isEnabled = false
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
    }
}
