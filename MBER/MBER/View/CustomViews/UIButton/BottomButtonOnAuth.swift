//
//  BottomButtonOnAuth.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/29.
//

import UIKit

final class BottomButtonOnAuth: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(firstText: String, secondText: String) {
        self.init(frame: .zero)
        configure(firstText: firstText, secondText: secondText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(firstText: String, secondText: String) {
        let attributedTitle = NSMutableAttributedString(string: firstText,
                                                        attributes: [.font: UIFont.systemFont(ofSize: 16),
                                                                     .foregroundColor : UIColor.white])
        attributedTitle.append(NSAttributedString(string: secondText,
                                                  attributes: [.font : UIFont.boldSystemFont(ofSize: 16),
                                                               .foregroundColor : #colorLiteral(red: 0.2256013453, green: 0.6298174262, blue: 0.9165520668, alpha: 1)]))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
