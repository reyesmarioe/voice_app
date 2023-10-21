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
    var filePath: URL { get }
}

class AnalizeRequest: Request {
    let url = URL(string: "https://voiceapprestapi20231019015046.azurewebsites.net/api/uploadvoice")!
    
    let httpMethod = "POST"
    
    let contentType = "audio/wav"
    
    var body: Data? {
        try? Data(contentsOf: URL(fileURLWithPath: filePath.absoluteString))
    }
    
    let filePath: URL
    
    init(filePath: URL) {
        self.filePath = filePath        
    }
}
