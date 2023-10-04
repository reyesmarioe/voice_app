//
//  AnalyzerProvider.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import Foundation

enum AnalyzerError: Error {
    case general
    case timeout
}

// TODO: Create provider
protocol AnalyzerProviding: AnyObject {
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void)
}

class FakeAnalyzerProvider: AnalyzerProviding {
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        let analyzedMessage = AnalyzedMessage(message: "Some recorded text")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completionHandler(.success(analyzedMessage))
        }
    }
}
