//
//  Date+DaysDifference.swift
//  EnglishPremierLeague
//
//  Created by Mohamed Abd ElNasser on 27/03/2023.
//

import Foundation

extension Date {

    func daysDifference(from date: Date) -> Int {
        let components = Calendar.current.dateComponents([.day, .month, .year], from: self, to: date)
        let days = components.value(for: .day) ?? 0
        let daysInMonthsDifference = ((components.value(for: .month) ?? 0) * 30)
        let daysInYearsDifference = ((components.value(for: .year) ?? 0) * 365)

        return  days + daysInMonthsDifference + daysInYearsDifference
    }

}
