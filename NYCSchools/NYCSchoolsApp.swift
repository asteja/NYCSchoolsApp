//
//  NYCSchoolsApp.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import SwiftUI

@main
struct NYCSchoolsApp: App {
    var body: some Scene {
        WindowGroup {
            SchoolListView()
                .environmentObject(ViewModel(provider: SchoolDataProviderImpl()))
        }
    }
}
