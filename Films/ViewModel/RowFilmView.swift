//
//  RowFilm.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import SwiftUI

struct RowFilmView: View {
    let score: Score
    var body: some View {
        Image("\(score.cover)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 165, height: 165)
            .cornerRadius(12)
            .shadow(color: .black, radius: 2)
            .overlay(
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
                    Rectangle()
                        .frame(width: .infinity, height: 50)
                        .foregroundColor(.black)
                        .opacity(0.8)
                        .cornerRadius(12)
                        .overlay(
                            Text("\(score.title)")
                                .font(.caption)
                                .bold()
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .padding(.horizontal, 3)
                        )
                }
            )
    }
}


struct RowFilm_Previews: PreviewProvider {
    static var previews: some View {
        RowFilmView(score: ScoresData.scoreTest)
    }
}
