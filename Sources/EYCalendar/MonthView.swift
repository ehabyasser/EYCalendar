//
//  MonthView.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import UIKit
import SnapKit

@available(iOS 13.0, *)
class MonthView: UICollectionViewCell , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    var days:[Day]?
    
    let monthCV:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero , collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.register(DayCell.self, forCellWithReuseIdentifier: "DayCell")
        cv.isScrollEnabled = false
        return cv
    }()
    
    var delegate:CalendarDelegate?
    var monthIndex:Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    
    func setupCollectionView(){
        contentView.addSubview(monthCV)
        monthCV.translatesAutoresizingMaskIntoConstraints = false
        monthCV.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        monthCV.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        monthCV.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        monthCV.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        monthCV.dataSource = self
        monthCV.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCell", for: indexPath) as! DayCell
        cell.day = days?[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.bounds.width / 7) - 8
        return CGSize(width: width, height: width)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.daySelected(indexPath: IndexPath(row: indexPath.row, section: monthIndex), day: days?[indexPath.row])
    }
    
}
