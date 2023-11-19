//
//  CalendarManager.swift
//  Smart-Lawyer
//
//  Created by Ihab yasser on 17/11/2023.
//

import Foundation



class CalendarManager:NSObject {
    
    static let shared = CalendarManager()
    private var calendar = Calendar(identifier: .islamicUmmAlQura)
    private var months:[Month] = []
    private lazy var dateHeaderFormatetr: DateFormatter = {
        return getMonthFormatter(isRTL: false)
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        return getDayFormatter()
    }()
    
    private var baseDate: Date = Date() {
      didSet {
          let days = generateDaysInMonth(for: baseDate)
          let month = Month(days: days, monthTitle: dateHeaderFormatetr.string(from: baseDate) , date: baseDate, rowsCount: (days.count > 35) ? 6 : 5)
          self.months.append(month)
      }
    }
    

    
    private func generateMonth(){
        baseDate = self.calendar.date(
          byAdding: .month,
          value: 1,
          to: baseDate
        ) ?? baseDate
    }
    
    
    private func getMonthFormatter(isRTL:Bool) -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        dateFormatter.calendar = calendar
        dateFormatter.locale = isRTL ? Locale(identifier: "ar") : Locale(identifier: "en")
        return dateFormatter
    }
    
    private func getDayFormatter() -> DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter
    }
    
    
    func getMonths(start:Date , count: Int , isIslamic:Bool = false , isRTL:Bool = false) -> [Month]{
        if isIslamic {
            calendar = Calendar(identifier: .islamicUmmAlQura)
        }else{
            calendar = Calendar(identifier: .gregorian)
        }
        calendar.locale = isRTL ? Locale(identifier: "ar") : Locale(identifier: "en")
        self.dateHeaderFormatetr = getMonthFormatter(isRTL: isRTL)
        self.dateFormatter = getDayFormatter()
        self.months.removeAll()
        self.baseDate = start
        for _ in 0...(count - 1) {
            self.generateMonth()
        }
        return months
    }
    
    
    private func monthMetadata(for baseDate: Date) throws -> MonthMetadata {
        // 2
        guard
            let numberOfDaysInMonth = calendar.range(
                of: .day,
                in: .month,
                for: baseDate)?.count,
            let firstDayOfMonth = calendar.date(
                from: calendar.dateComponents([.year, .month], from: baseDate))
        else {
            // 3
            throw CalendarDataError.metadataGeneration
        }
        
        // 4
        let firstDayWeekday = calendar.component(.weekday, from: firstDayOfMonth)
        
        // 5
        return MonthMetadata(
            numberOfDays: numberOfDaysInMonth,
            firstDay: firstDayOfMonth,
            firstDayWeekday: firstDayWeekday)
    }
    
    
    private func generateDaysInMonth(for baseDate: Date) -> [Day] {
        guard let metadata = try? monthMetadata(for: baseDate) else {
            preconditionFailure("An error occurred when generating the metadata for \(baseDate)")
        }
        
        let numberOfDaysInMonth = metadata.numberOfDays
        let offsetInInitialRow = metadata.firstDayWeekday
        let firstDayOfMonth = metadata.firstDay
        var days: [Day] = (1..<(numberOfDaysInMonth + offsetInInitialRow))
            .map { day in
                // 4
                let isWithinDisplayedMonth = day >= offsetInInitialRow
                // 5
                let dayOffset =
                isWithinDisplayedMonth ?
                day - offsetInInitialRow :
                -(offsetInInitialRow - day)
                return generateDay(
                    offsetBy: dayOffset,
                    for: firstDayOfMonth,
                    isWithinDisplayedMonth: isWithinDisplayedMonth)
            }
        
        days += generateStartOfNextMonth(using: firstDayOfMonth)
        
        return days
    }
    
    private  func generateDay(
        offsetBy dayOffset: Int,
        for baseDate: Date,
        isWithinDisplayedMonth: Bool
    ) -> Day {
        let date = calendar.date(
            byAdding: .day,
            value: dayOffset,
            to: baseDate)
        ?? baseDate
        
        return Day(
            date: date,
            number: dateFormatter.string(from: date),
            isWithinDisplayedMonth: isWithinDisplayedMonth,
            isSelected: date.date(calendar: calendar) == Date().date(calendar: calendar)
        )
    }
    
    // 1
    private func generateStartOfNextMonth(
        using firstDayOfDisplayedMonth: Date
    ) -> [Day] {
        guard
            let lastDayInMonth = calendar.date(
                byAdding: DateComponents(month: 1, day: -1),
                to: firstDayOfDisplayedMonth)
        else {
            return []
        }
        
        let additionalDays = 7 - calendar.component(.weekday, from: lastDayInMonth)
        guard additionalDays > 0 else {
            return []
        }
        let days: [Day] = (1...additionalDays)
            .map {
                generateDay(
                    offsetBy: $0,
                    for: lastDayInMonth,
                    isWithinDisplayedMonth: false)
            }
        
        return days
    }
    
    enum CalendarDataError: Error {
        case metadataGeneration
    }
    
}

extension Date{
    func date(calendar:Calendar) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = calendar
        dateFormatter.locale = Locale(identifier: "en")
        return dateFormatter.string(from: self)
    }
}
