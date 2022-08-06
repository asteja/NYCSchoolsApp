//
//  ViewModelTests.swift
//  NYCSchoolsTests
//
//  Created by Saiteja Alle on 8/5/22.
//

import XCTest
import Combine
@testable import NYCSchools

class ViewModelTests: XCTestCase {
    
    private var bag = Set<AnyCancellable>()

    func testGetSchoolsOnSuccess() {
        //Given
        let provider = MockSchoolDataProvider()
        provider.successScenarioFlag = true
        let viewModel = ViewModel(provider: provider)
        //When
        viewModel.getSchools()
        //Then
        viewModel.$schools
            .dropFirst()
            .sink { schools in
                XCTAssertFalse(schools.isEmpty)
            }
            .store(in: &bag)
    }
    
    func testGetSchoolsOnFailure() {
        //Given
        let provider = MockSchoolDataProvider()
        let viewModel = ViewModel(provider: provider)
        //When
        viewModel.getSchools()
        //Then
        viewModel.$showAlert
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertTrue(value)
            })
            .store(in: &bag)
    }
    
    func testGetResultsOnSuccess() {
        //Given
        let provider = MockSchoolDataProvider()
        provider.successScenarioFlag = true
        let viewModel = ViewModel(provider: provider)
        //When
        viewModel.getResults()
        //Then
        viewModel.$scoreDict
            .dropFirst()
            .sink(receiveValue: { dict in
                XCTAssertFalse(dict.isEmpty)
            })
            .store(in: &bag)
    }
    
    func testGetResultsOnFailure() {
        //Given
        let provider = MockSchoolDataProvider()
        let viewModel = ViewModel(provider: provider)
        //When
        viewModel.getResults()
        //Then
        viewModel.$showAlert
            .dropFirst()
            .sink(receiveValue: { value in
                XCTAssertTrue(value)
            })
            .store(in: &bag)
    }
}

class MockSchoolDataProvider: SchoolDataProvider {
    var successScenarioFlag: Bool = false
    func getHighSchools() -> AnyPublisher<[School], Never> {
        return Future { [weak self] promise in
            if let weakSelf = self, weakSelf.successScenarioFlag {
                promise(.success([School(uniqueId: "3XNBG", name: "NEWYORK HIGH SCHOOL", overview: "School has good reputation", location: "Newyork City, NY")]))
            }else {
                promise(.success([]))
            }
        }.eraseToAnyPublisher()
    }
    
    func getSATResults() -> AnyPublisher<[SATScore], Never> {
        return Future { [weak self] promise in
            if let weakSelf = self, weakSelf.successScenarioFlag {
                promise(.success([SATScore(uniqueId: "3XNBG", schoolName: "NEWYORK HIGH SCHOOL", testTakers: "400", reading: "33", writing: "39", math: "400")]))
            }else {
                promise(.success([]))
            }
        }.eraseToAnyPublisher()
    }
}
