//
//  P1_IWEB_quizApp.swift
//  Shared
//
//  Created by Samuel García Sánchez on 30/9/21.
//

import SwiftUI

@main
struct P1_IWEB_quizApp: App {
    
    let quizzesModel = QuizzesModel()
    let scoresModel = ScoresModel()
    
    
    var body: some Scene {
        WindowGroup {
            QuizzesListView()
                .environmentObject(quizzesModel)
                .environmentObject(scoresModel)        }
    }
}
