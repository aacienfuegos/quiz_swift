//
//  QuizzesModel.swift
//  P1 Quiz SwiftUI
//
//  Created by Santiago Pavón Gómez on 17/09/2021.
//

import Foundation

class QuizzesModel: ObservableObject {
    
    // Los datos
    @Published private(set) var quizzes = [QuizItem]()
	
	let URL_BASE = "https://core.dit.upm.es/api"
	let TOKEN = "c077a2641b40e0fb129a"
    
    func load() {
                
        guard let jsonURL = Bundle.main.url(forResource: "p1_quizzes", withExtension: "json") else {
            print("Internal error: No encuentro p1_quizzes.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            let decoder = JSONDecoder()
            
//            if let str = String(data: data, encoding: String.Encoding.utf8) {
//                print("Quizzes ==>", str)
//            }
            
            let quizzes = try decoder.decode([QuizItem].self, from: data)
            
            self.quizzes = quizzes

            print("Quizzes cargados")
        } catch {
            print("Algo chungo ha pasado: \(error)")
        }
    }
	
	func download(){
		let urlStr = "\(URL_BASE)/quizzes/random10wa?token=\(TOKEN)"
		
		guard let url = URL(string: urlStr) else {
			print("Error 1: bad URL")
			return
		}
		
		URLSession.shared.dataTask(with: url) { (data, response, error) in
			if error == nil,
			   (response as! HTTPURLResponse).statusCode == 200,
			   let data = data {
				
				do {
					let quizzes = try JSONDecoder().decode([QuizItem].self, from: data)
					DispatchQueue.main.async {
						self.quizzes = quizzes
					}
				} catch {
					print("Error 3: bad JSON")
				}
			} else {
				print("Error 2: bad request")
			}
		}
		.resume()
	}
}
