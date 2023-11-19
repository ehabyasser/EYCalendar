//
//  CardView.swift
//  DietCare
//
//  Created by Aamal Holding Android on 23/10/2022.
//

import Foundation
import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 40
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 0
    @IBInspectable var shadowColor: UIColor? = UIColor.lightGray
    @IBInspectable var shadowOpacity: Float = 0.5
    
    
    override init(frame: CGRect) {
        super.init (frame: frame)
        layoutSubviews()
    }
    // init from xib or storyboard
    required init? (coder Decoder: NSCoder) {
        super.init (coder: Decoder)
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
