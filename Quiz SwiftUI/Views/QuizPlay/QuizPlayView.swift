//
//  QuizPlayView.swift
//  P1-IWEB-quiz (iOS)
//
//  Created by Samuel García Sánchez on 3/10/21.
//

import SwiftUI

struct QuizPlayView: View {
    var quizItem: QuizItem
    
    @EnvironmentObject var scoresModel: ScoresModel
    @State var answer: String = ""
    @State var showalert = false
    
    var body: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return
            
            VStack{
                HStack{
                    Text(quizItem.question)
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    Image(quizItem.favourite ? "star-yellow" : "star-empty")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .scaledToFit()
                }
                  
                TextField("Respuesta",
                          text: $answer,
                          onCommit: {
                             showalert = true
                             scoresModel.check(respuesta: answer, quiz: quizItem)
                          }
                )
                
                .alert(isPresented: $showalert) {
                    let s1 = quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let s2 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    return Alert(title: Text("Resultado:"),
                                 message: Text(s1 == s2 ? "!Has acertado!" : "Has fallado :("),
                                 dismissButton: .default(Text("Aceptar"))
                    )
                }
                
                Button(action: {
                    showalert = true
                    scoresModel.check(respuesta: answer, quiz: quizItem)
                }) {
                    Text("Comprobar")
                }
                
                GeometryReader { g in
                    NetworkImageView(viewModel: anivm)
                        .scaledToFill()
                        .frame(width: g.size.width, height: g.size.height)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .contentShape(RoundedRectangle(cornerRadius: 15))
                        .overlay(RoundedRectangle(cornerRadius: 15).stroke(lineWidth: 4))
                        .saturation(self.showalert ? 0.1 : 1)
                        .animation(.easeInOut, value: self.showalert)
                        .onTapGesture( count: 2){
                            answer = quizItem.answer
                        }
                
                }
                    
                HStack{
                    
                    Text("Score: \(scoresModel.acertadas.count)")
                    Spacer()
                    Text(quizItem.author?.username ?? "anonymous")
                        .font(.callout)
                        .foregroundColor(.blue)
                    NetworkImageView(viewModel: univm)
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(lineWidth: 2))
                }
            }
        
            .padding()
    }
}

//struct QuizPlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizPlayView()
//    }
//}
