//
//  MessageData.swift
//  Voice App
//
//  Created by Sergey Prybysh on 11/19/23.
//

import Foundation

struct Bar {
    let name: String
    let score: Double
    let color: String
}

struct MessageData {
    let text: String
    let numChar: Int
    let sentiment: String
    let barData: [Bar]
}
