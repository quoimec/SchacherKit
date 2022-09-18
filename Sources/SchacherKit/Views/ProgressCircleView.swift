//
//  ProgressCircleView.swift
//  SchacherKit
//
//  Created by Charlie on 18/9/2022.
//

import Foundation
import SwiftUI

struct ProgressCircleView: View {
    
    @Binding var progress: Double
    
    let colour: Colour
    let line: CGFloat
    private let dark_colour: Colour
    
    private let gradient_a: Gradient
    private let gradient_b: Gradient
    
    init(progress: Binding<Double>, colour: Colour, line: CGFloat) {
        
        self._progress = progress
        
        self.colour = colour
        self.line = line
        self.dark_colour = colour.darken(percentage: 0.2)
        
        self.gradient_a = Gradient(colors: Array(repeating: self.dark_colour, count: 2) + Array(repeating: self.colour, count: 4) + Array(repeating: self.dark_colour, count: 2))
        self.gradient_b = Gradient(colors: Array(repeating: self.dark_colour, count: 2) + Array(repeating: self.colour, count: 6))
        
    }
    
    var body: some View {
   
        ZStack(alignment: .center, content: {
         
            Circle()
                .stroke(colour.opacity(0.3), lineWidth: line)
        
            Circle()
                .trim(from: 0, to: 0.001)
                .stroke(dark_colour, style: StrokeStyle(lineWidth: line, lineCap: .round))

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(gradient: progress > 0.5 ? gradient_a : gradient_a, center: .center, angle: .degrees(0)),
                    style: StrokeStyle(lineWidth: line, lineCap: progress > 0.5 ? .butt : .round)
                )

            if progress > 0.5 {

                Circle()
                    .trim(from: 0, to: 0.001)
                    .stroke(
                        colour, style: StrokeStyle(lineWidth: line, lineCap: .round))
                    .rotationEffect(Angle(degrees: Double(360 * progress)))

            }
            
        })
        .padding(10)
        .rotationEffect(Angle(degrees: -90.0))
        
    }
    
}

struct ProgressCircleView_Preview: PreviewProvider {
    
    static var previews: some View {
        
        ProgressCircleView(progress: .constant(0.37), colour: Colour(hex: "#E62E6B"), line: 60)
            .frame(width: 200)
        
    }
}
