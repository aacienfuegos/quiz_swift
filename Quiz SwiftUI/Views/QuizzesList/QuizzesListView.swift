//
//  ContentView.swift
//  Shared
//
//  Created by Samuel García Sánchez on 30/9/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    
    var body: some View {
        
        NavigationView {
            List {
                ForEach(quizzesModel.quizzes) { qi in
                    
                    NavigationLink(destination: QuizPlayView(quizItem: qi)) {
                        QuizRowView(quizItem: qi)
                    }
                }
            }
            .padding()
            .navigationBarTitle(Text("Quiz SwiftUI"))
            .onAppear {
                quizzesModel.load()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesListView()
    }
}