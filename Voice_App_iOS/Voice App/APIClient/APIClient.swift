//
//  APIClient.swift
//  Voice App
//
//  Created by Sergey Prybysh on 9/23/23.
//

import Foundation

protocol APIClienting: AnyObject { }

class APIClient: APIClienting {
    private let urlSession = URLSession.shared

    func sendDataTask(_ request: Request, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")

        if let body = request.body {
            urlRequest.httpBody = body
        }

        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
           if let error = error {
               handler(.failure(error))
           } else if let data = data, let response = response as? HTTPURLResponse {
               print("Response: \(response.statusCode)")
               handler(.success(data))
           }
        }
            
        task.resume()
        
        return task
    }
    
    func makeAudioRequest(_ request: RecognizeRequest, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")

        let credentials = "apikey:\(Credentials.voice_api_key)"
        let base64Credentials = Data(credentials.utf8).base64EncodedString()
        urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")

        if let body = request.body {
            urlRequest.httpBody = body
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
           if let error = error {
               handler(.failure(error))
           } else if let data = data, let response = response as? HTTPURLResponse {
               print("Response: \(response.statusCode)")
               handler(.success(data))
           }
        }
            
        task.resume()
        
        return task
    }
    
    func makeAnalizeRequest(_ request: AnalizeRequest, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")

        let credentials = "apikey:\(Credentials.recognize_api_key)"
        let base64Credentials = Data(credentials.utf8).base64EncodedString()
        urlRequest.setValue("Basic \(base64Credentials)", forHTTPHeaderField: "Authorization")
        
        if let body = request.body {
            urlRequest.httpBody = body
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
           if let error = error {
               handler(.failure(error))
           } else if let data = data, let response = response as? HTTPURLResponse {
               print("Response: \(response.statusCode)")
               handler(.success(data))
           }
        }
            
        task.resume()
        
        return task
    }
}
