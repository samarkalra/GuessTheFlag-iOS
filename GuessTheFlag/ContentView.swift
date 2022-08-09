//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Samar Kalra on 05/08/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var score = 0
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correntAnswer = Int.random(in: 0...2)
    @State private var currentQuestionNumber = 1
    private var maxNoOfQuestion = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            
            
            VStack(spacing: 10) {
                Text("Question \(currentQuestionNumber)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.white)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correntAnswer])
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .alert("Result", isPresented: $showingScore) {
             Button("Restart Quiz", action: restartQuiz)
        } message: {
            Text("You got \(score) correct out of \(maxNoOfQuestion)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correntAnswer {
            score += 1
        }
        
        currentQuestionNumber += 1
        
        if(currentQuestionNumber > maxNoOfQuestion) {
            currentQuestionNumber -= 1
            showingScore = true
        } else {
            askQuestion()
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correntAnswer = Int.random(in: 0...2)
    }
    
    func restartQuiz() {
        currentQuestionNumber = 1
        score = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
