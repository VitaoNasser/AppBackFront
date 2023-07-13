//
//  UIViewController+Extension.swift
//  AppBackFront
//
//  Created by Victor Nasser on 12/07/23.
//

import UIKit

extension UIViewController {
    func dismissKeyBoard() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
