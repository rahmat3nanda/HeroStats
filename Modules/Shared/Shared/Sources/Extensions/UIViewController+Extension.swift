//
//  UIViewController+Extension.swift
//  Shared
//
//  Created by Rahmat Trinanda Pramudya Amar on 22/07/24.
//

import UIKit

public extension UIViewController {
    func bindNavigationBar(_ title: String? = "", _ isPop: Bool = true) {
        let btnLeftMenu: UIButton = UIButton()
        btnLeftMenu.setImage(UIImage(systemName: "chevron.backward"), for: UIControl.State())
        btnLeftMenu.tintColor = .black
        if isPop {
            btnLeftMenu.addTarget(self, action: #selector(onClickBackWithPop), for: .touchUpInside)
        } else {
            btnLeftMenu.addTarget(self, action: #selector(onClickBackWithDimiss), for: .touchUpInside)
        }
        
        btnLeftMenu.frame = CGRect(x: 0, y: 0, width: 33/2, height: 27/2)
        let barButton = UIBarButtonItem(customView: btnLeftMenu)
        barButton.tintColor = .black
        navigationItem.leftBarButtonItem = barButton
        navigationItem.title = title ?? ""
    }
    
    @objc private func onClickBackWithPop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onClickBackWithDimiss() {
        dismiss(animated: true, completion: nil)
    }
}
