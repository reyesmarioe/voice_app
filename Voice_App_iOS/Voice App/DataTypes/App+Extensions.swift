//
//  App+Extensions.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/17/23.
//

import SwiftUI

extension Color {
    init(red: Double, green: Double, blue: Double) {
        self.init(
            .sRGB,
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            opacity: 1
        )
    }
    
    static let darkBlue = Color(red: 0, green: 104, blue: 253)
    static let lightBlue = Color(red: 0, green: 184, blue: 255)
    static let backgroundBlue = Color(red: 77, green: 179, blue: 255)
}
