//
//  InputTextField.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/28.
//

import UIKit

final class InputTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        borderStyle = .none
        keyboardAppearance = .dark
        returnKeyType = .done
        autocorrectionType = .no
        attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : UIColor.lightGray])
        textColor = .white
        font = UIFont.systemFont(ofSize: 16, weight: .medium)
    }
}

