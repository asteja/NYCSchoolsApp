//
//  APIService.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import Foundation

enum APIError: Error {
    case badRequest
    case urlNotFound
}

class APIService {
    
    static let shared = APIService()
    
    var urlComponents: URLComponents? = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        urlComponents.path = "resource"
        return urlComponents
    }()
    
    func getHighSchools() async throws -> Result<Data, Error> {
        urlComponents?.path.append("/s3k6-pzi2.json")
        return try await request(for: urlComponents?.url)
    }
    
    func getSATResults() async throws -> Result<Data, Error> {
        urlComponents?.path.append("/f9bf-2cp4.json")
        return try await request(for: urlComponents?.url)
    }
    
    func request(for url: URL?) async throws -> Result<Data, Error> {
        guard let url = url else {
            return .failure(APIError.urlNotFound)
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return .failure(APIError.badRequest)
        }
        return .success(data)
    }
}
