//
//  EndpointLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-24.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation


struct YnabEndpointError: Decodable, Error {
    let id: String
    let name: String
    let detail: String
}

struct YnabErrorResponse: Decodable {
    let error: YnabEndpointError
}

struct EndpointLoader<ResultType: Decodable> {
    
    var accessToken: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Properties", ofType: "plist") else {
                fatalError("Couldn't find properties plist file")
            }
            
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "YNAB-Developer-Token") as? String else {
                fatalError("Coudln't find YNAB-Developer-Token in properties file")
            }
            
            return value
        }
    }
    
    static func BuildEndPointURL(with endpoint: String, queryItems: [URLQueryItem]) -> URL {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.youneedabudget.com"
        urlComponents.path = "/v1/\(endpoint)"
        urlComponents.queryItems = queryItems
        
        return urlComponents.url!
        
    }
    
    typealias Callback = (Result) -> Void
    
    struct Response: Decodable {
        let data: ResultType
    }
    
    enum Result {
        case Success(ResultType)
        case Failed(Error?)
    }
    
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func loadDataFrom(endpoint: String, with queryItems: [URLQueryItem] = [URLQueryItem](), then handler: @escaping Callback) {
        
        var request = URLRequest(url: EndpointLoader.BuildEndPointURL(with: endpoint, queryItems: queryItems))
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let httpResponse = response as? HTTPURLResponse {
                do {
                    if (200...299).contains(httpResponse.statusCode) {
                        printResponse(data: data)
                        let parsedResponse = try decoder.decode(Response.self, from: data!)
                        handler(.Success(parsedResponse.data))
                    } else {
                        printResponse(data: data)
                        let parsedResponse = try decoder.decode(YnabErrorResponse.self, from: data!)
                        handler(.Failed(parsedResponse.error))
                    }
                } catch {
                    print(error)
                    handler(.Failed(error))
                }
            } else {
                handler(.Failed(error))
            }
            
        }
        task.resume()
    }
    
    private func printResponse(data: Data?) {
        if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
            print(json)
        } else {
            print("Something bad happened")
        }
    }
}
