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
        
        let boundary = UUID().uuidString
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"wavefile.wav\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: audio/wav\r\n\r\n".data(using: .utf8)!)
        body.append(contentsOf: try! Data(contentsOf: request.filePath))
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        urlRequest.httpBody = body

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
    
    func sendUploadTask(_ request: Request, handler: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod
        urlRequest.setValue(request.contentType, forHTTPHeaderField: "Content-Type")
        
        let task = urlSession.uploadTask(with: urlRequest, fromFile: request.filePath) { data, response, error in
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
