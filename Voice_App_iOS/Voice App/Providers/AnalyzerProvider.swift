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
}

class AnalyzerProvider: AnalyzerProviding {
    private let client = APIClient()
    
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        let request = AnalizeRequest(filePath: url)
        client.send(request) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let data):
                let message = try? JSONDecoder().decode(AnalyzedMessage.self, from: data)
                guard let message else {
                    completionHandler(.failure(.parsingError))
                    return
                }
                
                completionHandler(.success(message))
                
            case .failure:
                completionHandler(.failure(.general))
            }
        }
    }
}

class FakeAnalyzerProvider: AnalyzerProviding {
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        let analyzedMessage = AnalyzedMessage(message: "Some recorded text")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            completionHandler(.success(analyzedMessage))
        }
    }
}
