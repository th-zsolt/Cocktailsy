//
//  UIViewController+Ext.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

extension UIViewController {
    
    func presentCYAlert(title: String, message: String, buttonTitle: String) {
            let alertVC = CYAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
    }
    
    
    func presentDefaultError() {
            let alertVC = CYAlertVC(title: "Something went wrong",
                message: "We were unable to complete your task at this time.",
                buttonTitle: "Ok")
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
    }
    
    
    //for test
    func presentCYAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = CYAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle  = .overFullScreen
            alertVC.modalTransitionStyle    = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
