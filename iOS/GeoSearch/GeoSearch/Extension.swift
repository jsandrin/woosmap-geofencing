//
//  Extension.swift
//  GeoSearch
//
//

import Foundation

public extension Date {
    func stringFromDate()-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let stringDate = formatter.string(from: self) // string purpose I add here
        return stringDate
    }
}
