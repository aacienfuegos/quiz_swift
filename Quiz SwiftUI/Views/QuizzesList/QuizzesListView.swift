//
//  ContentView.swift
//  Shared
//
//  Created by Samuel García Sánchez on 30/9/21.
//

import SwiftUI

struct QuizzesListView: View {
    
    @EnvironmentObject var quizzesModel: QuizzesModel
    @EnvironmentObject var scoresModel: ScoresModel
    
    @State var verTodo: Bool = true
    
    var body: some View {
        
        NavigationView {
			VStack{
				Text("Record: \(scoresModel.record.count)")
				List {
					Toggle("Ver Todo", isOn: $verTodo)
					ForEach(quizzesModel.quizzes) { qi in
						if verTodo || !scoresModel.acertada(qi){
							NavigationLink(destination: QuizPlayView(quizItem: qi)) {
								QuizRowView(quizItem: qi)
							}
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuizzesListView()
    }
}
