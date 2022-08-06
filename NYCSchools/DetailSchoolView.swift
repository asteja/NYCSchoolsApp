//
//  DetailSchoolView.swift
//  NYCSchools
//
//  Created by Saiteja Alle on 8/5/22.
//

import SwiftUI

struct DetailSchoolView: View {
    
    @EnvironmentObject var viewModel: ViewModel
    var school: School
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                //School name can be added as nav bar title but the text is truncating, might be an issue apple is still fixing it
                Text(school.name).font(Font.title)
                Text("Overview").font(Font.headline)
                Text(school.overview).font(Font.system(size: 12))
            }
            Group {
                Text("Location").font(Font.headline)
                Text(school.location).font(Font.system(size: 12))
            }
            Group {
                Text("SAT Scores").font(Font.headline)
                if let score = viewModel.scoreDict[school.uniqueId] {
                    Text("Test Takers: \(score.testTakers)")
                    Text("Reading Score: \(score.reading)")
                    Text("Writing Score: \(score.writing)")
                    Text("Math Score: \(score.math)")
                }else {
                    Text("Not Available")
                }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailSchoolView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSchoolView(school: School(uniqueId: "3XNBG",
                                        name: "NEWYORK HIGH SCHOOL",
                                        overview: "School has good reputation",
                                        location: "Newyork City, NY"))
    }
}
