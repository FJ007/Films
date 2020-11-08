//
//  RowFilm.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import SwiftUI

struct FilmRow: View {
    let score:Score
    
    var body: some View {
        VStack {
            Image("\(score.cover)")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 165, height: 165)
                .cornerRadius(12)
                .shadow(color: .black, radius: 2)
                .accessibility(label: Text("\(score.title)"))
                .accessibility(identifier: "cover")
                .overlay(
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .opacity(0.2)
                            .foregroundColor(.black)
                            .blur(radius: 1)
                        VStack{
                            if score.tracks != nil {
                                HStack{
                                    Spacer()
                                    Circle()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.black)
                                        .opacity(0.9)
                                        .overlay(
                                            Image(systemName: "rectangle.stack")
                                                .font(.body)
                                                .foregroundColor(.white)
                                        )
                                        .padding([.top, .trailing], 5)
                                }
                            }
                            Spacer()
                            ZStack {
                                Rectangle()
                                    .frame(height: 60)
                                    .foregroundColor(.black)
                                    .opacity(0.9)
                                    .cornerRadius(12)
                                    .overlay(
                                        VStack {
                                            Text("\(score.title)")
                                                .font(.footnote)
                                                .bold()
                                                .multilineTextAlignment(.center)
                                                .foregroundColor(.white)
                                                .padding(.top, 15)
                                        }
                                    )
                                Image(score.composer)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 35, height: 35, alignment: .center)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                    .padding([.top, .trailing], 5)
                                    .offset(y: -35)
                            }
                        }
                    }
            )
        }
    }
}


struct RowFilm_Previews: PreviewProvider {
    static var previews: some View {
        FilmRow(score: ScoresData.scoreAndTracksTest)
            .previewLayout(.fixed(width: 200, height: 200))
        FilmRow(score: ScoresData.scoreAndTracksTest)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
