//
//  SearchVC.swift
//  Cocktailsy
//
//  Created by Zsolt Toth on 2022. 09. 24..
//

import UIKit

class SearchVC: UIViewController {

    let logoImageView = UIImageView()
    let coctailNameTextField = CYTextField()
    let callToActionButton = CYButton(color: .systemGreen, title: "Get Coctails")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        createDismissKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coctailNameTextField.text = ""
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushContailsListVC() {
        
    }
}
