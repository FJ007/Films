//
//  Score.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import Foundation

struct Score: Identifiable, Codable {
    var id: Int
    var title: String
    var composer: String
    var year: Int
    var length: Int
    var cover: String
    var tracks: [String]?
}

final class ScoresData: ObservableObject {
    @Published var scores: [Score] = []
    var composers: [String] = []
    
    static let scoreTest = Score(id: 71,
                          title: "Doctor Strange",
                          composer: "Michael Giacchino",
                          year: 2016,
                          length: 73,
                          cover: "DoctorStrange",
                          tracks: nil)
    
    init() {
        guard let path = Bundle.main.url(forResource: "scoresdata", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: path)
            scores = try JSONDecoder().decode([Score].self, from: data)
            composers = Array(Set(scores.map { $0.composer } ))
            composers.append("None")
        } catch {
            print("ERROR: nose ha podido cargar el fichero debido a \(error)")
        }
    }
    
    func delete(score: Score) {
        scores.removeAll() { s in
            s.id == score.id
        }
    }
    
    func filteredComposer(filter: String) -> [Score] {
        scores.filter({
            if filter.isEmpty || filter == "None" {
                return true
            } else {
                return filter == $0.composer
            }
        })
    }
}
