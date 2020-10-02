//
//  UIViewController+Ext.swift
//  MBER
//
//  Created by SEONGJUN on 2020/09/27.
//

import Foundation
import UIKit
import JGProgressHUD

// MARK: - Global function
func isValidEmailAddress(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
}

extension UIViewController {
    
    static let hud = JGProgressHUD(style: .dark)
    
    func showActivityIndicator(_ show: Bool, withText text: String? = "Loading") {
        view.endEditing(true)
        UIViewController.hud.textLabel.text = text
        
        if show {
            UIViewController.hud.show(in: view)
        } else {
            UIViewController.hud.dismiss()
        }
    }
    
    func switchToConversationVC() {
        if #available(iOS 13.0, *) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                let window = UIWindow(windowScene: windowScene)
                window.backgroundColor = .systemBackground
//                let conversationVC = ConversationsController.create(with: ConversationViewModel())
//                let rootVC = UINavigationController(rootViewController: conversationVC)
//                window.rootViewController = rootVC

                let sceneDelegate = windowScene.delegate as? SceneDelegate
                window.makeKeyAndVisible()
                sceneDelegate?.window = window
            }
        } else {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.backgroundColor = .systemBackground
//            let conversationVC = ConversationsController.create(with: ConversationViewModel())
//            let rootVC = UINavigationController(rootViewController: conversationVC)
//            window.rootViewController = rootVC
            window.makeKeyAndVisible()
            appDelegate.window = window
        }

    }
}
