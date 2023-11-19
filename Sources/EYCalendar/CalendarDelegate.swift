//
//  CalendarDelegate.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import Foundation
public protocol CalendarDelegate{
    func daySelected(indexPath:IndexPath , day:Day?)
    func monthDidDisplayed(monthIndex:Int , month:Month)
}

extension CalendarDelegate {
    func monthDidDisplayed(monthIndex:Int , month:Month) {}
}
