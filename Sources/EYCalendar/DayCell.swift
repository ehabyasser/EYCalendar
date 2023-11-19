//
//  DayCell.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class DayCell: UICollectionViewCell {
    
    private let cardView:CardView = {
        let card = CardView()
        card.cornerRadius = 8
        return card
    }()

    
    private let dayLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return lbl
    }()
    
    
    var day:Day?{
        didSet{
            guard let day = day else {return}
            if day.isSelected {
                cardView.backgroundColor = ThemeHelper.APP_COLOR
                dayLbl.textColor = .white
            }else if day.isWithinDisplayedMonth{
                dayLbl.textColor = .label
                cardView.backgroundColor = ThemeHelper.INPUT_BG
            } else {
                dayLbl.textColor = .label
                cardView.backgroundColor = ThemeHelper.lightGray
            }
            dayLbl.text = day.number
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    
    func setupCollectionView(){
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview()
            make.trailing.bottom.equalToSuperview()
        }
        
        cardView.addSubview(dayLbl)
        
        dayLbl.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
