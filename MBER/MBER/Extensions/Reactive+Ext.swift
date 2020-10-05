//
//  Reactive+Ext.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/27.
//

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UISegmentedControl {
    var selectedTitle: ControlProperty<String> {
        return base.rx.controlProperty(editingEvents: .valueChanged, getter: { base -> String in
            switch base.selectedSegmentIndex {
            case 0:
                return "Rider"
            case 1:
                return "Driver"
            default:
                break
            }
            return ""
        }) { (base, str) in
            
        }
    }
}
