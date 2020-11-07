//
//  FilmsMainView.swift
//  Films
//
//  Created by Javier Fernández on 04/11/2020.
//

import SwiftUI

struct FilmsView: View {
    @EnvironmentObject var scoresData:ScoresData
    @State private var filterComposer = ""
    @State private var showListFilmView = true
    
    var body: some View {
        VStack{
            if showListFilmView {
                NavigationView {
                    FilmsListView(filterComposer: $filterComposer)
                        .modifier(FilmStyle(showListFilmView: $showListFilmView,
                                                filterComposer: $filterComposer,
                                                scoresData: scoresData))
                }
            } else {
                NavigationView {
                    FilmsGridView(filterComposer: $filterComposer)
                        .modifier(FilmStyle(showListFilmView: $showListFilmView,
                                                filterComposer: $filterComposer,
                                                scoresData: scoresData))
                }
            }
        }
    }
}

struct FilmsMainView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsView()
            .environmentObject(ScoresData())
    }
}
//MARK: - Subviews
/// Menú de filtrado por compositores
struct MenuFilterComposers: View {
    let composers:[String]
    @Binding var filterComposer:String
    
    var body: some View {
        Menu {
            ForEach(composers, id:\.self) { composer in
                Button(action: {
                    withAnimation {
                        filterComposer = composer
                    }
                }, label: {
                    Text("\(composer)")
                    Image("\(composer)")
                    //.resizable()
                    //.scaledToFit()
                    //.clipShape(Circle())
                })
            }
        } label: {
            Image(systemName: filterComposer.isEmpty || filterComposer == "None" ?
                    "line.horizontal.3.decrease.circle" :
                    "line.horizontal.3.decrease.circle.fill")
                .font(.title2)
                .foregroundColor(.black)
        }
    }
}

//MARK: - Styles

struct FilmStyle:ViewModifier {
    @Binding var showListFilmView:Bool
    @Binding var filterComposer:String
    let scoresData:ScoresData
    
    func body(content: Content) -> some View {
        content
            .navigationTitle("Scores")
            .navigationBarItems(
                leading:
                    EditButton()
                    .disabled(showListFilmView ? false : true)
                    .opacity(showListFilmView ? 1 : 0.3)
                    .foregroundColor(.black)
                ,trailing:
                    HStack {
                        MenuFilterComposers(composers: scoresData.composers,
                                            filterComposer: $filterComposer).padding()
                        Button(action: {
                            withAnimation {
                                showListFilmView.toggle()
                            }
                        }, label: {
                            Image(systemName: showListFilmView ? "list.bullet.rectangle" : "list.dash")
                                .font(.title2)
                                .foregroundColor(.black)
                        })
                    }
            )
    }
    
}

