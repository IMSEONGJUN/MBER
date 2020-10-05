//
//  SelectMemberTypeView.swift
//  MBER
//
//  Created by SEONGJUN on 2020/10/04.
//

import UIKit
import SnapKit

final class SelectMemberTypeView: UIView {
    let imageView = UIImageView()
    var segmentControl = UISegmentedControl()
    let underline = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(text: String...) {
        super.init(frame: .zero)
    
        addSubview(imageView)
        imageView.image = #imageLiteral(resourceName: "ic_account_box_white_2x")
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(30)
        }
        
        segmentControl = UISegmentedControl(items: text)
        addSubview(segmentControl)
        segmentControl.selectedSegmentIndex = 0
        segmentControl.tintColor = .white
        segmentControl.layer.borderWidth = 2
        segmentControl.layer.borderColor = UIColor.white.cgColor
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(10)
            $0.leading.equalTo(imageView)
            $0.trailing.equalToSuperview()
        }
        
        addSubview(underline)
        underline.backgroundColor = .white
        underline.snp.makeConstraints {
            $0.top.equalTo(segmentControl.snp.bottom).offset(15)
            $0.leading.equalTo(imageView)
            $0.trailing.equalTo(segmentControl)
            $0.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
