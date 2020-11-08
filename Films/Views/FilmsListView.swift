//
//  FilmsListView.swift
//  Films
//
//  Created by Javier Fernández on 04/11/2020.
//

import SwiftUI

struct FilmsListView: View {
    @EnvironmentObject var scoresData:ScoresData
    @Binding var filterComposer:String
    
    var body: some View {
        VStack {
            List {
                ForEach(scoresData.filteredComposer(filter: filterComposer)) { score in
                    NavigationLink(
                        destination:
                            EditFormView(score: score)
                        ,label: {
                            FilmListRow(score: score)
                        }
                    )
                }
                .onDelete(perform: { indexSet in
                    if let index = indexSet.first {
                        scoresData.delete(score: scoresData.scores[index])
                    }
                })
                .onMove(perform: { indices, newOffset in
                    if let index = indices.first {
                        scoresData.scores.insert(scoresData.scores.remove(at: index), at: newOffset)
                    }
                })
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct FilmsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FilmsListView(filterComposer: .constant(""))
                .environmentObject(ScoresData())
                .navigationTitle("Scores")
                .navigationBarItems(leading: 
                    EditButton()
                        .foregroundColor(.black)
                )
        }
    }
}

