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
}

class AnalizeRequest: Request {
    private let filePath: URL
    
    let url = URL(string: "www.apple.com")!
    
    let httpMethod = "POST"
    
    let contentType = "audio/mpeg"
    
    var body: Data? {
        try? Data(contentsOf: URL(fileURLWithPath: filePath.absoluteString))
    }
    
    init(filePath: URL) {
        self.filePath = filePath        
    }
}
