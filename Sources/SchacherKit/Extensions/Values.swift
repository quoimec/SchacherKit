//
//  Values.swift
//  SchacherKit
//
//  Created by Charlie on 18/9/2022.
//

import Foundation

extension Array {
    
    /// A method to break an array down into any array of subarrays
    /// - Parameter size: The desired size of each subarray
    /// - Returns: The chunked result
    public func chunked(into size: Int) -> [[Element]] {
        
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
        
    }
    
}

extension Double {
    
    /// A simple method to easily limit a value to a provided range
    /// - Parameter limits: The upper and lower bounds permissable
    /// - Returns: Either the original value, or the value clamped to the provided range
    public func clamped(to limits: ClosedRange<Self>) -> Self {
        
        return min(max(self, limits.lowerBound), limits.upperBound)
        
    }

}

extension Date {
    
    /// Allows for the subtraction of two Swift Dates
    /// - Parameters:
    ///   - lhs: The base, left hand side of the function
    ///   - rhs: The subtractor, right hand side of the function
    /// - Returns: The delta between the two dates
    public static func - (lhs: Self, rhs: Self) -> TimeInterval {
        
        return Double(Calendar.current.dateComponents([.second], from: rhs, to: lhs).second ?? 0)
        
    }
  
}

extension String {
    
    /// A mimic of the Python method, removes whitespaces and new lines from a string
    /// - Returns: The cleaned string
    public func strip() -> Self {
        
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
        
    }
    
    /// Attempts to correctly capitalise the names of people
    /// - Returns: The capitalised name
    public func namecased() -> Self {
        
        var names = self.lowercased().split(separator: " ").map({ String($0) })
        
        for index in names.indices {
            for separator in ["-", "'"] {
                names[index] = names[index].split(separator: Character(separator)).map({ $0.capitalized }).joined(separator: separator)
            }
        }
        
        return names.joined(separator: " ")
        
    }
    
}

extension UUID {

    /// A convenience method to convert a UUID to a string
    /// - Returns: The UUID as a string
    public func string() -> String {
        return self.description.lowercased()
    }
    
}

