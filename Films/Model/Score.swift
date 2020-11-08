//
//  Score.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import Foundation

struct Score: Identifiable, Codable {
    var id:Int
    var title:String
    var composer:String
    var year:Int
    var length:Int
    var cover:String
    var tracks:[String]?
}

final class ScoresData: ObservableObject {
    @Published var scores:[Score] = []
    var composers:[String] = []
    
    // Sections by composers
    var groupComposers:[[Score]] {
        Dictionary(grouping: scores) { (score:Score) in
            score.composer
        }
        .values
        .sorted(by: { ($0.first?.composer ?? "") < ($1.first?.composer ?? "") })
    }
    
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
            print("ERROR: The file could not be downloaded for \(error.localizedDescription)")
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
    
    
    // MARK: - Test 
    static var scoreTest = Score(id: 1000,
                                 title: "Doctor Strange",
                                 composer: "Michael Giacchino",
                                 year: 2016,
                                 length: 73,
                                 cover: "DoctorStrange",
                                 tracks: nil)
    
    static var scoreAndTracksTest = Score(id: 2000,
                                          title: "Home Alone",
                                          composer: "John Williams",
                                          year: 1990,
                                          length: 67,
                                          cover: "HomeAlone",
                                          tracks: [
                                            "1. Home Alone Main Title ('Somewhere In My Memory') (04:53) ",
                                            "2. Holiday Flight (00:59) ",
                                            "3. The House (02:27) ",
                                            "4. Star Of Bethlehem (Orchestral Version) (02:51) ",
                                            "5. Man Of The House (04:33) ",
                                            "6. White Christmas (02:40) ",
                                            "7. Scammed By A Kindergartner (03:55) ",
                                            "8. Please Come Home For Christmas (02:41) ",
                                            "9. Follow That Kid! (02:03) ",
                                            "10. Making The Plane (00:52) ",
                                            "11. O Holy Night (02:48) ",
                                            "12. Carol Of The Bells (01:25) ",
                                            "13. Star Of Bethlehem (02:59) ",
                                            "14. Setting The Trap (02:16) ",
                                            "15. Somewhere In My Memory (01:04) ",
                                            "16. The Attack On The House (06:53) ",
                                            "17. Mom Returns and Finale (04:19) ",
                                            "18. Have Yourself A Merry Little Christmas (03:05) ",
                                            "19. We Wish You A Merry Christmas / End Title (04:15) "
                                          ])
}
