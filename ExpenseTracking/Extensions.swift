//
//  Extensions.swift
//  ExpenseTracking
//
//  Created by GeoSpark on 04/07/22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let icon = Color("Icon")
    static let text = Color("Text")
    static let systemBackground = Color(uiColor: .systemBackground)

}


extension DateFormatter {
    static let allNumericUSA:DateFormatter = {
        print("Initilizing DateFormatter")
        let formmter = DateFormatter()
        formmter.dateFormat = "MM/dd/yyyy"
        return formmter
    }()
}
extension String{
    func dateParse() -> Date {
        guard let parseDate = DateFormatter.allNumericUSA.date(from: self) else { return Date()}
        return parseDate
    }
}

extension Date:Strideable{
    func formatted() -> String{
        return self.formatted(.dateTime.year().month().day())
    }
}
