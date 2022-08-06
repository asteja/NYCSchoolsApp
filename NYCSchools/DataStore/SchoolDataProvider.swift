//
//  SchoolDataProvider.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import Foundation
import Combine

/**SchoolDataProvider is a protocol defines the requirements of ViewModel to show the data on the UI. This protocol separates the code from being tightly coupled to provide clean architecture.
 
    Example Usage:
 
    class MagicClass: SchoolDataProvider {
        ....
    }
 */
protocol SchoolDataProvider {
    func getHighSchools() -> AnyPublisher<[School], Never>
    func getSATResults() -> AnyPublisher<[SATScore], Never>
}

class SchoolDataProviderImpl: SchoolDataProvider {
    
    /**
        This method makes a call to the api layer to fetch the data from service and this method does not  fail because error is  handled with  empty array
        -Returns: returns a publsiher with output has array of school and Failure has never
     */
    func getHighSchools() -> AnyPublisher<[School], Never> {
        return Future { promise in
            Task {
                let result = try await APIService.shared.getHighSchools()
                switch result {
                case .success(let data):
                    do {
                        let schools = try JSONDecoder().decode([School].self, from: data)
                        promise(.success(schools))
                    }catch {
                        promise(.success([]))
                    }
                case .failure(_):
                    promise(.success([]))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    /**
        This method makes a call to the api layer to fetch the data from service and this method does not  fail because error is  handled with  empty array
        -Returns: returns a publsiher with output has array of school and Failure has never
     */
    func getSATResults() -> AnyPublisher<[SATScore], Never> {
        return Future { promise in
            Task {
                let result = try await APIService.shared.getSATResults()
                switch result {
                case .success(let data):
                    do {
                        let scores = try JSONDecoder().decode([SATScore].self, from: data)
                        promise(.success(scores))
                    }catch {
                        promise(.success([]))
                    }
                case .failure(_):
                    promise(.success([]))
                }
            }
        }.eraseToAnyPublisher()
    }
}
