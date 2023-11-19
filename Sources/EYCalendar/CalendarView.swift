//
//  CalendarView.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class CalendarView: UICollectionView , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    var months:[Month] = []{
        didSet{
            self.reloadData()
        }
    }
    
    
    var didEndScroll:((Int) -> Void)?
    var calendarDelegate:CalendarDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
    
    
    private func setupCollectionView() {
        self.isPagingEnabled = true
        self.showsHorizontalScrollIndicator = false
        self.dataSource = self
        self.delegate = self
        self.register(MonthView.self, forCellWithReuseIdentifier: "MonthView")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return months.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthView", for: indexPath) as! MonthView
        cell.monthCV.reloadData()
        cell.days = months[indexPath.row].days
        cell.delegate = self.calendarDelegate
        cell.monthIndex = indexPath.row
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.bounds.size
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        didEndScroll?(pageIndex)
    }
}
