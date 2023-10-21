//
//  AnalyzerProvider.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import Foundation

enum AnalyzerError: Error {
    case general
    case parsingError
}

protocol AnalyzerProviding: AnyObject {
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void)
    func cancelRequest()
}

class AnalyzerProvider: AnalyzerProviding {
    private let client = APIClient()
    
    private var dataTask: URLSessionDataTask?
    
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        let request = AnalizeRequest(filePath: url)
        dataTask = client.sendUploadTask(request) { result in
            switch result {
            case .success(let data):
                let message = try? JSONDecoder().decode(AnalyzedMessage.self, from: data)
                guard let message else {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.parsingError))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completionHandler(.success(message))
                }
                
            case .failure:
                DispatchQueue.main.async {
                    completionHandler(.failure(.general))
                }
            }
        }
    }
    
    func cancelRequest() {
        dataTask?.cancel()
    }
}

class FakeAnalyzerProvider: AnalyzerProviding {
    private var isCancleled = false
    
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        isCancleled = false
        
        let analyzedMessage = AnalyzedMessage(message: "Some recorded text")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            guard !self.isCancleled else { return }
            completionHandler(.success(analyzedMessage))
        }
    }
    
    func cancelRequest() {
        isCancleled = true
    }
}
