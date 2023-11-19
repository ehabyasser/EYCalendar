//
//  UIButton+Extensions.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 15/11/2023.
//

import UIKit

public extension UIButton {
    
    func tap(callback: @escaping () -> Void) {
        self.endEditing(true)
        addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        if let hashValue = UnsafeRawPointer(bitPattern: "callback".hashValue) {
            objc_setAssociatedObject(self, hashValue, callback, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        if let hashValue = UnsafeRawPointer(bitPattern: "callback".hashValue) {
            if let callback = objc_getAssociatedObject(self, hashValue) as? () -> Void {
                callback()
            }
        }
    }
    
    func dropShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 4
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
}
