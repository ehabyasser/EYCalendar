//
//  ViewController.swift
//  Demo
//
//  Created by Ihab yasser on 19/11/2023.
//

import UIKit
import EYCalendar
import SnapKit

class ViewController: UIViewController {
    
    private let calendar:EYCalendar = {
        let configurations = EYCalendarConfigration(isRTL: true, startDate: Date() , NoMonths: 24 , themeColor: .cyan, font: UIFont.systemFont(ofSize: 14, weight: .bold) , hideCalendarActionType: true)
        let calendar = EYCalendar(configuration: configurations)
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(calendar)
        calendar.delegate = self
        calendar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(440)
        }
    }
    
    
}
extension ViewController: CalendarDelegate{
    func daySelected(indexPath: IndexPath, day: Day?) {
        guard let day = day else {return}
        if day.isWithinDisplayedMonth {
            print("day number \(day.number)")
        }
    }
    
    func monthDidDisplayed(monthIndex: Int, month: Month) {
        print(month.monthTitle)
    }
}
