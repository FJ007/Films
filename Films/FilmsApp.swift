//
//  FilmsApp.swift
//  Films
//
//  Created by Javier Fernández on 30/10/2020.
//

import SwiftUI

@main
struct FilmsApp: App {
    @StateObject var scoresData = ScoresData()
    
    
    var body: some Scene {
        WindowGroup {
            FilmsMainView()
                .environmentObject(scoresData)
        }
    }
}

struct FilmsApp_Previews: PreviewProvider {
    static var previews: some View {
        FilmsView()
    }
}
