//
//  ContentView.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import SwiftUI

//School List view displays the list of the schools in the new york
//BY defaulte SwiftUI always places the views in the safe area
struct SchoolListView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView{
            List(viewModel.schools) { school in
                NavigationLink(school.name) {
                    DetailSchoolView(school: school)
                }
            }
            .navigationTitle("NYC High Schools")
        }
        .alert("Please check your connection", isPresented: $viewModel.showAlert) {
            Button("OK", role: .cancel) { }
        }
    }
}

extension School: Identifiable {
    var id: UUID {
        return UUID()
    }
}

struct SchoolListView_Previews: PreviewProvider {
    static var previews: some View {
        SchoolListView()
    }
}
