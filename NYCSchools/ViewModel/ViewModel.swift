//
//  ViewModel.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import Foundation
import Combine

// ViewModel class represents the data which we want to display on the view
class ViewModel: ObservableObject {
    
    @Published var schools: [School] = []
    @Published var scoreDict: [String: SATScore] = [:]
    @Published var showAlert: Bool = false
    private var bag = Set<AnyCancellable>()
    let provider: SchoolDataProvider!
    
    init(provider: SchoolDataProvider) {
        self.provider = provider
        getSchools()
        getResults()
    }
    
    /**
        This method calls the SchoolDataProider to fetch the list of schools from the service
     */
    func getSchools() {
        //Getting the School data
        provider.getHighSchools()
            .receive(on: DispatchQueue.main)
            .sink { _ in
                //Stop loading spinner here
            } receiveValue: { schools in
                if schools.isEmpty {
                    self.showAlert = true
                }else {
                    self.schools = schools
                }
            }
            .store(in: &bag)
    }
    
    /**
        This method calls the SchoolDataProider to fetch the sat score results from the service
     */
    func getResults() {
        //Getting the Results Data
        provider.getSATResults()
            .receive(on: DispatchQueue.main)
            .sink { error in
                //Stop loading spinner here
            } receiveValue: { scores in
                if scores.isEmpty {
                    self.showAlert = true
                }else {
                    self.scoreDict = scores.reduce(into: [String: SATScore](), { tempDict, score  in
                        tempDict[score.uniqueId] = score
                    })
                }
            }
            .store(in: &bag)
    }
}
