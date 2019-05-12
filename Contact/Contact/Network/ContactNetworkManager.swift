//
//  ContactNetworkManager.swift
//  Contact
//
//  Created by Ankit Kedia on 10/05/19.
//  Copyright © 2019 Roposo. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (Data?, URLResponse?, Error?) -> Void
typealias ErrorHandler = (String) -> Void

class ContactNetworkManager {
    private let networkQueue = DispatchQueue.init(label: "networkDispatchQueue", qos: .background, attributes: .concurrent)
    static let genericError = "Something went wrong. Please try again later"
    static let sharedManager = ContactNetworkManager()
    
    func get<T: Codable>(urlString: String,
                           headers: [String: String] = [:],
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        
        let completionHandler: NetworkCompletionHandler = { (data, urlResponse, error) in
            if let error = error {
                print(error.localizedDescription)
                errorHandler(ContactNetworkManager.genericError)
                return
            }
            
            if self.isSuccessCode(urlResponse) {
                guard let data = data else {
                    print("Unable to parse the response in given type \(T.self)")
                    return errorHandler(ContactNetworkManager.genericError)
                }
                if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                    successHandler(responseObject)
                    return
                }
            }
            errorHandler(ContactNetworkManager.genericError)
        }
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        networkQueue.async {
            URLSession.shared.dataTask(with: request,
                                       completionHandler: completionHandler)
                .resume()
        }
    }
    
    func update<T: Codable>(urlString: String,
                            headers: [String: String] = [:],
                            model: T?,
                            successHandler: @escaping (T) -> Void,
                            errorHandler: @escaping ErrorHandler) {
        updateOrAdd(urlString: urlString, headers: headers, model: model, hhtpMethod: "PUT", successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func post<T: Codable>(urlString: String,
                            headers: [String: String] = [:],
                            model: T?,
                            successHandler: @escaping (T) -> Void,
                            errorHandler: @escaping ErrorHandler) {
        updateOrAdd(urlString: urlString, headers: headers, model: model, hhtpMethod: "POST", successHandler: successHandler, errorHandler: errorHandler)
    }
    
    func updateOrAdd<T: Codable>(urlString: String,
                           headers: [String: String] = [:],
                           model: T?,
                           hhtpMethod: String,
                           successHandler: @escaping (T) -> Void,
                           errorHandler: @escaping ErrorHandler) {
        
        guard let url = URL(string: urlString) else {
            return errorHandler("Unable to create URL from given string")
        }
        var request = URLRequest(url: url)
        request.httpMethod = hhtpMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonEncoder = JSONEncoder()
        do {
            let jsonData = try jsonEncoder.encode(model)
            let jsonString = String(data: jsonData, encoding: .utf8)
            print("JSON String : " + jsonString!)
            request.httpBody = jsonData
        }
        catch {
        }
        
        networkQueue.async {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                    errorHandler(ContactNetworkManager.genericError)
                    return
                }
                
                if self.isSuccessCode(response) {
                    guard let data = data else {
                        print("Unable to parse the response in given type \(T.self)")
                        return errorHandler(ContactNetworkManager.genericError)
                    }
                    if let responseObject = try? JSONDecoder().decode(T.self, from: data) {
                        successHandler(responseObject)
                        return
                    }
                }
                errorHandler(ContactNetworkManager.genericError)
            }).resume()
        }
    }
    
    
    private func isSuccessCode(_ statusCode: Int) -> Bool {
        return statusCode == 200
    }
    
    private func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return isSuccessCode(urlResponse.statusCode)
    }
    
}
