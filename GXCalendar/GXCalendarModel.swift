//
//  GXCalendarModel.swift
//  GXCalendarSample
//
//  Created by Gin on 2022/4/15.
//

import Foundation

public class GXCalendarMonthModel: NSObject {
    public var year: Int
    public var month: Int
    
    public lazy var date: Date = {
        return GXCalendar.gx_date(year: self.year, month: self.month)
    }()
    
    public lazy var components: DateComponents = {
        return GXCalendar.gx_dateComponents(date: self.date)
    }()
    
    public lazy var chComponents: DateComponents = {
        return GXCalendar.gx_chineseDateComponents(date: self.date)
    }()
    
    public lazy var dayList: [GXCalendarDayModel] = {
        var list: [GXCalendarDayModel] = []
        // 添加本月日期
        let numberOfDays = GXCalendar.gx_numberOfDaysInMonth(date: self.date)
        for index in 0..<numberOfDays {
            let reDate = Calendar.current.date(byAdding: .day, value: index, to: self.date)
            if let letReDate = reDate {
                let model = GXCalendarDayModel(date: letReDate, isCurrentMonthOut: false)
                list.append(model)
            }
        }
        // 添加本月第一天之前空格的日期
        guard let firstDay = list.first else { return list }
        let firstDayWeek = firstDay.components.weekday ?? 0
        if firstDayWeek > 1 {
            for index in (1..<firstDayWeek) {
                let reDate = Calendar.current.date(byAdding: .day, value: -index, to: firstDay.date)
                if let letReDate = reDate {
                    let model = GXCalendarDayModel(date: letReDate, isCurrentMonthOut: true)
                    list.insert(model, at: 0)
                }
            }
        }
        // 添加本月最后一天之后空格的日期
        guard let lastDay = list.last else { return list }
        let lastDayWeek = lastDay.components.weekday ?? 0
        if lastDayWeek < 7 {
            for index in 1...(7 - lastDayWeek) {
                let reDate = Calendar.current.date(byAdding: .day, value: index, to: lastDay.date)
                if let letReDate = reDate {
                    let model = GXCalendarDayModel(date: letReDate, isCurrentMonthOut: true)
                    list.append(model)
                }
            }
        }
        return list
    }()
    
    required init(year: Int, month: Int) {
        self.year = year
        self.month = month
    }
    
    required init(date: Date) {
        let date = GXCalendar.gx_dateComponents(date: date)
        self.year = date.year ?? 1970
        self.month = date.month ?? 1
    }
}

public class GXCalendarDayModel: NSObject {
    public var date: Date
    public var isCurrentMonthOut: Bool

    public lazy var components: DateComponents = {
        return GXCalendar.gx_dateComponents(date: self.date)
    }()
    
    public lazy var chComponents: DateComponents = {
        return GXCalendar.gx_chineseDateComponents(date: self.date)
    }()
    
    required init(date: Date, isCurrentMonthOut: Bool) {
        self.date = date
        self.isCurrentMonthOut = isCurrentMonthOut
    }
}
