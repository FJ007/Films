//
//  EditFormView.swift
//  Films
//
//  Created by Javier Fernández on 07/11/2020.
//

import SwiftUI

struct EditFormView: View {
    @EnvironmentObject var scoreData:ScoresData
    @Environment(\.presentationMode) var presentation
    let score:Score
    
    @State private var title = ""
    @State private var composer = ""
    @State private var year = ""
    @State private var length = ""
    
    var body: some View {
        Form {
            Section(header: Text("Title")) {
                TextField("Insert a title..", text: $title)
            }
            Section(header: Text("Composer")) {
                TextField("Add a composer..", text: $composer)
            }
            Section(header: Text("Description")) {
                HStack {
                    TextField("Year", text: $year)
                    Divider()
                    TextField("Length", text: $length)
                }
            }
            Section(header: Text("Cover")) {
                Image(decorative: "\(score.cover)")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 280)
                    .cornerRadius(12)
                    .shadow(radius: 4)
            }
        }
        .onAppear {
            title = score.title
            composer = score.composer
            year = "\(score.year)"
            length = "\(score.length)\""
        }
        .navigationTitle("Edit Score")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
            Button(action: {
                save()
            }, label: {
                Text("Save")
            })
        )
    }
    
    func save() {
        if let index = scoreData.scores.firstIndex(where: { $0.id == score.id }) {
            // Si nuestro struct del modelo es let:
//            let newScore = Score(id: score.id,
//                                     title: title,
//                                     composer: composer,
//                                     year: Int(year)!,
//                                     length: Int(length)!,
//                                     cover: score.composer,
//                                     tracks: score.tracks)
//            scoreData.scores[index] = newScore
            scoreData.scores[index].id = score.id
            scoreData.scores[index].title = title
            scoreData.scores[index].composer = composer
            scoreData.scores[index].year = Int(year) ?? scoreData.scores[index].year
            scoreData.scores[index].length = Int(length) ?? scoreData.scores[index].length
            
            presentation.wrappedValue.dismiss()
        }
    }
}

struct EditFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditFormView(score: ScoresData.scoreTest)
                .environmentObject(ScoresData())
        }
    }
}
