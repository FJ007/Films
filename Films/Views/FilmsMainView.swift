//
//  FilmsMainView.swift
//  Films
//
//  Created by Javier Fernández on 04/11/2020.
//

import SwiftUI

struct FilmsMainView: View {
    @EnvironmentObject var scoresData:ScoresData
    @State private var filterComposer = ""
    @State private var showListFilmView = true
    
    var body: some View {
        NavigationView {
            VStack {
                if showListFilmView {
                    FilmsListView()
                } else {
                    FilmsView()
                }
            }
            .navigationTitle("Scores")
            .navigationBarItems(
                leading:
                    EditButton()
                        .disabled(showListFilmView ? false : true)
                        .opacity(showListFilmView ? 1 : 0.3)
                        .foregroundColor(.black)
                ,trailing:
                    HStack {
                        MenuFilterComposers(composers: scoresData.composers, filterComposer: $filterComposer)
                            .padding()
                        Button(action: {
                            showListFilmView.toggle()
                        }, label: {
                            Image(systemName: showListFilmView ? "list.bullet.rectangle" : "list.dash")
                                .font(.title2)
                                .foregroundColor(.black)
                        })
                    }
            )
        }
    }
}

struct FilmsMainView_Previews: PreviewProvider {
    static var previews: some View {
        FilmsMainView()
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
                    //                        .resizable()
                    //                        .scaledToFit()
                    //                        .clipShape(Circle())
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
