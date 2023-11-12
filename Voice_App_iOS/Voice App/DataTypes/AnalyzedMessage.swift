//
//  AnalyzedMessage.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import Foundation

// TODO: Define JSON contract
struct AnalyzedMessage: Decodable {
    let message: String
    let numOfWords: Int
}
