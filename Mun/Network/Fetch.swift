//
//  File.swift
//  Mun
//
//  Created by Tomás García Gobet on 16.09.23.
//

import Foundation

class Fetch {
    func load<T: Codable>(_ resource: Resource<T>) async throws -> T {
        var request = URLRequest(url: resource.url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = resource.headers
        
        switch resource.method {
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else { throw NetworkError.badUrl }
            request = URLRequest(url: url)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200
        else { throw NetworkError.invalidResponse }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch  {
            print(error)
            throw NetworkError.decodingError
        }
    }
}

enum HTTPMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

enum NetworkError: Error {
    case invalidResponse, badUrl, decodingError
}

struct Resource<T: Codable> {
    let url: URL
    var headers: [String: String] = ["Content-Type": "application/json"]
    var method: HTTPMethod = .get([])
}

