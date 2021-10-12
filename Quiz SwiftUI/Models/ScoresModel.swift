//
//  ScoresModel.swift
//  P1-IWEB-quiz (iOS)
//
//  Created by Samuel García Sánchez on 3/10/21.
//

import SwiftUI
import Foundation

class ScoresModel: ObservableObject {
    
    @Published private(set) var acertadas: Set<Int> = []
    
    func check(respuesta: String, quiz: QuizItem) {
        
        let r1 = respuesta.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if r1 == r2 {
            acertadas.insert(quiz.id)
        }
    
    }
    
}
