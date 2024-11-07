//
//  Extensions.swift
//  TrackYourExpenses
//
//  Created by mac on 28/10/2024.
//

import Foundation
import SwiftUI

extension Color {
    static let backgroundColor = Color("Background")
    static let UIcolor = Color("UI")
    static let links = Color("Link")
    static let icons = Color("Icon")
    static let borders = Color("Border")
    static let systemBackground = Color(.systemBackground)
}





extension String {
    func dateParsed() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Match the date format in your JSON
        return formatter.date(from: self) ?? Date()
    }
}


extension Date: Strideable {
    func formatted() -> String {
        return self.formatted(.dateTime.year().month().day())
    }
}



extension Double {
    func roundedto2Digits() -> Double {
        return (self * 100).rounded() / 100
    }
}


