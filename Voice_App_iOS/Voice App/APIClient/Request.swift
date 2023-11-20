//
//  Request.swift
//  Voice App
//
//  Created by Sergey Prybysh on 10/8/23.
//

import Foundation

protocol Request {
    var url: URL { get }
    var httpMethod: String { get }
    var contentType: String { get }
    var body: Data? { get }
    var filePath: URL? { get }
}

class AnalizeRequest: Request {
    let url = URL(string: Credentials.recognize_url)!
    
    let httpMethod = "POST"
    
    let contentType = "application/json"
    
    let filePath: URL? = nil
    
    private let text: String
    
    var body: Data? {
        let requestBody: [String: Any] = [
                "text": text,
                "features": [
                    "emotion": [
                        "targets": [text]
                    ],
                    "sentiment": [
                        "targets": [text]
                    ],
                ]
            ]
        return try? JSONSerialization.data(withJSONObject: requestBody)
    }
    
    init(text: String) {
        self.text = text
    }
}

class RecognizeRequest: Request {
    let url = URL(string: Credentials.voice_url)!
    
    let httpMethod = "POST"
    
    let contentType = "audio/wav"
    
    var body: Data? {
        try? Data(contentsOf: filePath!)
    }
    
    let filePath: URL?
    
    init(filePath: URL) {
        self.filePath = filePath
    }
}
