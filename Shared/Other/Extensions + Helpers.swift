//
//  Extensions + Helpers.swift
//  TheMovieDB
//
//  Created by Kelian Daste on 15/01/2024.
//

import SwiftUI

extension View {
    func continuousCorner(_ radius: CGFloat) -> some View {
        self
            .clipShape(RoundedRectangle(cornerRadius: radius, style: .continuous))
    }

    @ViewBuilder
    func redacted(_ condition: @autoclosure () -> Bool) -> some View {
        redacted(reason: condition() ? .placeholder : [])
    }
}

extension String {
    static func placeholder(length: Int) -> String {
        String(Array(repeating: "X", count: length))
    }
    
    func removeWord(_ wordToRemove: String) ->String {
        var sentence = self
        if let range = sentence.range(of: wordToRemove) {
            sentence.removeSubrange(range)
        }
        return sentence
    }
    
    var formatDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self)
    }
    
    var dateToDate: String {
        if let date = self.formatDate {
            return date.frenchDate
        }
        return ""
    }
}

extension Date {
    var frenchDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}

extension Int {
    //Transform runtime from 158 to 2h38
    var toHoursAndMinutes: String {
        let hours = self / 60
        let remainMinutes = self % 60
        return String(format: "%2dh%02d", hours, remainMinutes)
    }
}

extension Double {
    var secToMinutes: String {
        return String(format: "%2d", Int(self) / 60)
    }
    
    var seconds: String {
        return String(format: "%02d", Int(self) % 60)
    }
    
    var formatTime: String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self.roundIfNeeded % 60)
        
        if hours > 0 {
            return String(format: "%2d:%2d:%02d", hours, minutes, seconds)
        }
        
        return String(format: "%2d:%02d", minutes, seconds)
    }
    
    var roundIfNeeded: Int {
        let fractionalPart = self.truncatingRemainder(dividingBy: 1.0)
        
        // Arrondir uniquement si la partie décimale est supérieure à 0.75
        if fractionalPart > 0.75 {
            return Int(self) + 1
        } else {
            return Int(self)
        }
    }
}
extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
