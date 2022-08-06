//
//  APIServiceTests.swift
//  NYCSchoolsTests
//
//  Created by Saiteja Alle on 8/5/22.
//

import XCTest
@testable import NYCSchools

class APIServiceTests: XCTestCase {
    
    let target = APIService.shared
    
    // This test is used to test the response time of api by expecting response in 2 seconds
    func testGetHighSchools() {
        //Given
        let exp = expectation(description: "Get High Schools")
        //When
        Task {
            let result = try await target.getHighSchools()
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        //Then
        wait(for: [exp], timeout: 2)
    }
    
    // This test is used to test the response time of api by expecting response in 2 seconds
    func testGetSATResults() {
        //Given
        let exp = expectation(description: "Get SAT Results")
        //When
        Task {
            let result = try await target.getSATResults()
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            exp.fulfill()
        }
        //Then
        wait(for: [exp], timeout: 2)
    }
}
