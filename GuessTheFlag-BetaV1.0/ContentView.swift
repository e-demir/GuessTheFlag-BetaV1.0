//
//  ContentView.swift
//  GuessTheFlag-BetaV1.0
//
//  Created by Emrullah Demir on 8.11.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var finishGame = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var questionCount = 8
    
    func restartGame(){
        score = 0
        questionCount = 8
        askQuestion()
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 10
        } else {
            scoreTitle = "Wrong, it is the flag of \(countries[number])"
            score -= 5
        }
        questionCount -= 1
        if(questionCount == 0){
            finishGame = true
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of").foregroundColor(.white).font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer]).foregroundColor(.white).font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                        }.clipShape(Capsule()).shadow(radius: 5)
                    }
                }
                Spacer()
                Spacer()
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Text("Remaining questions: \(questionCount)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
            } message: {
                Text("Your score is \(score)")
            }.alert("The game  has finihed", isPresented: $finishGame){
                Button("Play again", action: restartGame)
                } message: {
                    Text("Your score is \(score)")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
