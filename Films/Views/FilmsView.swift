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
    @State var filterComposer = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(scoresData.filteredComposer(filter: filterComposer)) { score in
                        RowFilmView(score: score)
                            .contextMenu {
                                Button(action: {
                                    scoresData.delete(score: score)
                                }, label: {
                                    Text("Delete")
                                    Image(systemName: "trash")
                                })
                            }
                            .animation(.default)
                    }
                }
                .padding()
            }
            .navigationTitle("Scores")
            .navigationBarItems(trailing: MenuFilterComposers(composers: scoresData.composers,
                                                              filterComposer: $filterComposer)
            )
        }
    }
}

struct FilmsView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsView()
    }
}

// MARK: - SubViews

/// Menu de filtrado por compositores
struct MenuFilterComposers: View {
    
    let composers:[String]
    @Binding var filterComposer: String
    
    var body: some View {
        Menu {
            ForEach(composers, id:\.self) { composer in
                Button(action: {
                    filterComposer = composer
                }, label: {
                    Text("\(composer)")
                    Image("\(composer)")
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                })
            }
        } label: {
            Image(systemName: filterComposer.isEmpty || filterComposer == "None" ?
                    "line.horizontal.3.decrease.circle" :
                    "line.horizontal.3.decrease.circle.fill")
                .font(.title)
        }
    }
}
