//
//  VoiceAnalyzerResult.swift
//  Voice App
//
//  Created by Sergey Prybysh on 11/18/23.
//

import Foundation

struct VoiceAnalyzerResult: Decodable {
    let results: [VoiceAnalyzerFinal]
}

struct VoiceAnalyzerFinal: Decodable {
    let alternatives: [VoiceAnalyzerAlternative]
}

struct VoiceAnalyzerAlternative: Decodable {
    let transcript: String
}
