//
//  AnalyzedMessage.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import Foundation

struct AnalyzedMessage: Decodable {
    let usage: AnalyzedUsage
    let sentiment: SentimentData
    let emotion: AnalyzedEmotion
}

struct AnalyzedUsage: Decodable {
    let text_characters: Int
}

struct SentimentData: Decodable {
    let targets: [Sentiment]
}

struct Sentiment: Decodable {
    let label: String
}

struct AnalyzedEmotion: Decodable {
    let targets: [AnalyzedTarget]
}

struct AnalyzedTarget: Decodable {
    let emotion: Emotions
}

struct Emotions: Decodable {
    let sadness: Double
    let joy: Double
    let fear: Double
    let disgust: Double
    let anger: Double
}
