//
//  Extensions.swift
//  HackNC2020
//
//  Created by Samuel Shi on 10/17/20.
//

import Foundation
import SwiftUI

extension Int {
    var intToTime: String {
        let min = self / 60
        let second = self % 60
        
        return "\(min):\(String(format: "%.2d", second))"
    }
}

extension Color {
    static var sRed: Color {
        Color("sRed")
    }
    
    static var sBackground: Color {
        Color("sBackground")
    }
    
    static var sBlue: Color {
        Color("sBlue")
    }
    
    static var sPink: Color {
        Color("sPink")
    }
}

struct CustomRoundedRectangle: Shape {
    
    var radius: CGFloat
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
    
}

extension View {
    func tRoundCorners(_ radius: CGFloat = 12, corners: UIRectCorner = .allCorners) -> some View {
        clipShape( CustomRoundedRectangle(radius: radius, corners: corners) )
    }
}
