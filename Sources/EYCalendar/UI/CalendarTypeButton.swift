//
//  LawyerButton.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import UIKit

class CalendarTypeButton: UIButton {
    
    var title:String = ""{
        didSet{
            self.setTitle(title, for: .normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        configureAppearance()
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        self.setTitleColor(.white, for: .normal)
    }
    
    private func configureAppearance() {
        backgroundColor = ThemeHelper.APP_COLOR
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4.0
    }
    
}
