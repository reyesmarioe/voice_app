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
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<MessageData, AnalyzerError>) -> Void)
    func cancelRequest()
}

class AnalyzerProvider: AnalyzerProviding {
    private let client = APIClient()
    
    private var dataTask: URLSessionDataTask?
    
    func requestToAnalyze(url: URL, completionHandler: @escaping (Result<MessageData, AnalyzerError>) -> Void) {
        speachToTextRequest(url: url) { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(text):
                analyzeTextRequest(text: text) { analyzeResult in
                    switch analyzeResult {
                    case let .success(message):
                        let emotion = message.emotion.targets[0].emotion
                        let messageData = MessageData(
                            text: text,
                            numChar: message.usage.text_characters,
                            sentiment: message.sentiment.targets[0].label,
                            barData: [
                                Bar(name: "Sadness", score: emotion.sadness, color: "blue"),
                                Bar(name: "Joy", score: emotion.joy, color: "green"),
                                Bar(name: "Fear", score: emotion.fear, color: "orange"),
                                Bar(name: "Disgust", score: emotion.disgust, color: "purple"),
                                Bar(name: "Anger", score: emotion.anger, color: "red")
                            ])
                        DispatchQueue.main.async {
                          completionHandler(.success(messageData))
                        }
                    case let .failure(error):
                        DispatchQueue.main.async {
                          completionHandler(.failure(error))
                        }
                    }
                }
            case let .failure(error):
                print(error)
                DispatchQueue.main.async {
                  completionHandler(.failure(.general))
                }
            }
        }
    }
    
    private func speachToTextRequest(url: URL, completionHandler: @escaping (Result<String, AnalyzerError>) -> Void) {
        let request = RecognizeRequest(filePath: url)
        dataTask = client.makeAudioRequest(request) { result in
            switch result {
            case .success(let data):
                let messageResult = try? JSONDecoder().decode(VoiceAnalyzerResult.self, from: data)
                guard let messageResult else {
                    completionHandler(.failure(.parsingError))
                    return
                }
                
                completionHandler(.success(messageResult.results[0].alternatives[0].transcript))
                
            case .failure:
                completionHandler(.failure(.general))
            }
        }
    }
    
    private func analyzeTextRequest(text: String, completionHandler: @escaping (Result<AnalyzedMessage, AnalyzerError>) -> Void) {
        let request = AnalizeRequest(text: text)
        dataTask = client.makeAnalizeRequest(request) { result in
            switch result {
            case .success(let data):
                let messageResult = try? JSONDecoder().decode(AnalyzedMessage.self, from: data)
                guard let messageResult else {
                    completionHandler(.failure(.parsingError))
                    return
                }
                
                completionHandler(.success(messageResult))
                
            case .failure:
                completionHandler(.failure(.general))
            }
        }
    }

    
    func cancelRequest(){
        dataTask?.cancel()
    }
}
