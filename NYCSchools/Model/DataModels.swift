//
//  DataModels.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import Foundation

// School represents the data structure for the data received from service
struct School: Codable {
    var uniqueId: String
    var name: String
    var overview: String
    var location: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "dbn"
        case name = "school_name"
        case overview = "overview_paragraph"
        case location = "location"
    }
}

//SATScore represents the data structure for the data that we receive from the service
struct SATScore: Codable {
    var uniqueId: String
    var schoolName: String
    var testTakers: String
    var reading: String
    var writing: String
    var math: String
    
    enum CodingKeys: String, CodingKey {
        case uniqueId = "dbn"
        case schoolName = "school_name"
        case testTakers = "num_of_sat_test_takers"
        case reading = "sat_critical_reading_avg_score"
        case writing = "sat_math_avg_score"
        case math = "sat_writing_avg_score"
    }
}
