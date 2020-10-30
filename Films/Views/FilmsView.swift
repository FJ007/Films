//
//  FilmsView.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import SwiftUI

struct FilmsView: View {
    
    @ObservedObject var scoresData = ScoresData()
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(scoresData.scores) { score in
                        RowFilmView(score: score)
                    }
                }
                .padding()
            }
            .navigationTitle("Scores")
        }
    }
}

struct FilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsView()
    }
}

