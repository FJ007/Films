//
//  FilmListRowView.swift
//  Films
//
//  Created by Javier Fernández on 04/11/2020.
//

import SwiftUI

struct FilmListRow: View {
    let score:Score
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(score.title)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.primary)
                Text("\(String(score.year)) - \(score.length)\"")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 8)
                if let tracks = score.tracks {
                    DisclosureGroup(
                        content: {
                            Divider()
                            ForEach(tracks, id:\.self) { track in
                                Text("\(track)")
                                    .font(.caption)
                                    .bold()
                                    .foregroundColor(.secondary)
                            }
                        }, label: {
                            Image("\(score.composer)")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 35, height: 35)
                                .clipShape(Circle())
                            Text("\(score.composer)")
                                .font(.footnote)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        })
                        .accentColor(.gray)
                }
            }
            Spacer()
            Image(score.cover)
                .resizable()
                .scaledToFit()
                .frame(width: 115, height: 115)
                .cornerRadius(8)
                .padding(.horizontal, 10)
        }
        .animation(.default)
        .padding(8)
    }
}


struct FilmListRowView_Previews: PreviewProvider {
    static var previews: some View {
        FilmListRow(score: ScoresData.scoreTest)
            .previewLayout(.fixed(width: 325, height: 150))
        FilmListRow(score: ScoresData.scoreTest)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 325, height: 150))
        FilmListRow(score: ScoresData.scoreAndTracksTest)
            .preferredColorScheme(.light)
            .previewLayout(.fixed(width: 325, height: 150))
        FilmListRow(score: ScoresData.scoreAndTracksTest)
            .preferredColorScheme(.dark)
            .previewLayout(.fixed(width: 325, height: 150))
    }
}
