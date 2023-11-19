//
//  Day.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import Foundation
public struct Day:Equatable {
    
    public let date: Date
    
    public let number: String
    
    public var isWithinDisplayedMonth: Bool
    
    public var isSelected:Bool = false
    public static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.date == rhs.date
    }
}
