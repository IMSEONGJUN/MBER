//
//  LocationInputView.swift
//  MBER
//
//  Created by SEONGJUN on 2020/11/16.
//

import UIKit
import RxSwift

class LocationInputView: UIView {
    
    var user: User? {
        didSet {
            
        }
    }
    
    let backButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "baseline_arrow_back_black_36dp-1").withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    let startLocationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let linkingView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        return view
    }()
    
    let destinationIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    lazy var startingLocationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Current Location"
        tf.backgroundColor = .systemGroupedBackground
        tf.isEnabled = false
        tf.font = UIFont.systemFont(ofSize: 14)
        
        let paddingView = UIView()
        paddingView.frame.size = CGSize(width: 8, height: 30)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        
        return tf
    }()
    
    lazy var destinationTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter a destination.."
        tf.backgroundColor = Colors.textFieldBackGroundColor
        tf.returnKeyType = .search
        tf.font = UIFont.systemFont(ofSize: 14)
        let paddingView = UIView()
        paddingView.frame.size = CGSize(width: 8, height: 30)
        tf.leftView = paddingView
        tf.leftViewMode = .always
        tf.delegate = self
        tf.clearButtonMode = .whileEditing
        return tf
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LocationInputView: UITextFieldDelegate {
    
}
