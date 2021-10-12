//
//  QuizRowView.swift
//  P1-IWEB-quiz (iOS)
//
//  Created by Samuel García Sánchez on 2/10/21.
//

import SwiftUI

struct QuizRowView: View {
    
    var quizItem: QuizItem
    
    var body: some View {
        
        let aurl = quizItem.attachment?.url
        let anivm = NetworkImageViewModel(url: aurl)
        
        let uurl = quizItem.author?.photo?.url
        let univm = NetworkImageViewModel(url: uurl)
        
        return
            HStack{
                
                NetworkImageView(viewModel: anivm)
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(lineWidth: 4))
                
                VStack{
                    Text(quizItem.question)
                        .font(.headline)
                        .foregroundColor(.green)
                    
                    HStack(alignment: .bottom, spacing: 5) {
                    
                        Text(quizItem.author?.username ?? "anonymous")
                            .font(.callout)
                            .foregroundColor(.blue)
                                
                        NetworkImageView(viewModel: univm)
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(lineWidth: 2))
                        
                        Spacer()
                        
                        Image(quizItem.favourite ? "star-yellow" : "star-empty")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .scaledToFit()
                        
                    }
                }
            }
        }
}

//struct QuizRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        QuizRowView()
//    }
//}
