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

/**
 API Service is a class which is responsible for making api calls using low level apis like URLSession to fetch the data
 */
class APIService {
    
    static let shared = APIService()
    
    var urlComponents: URLComponents? = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "data.cityofnewyork.us"
        return urlComponents
    }()
    
    /**
    This is an async method which fetches the data from the real time api service for schools list
     -Returns: a result type with data on success and error on failure
     */
    func getHighSchools() async throws -> Result<Data, Error> {
        urlComponents?.path = "/resource/s3k6-pzi2.json"
        return try await request(for: urlComponents?.url)
//        return try await request(for: urlComponents?.url, file: "Schools")
    }
    
    /**
    This is an async method which fetches the data from the real time api service for results
     -Returns: a result type with data on success and error on failure
     */
    func getSATResults() async throws -> Result<Data, Error> {
        urlComponents?.path = "/resource/f9bf-2cp4.json"
        return try await request(for: urlComponents?.url)
//        return try await request(for: urlComponents?.url, file: "Results")
    }
    
    /**
     This method loads the data from the json file
     */
    func request(for url: URL?, file: String = "") async throws -> Result<Data, Error> {
        guard let _ = url else {
            return .failure(APIError.urlNotFound)
        }
        guard let fileURL = Bundle.main.url(forResource: file, withExtension: "json"),
              let data = try? Data(contentsOf: fileURL) else {
                  return .failure(APIError.badRequest)
              }
        return .success(data)
    }
    
    
    /**
     This method makes a network to fetch the data from the real time api
     */
    func request(for url: URL?) async throws -> Result<Data, Error> {
        guard let url = url else {
            return .failure(APIError.urlNotFound)
        }
        let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return .failure(APIError.badRequest)
        }
        return .success(data)
    }
}
