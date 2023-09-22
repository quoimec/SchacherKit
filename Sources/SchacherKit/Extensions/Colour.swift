//
//  Colour.swift
//  SchacherKit
//
//  Created by Charlie on 18/9/2022.
//

import Foundation
import SwiftUI
import UIKit

public typealias Colour = Color

extension Colour {
    
    /// Allows for a colour object to be initialised from a valid hex string
    /// - Parameter hex: The colour specied in hex form (# is allowed)
    public init(hex: String) {
        
        // Removes any leading hash values
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let a, r, g, b: UInt64
        
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
        
    }
    
    /// Allows for a colour object to be initialised from a HSL value input
    /// - Parameters:
    ///   - hue: The pure pigment value from a colour wheel, between 0.0 ..\< 360.0
    ///   - saturation: How dark or light the hue is, percentage between 0.0 and 1.0
    ///   - luminance: How bright the hue is, percentage between 0.0 and 1.0
    ///   - alpha: Optional alpha channel override, defaults to 1.0
    public init(hue: Double, saturation: Double, luminance: Double, alpha: Double = 1.0) {
        
        // Methodology from StackOverflow: https://stackoverflow.com/questions/24852345/hsv-to-rgb-color-conversion
        
        if luminance == 0 {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: alpha)
        } else {
            
            var hue = (hue == 360 ? 0 : hue) / 360.0
            
            var step = Int(floor(hue * 6.0))
            var remainder = (hue * 6.0) - Double(step)
            
            let w = luminance * (1.0 - saturation)
            let q = luminance * (1.0 - saturation * remainder)
            let t = luminance * (1.0 - saturation * (1.0 - remainder))
            let v = luminance
            
            switch step {
                
                case 0: self.init(.sRGB, red: v, green: t, blue: w, opacity: alpha)
                case 1: self.init(.sRGB, red: q, green: v, blue: w, opacity: alpha)
                case 2: self.init(.sRGB, red: w, green: v, blue: t, opacity: alpha)
                case 3: self.init(.sRGB, red: w, green: q, blue: v, opacity: alpha)
                case 4: self.init(.sRGB, red: t, green: w, blue: v, opacity: alpha)
                case 5: self.init(.sRGB, red: v, green: w, blue: q, opacity: alpha)
                
                default: fatalError("Invalid step: \(step)")
                
            }
            
            
        }
        
    }
    
    
    /// Applies a simple darkening process over an existing colour to get a darker version of the base colour
    /// - Parameter percentage: The percentage increase in darkness desired
    /// - Returns: A new, darkened colour
    public func darken(percentage: Double) -> Colour {
        
        let multiplier = 1.0 - percentage
        
        guard var components = UIColor(self).cgColor.components, components.count >= 3 else {
            fatalError()
        }
        
        if components.count == 3 {
            components.append(1.0)
        }
        
        return Colour(
            red: Double(components[0]) * multiplier,
            green: Double(components[1]) * multiplier,
            blue: Double(components[2]) * multiplier,
            opacity: Double(components[3])
        )
        
    }
    
    /// Applies a simple lightening process over an existing colour to get a lighter version of the base colour
    /// - Parameter percentage: The percentage increase in lightness desired
    /// - Returns: A new, lightened colour
    public func lighten(percentage: Double) -> Colour {
        
        let multiplier = percentage
        
        guard var components = UIColor(self).cgColor.components, components.count >= 3 else {
            fatalError()
        }
        
        if components.count == 3 {
            components.append(1.0)
        }
        
        return Colour(
            red: Double(components[0]) * multiplier,
            green: Double(components[1]) * multiplier,
            blue: Double(components[2]) * multiplier,
            opacity: Double(components[3])
        )
        
    }
    
}
