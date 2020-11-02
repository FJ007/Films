//
//  FilmsView.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import SwiftUI

struct FilmsView: View {
    @ObservedObject var scoresData = ScoresData()
    let columns:[GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State var filterComposer = ""
    @State var isFilmDelete:Bool = false
    @State var selectScore:Score?
    @State var showTracks:Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(scoresData.filteredComposer(filter: filterComposer)) { score in
                            RowFilmView(score: score)
                                .contextMenu {
                                    Button(action: {
                                        isFilmDelete.toggle()
                                    }, label: {
                                        Text("Delete")
                                        Image(systemName: "trash")
                                    })
                                }
                                .onTapGesture(count: 1) {
                                    if score.tracks != nil {
                                        selectScore = score
                                        withAnimation {
                                            showTracks.toggle()
                                        }
                                    }
                                }
                                .alert(isPresented: $isFilmDelete, content: {
                                    Alert(title: Text("Notification"),
                                          message: Text("Are you sure delete \(score.title)?"),
                                          primaryButton: .cancel(),
                                          secondaryButton: .destructive(Text("Delete"),
                                          action: {
                                              scoresData.delete(score: score)
                                    }))
                                })
                                .animation(.default)
                        }
                    }
                    .padding()
                }
                .blur(radius: showTracks ? 3 : 0)
                if showTracks {
                    TracksView(selectScore: $selectScore, showTracks: $showTracks)
                        .animation(.default)
                }
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
                .font(.title)
                .foregroundColor(.black)
        }
    }
}

/// Listado de canciones por película
struct TracksView: View {
    @Binding var selectScore:Score?
    @Binding var showTracks:Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 24)
            .opacity(0.8)
            .shadow(radius: 10)
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                VStack {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Tracks")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                                .foregroundColor(.white)
                            Text("\(selectScore?.title ?? "")")
                                .font(.footnote)
                                .bold()
                                .foregroundColor(.white)
                            
                        }.padding()
                        Spacer()
                        Button(action: {
                            withAnimation(.default) {
                                showTracks.toggle()
                            }
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .opacity(0.9)
                        })
                        .padding()
                    }
                    ScrollView {
                        if let tracks = selectScore?.tracks {
                            ForEach(tracks, id:\.self) { track in
                                Text("\(track)")
                                    .font(.body)
                                    .bold()
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .padding(8)
                            }
                        }
                    }
                }
            )
            .offset(y: UIScreen.main.bounds.size.height * 0.15)
    }
}
