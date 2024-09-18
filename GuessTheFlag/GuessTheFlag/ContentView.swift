//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Сухарик on 18.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var finish = ""
    
    @State private var rotateAmount = [0.0, 0.0, 0.0]
    @State private var opacityAmount = [1.0, 1.0, 1.0]
    @State private var scaleAmount = [1.0, 1.0, 1.0]
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                
            
            VStack {
                Spacer()
                Text("Guess the flag")
                    .font(.largeTitle.bold())
                
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                        .rotation3DEffect(Angle(degrees: rotateAmount[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(opacityAmount[number])
                        .scaleEffect(scaleAmount[number])
                        .animation(.default, value: scaleAmount)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                HStack {
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .frame(width: 200,alignment: .bottomLeading)
                    Button("Reset",action: reset)
                        .tint(.black)
                        .font(.title)
                        .frame(width: 100,alignment: .bottomTrailing)
                        .buttonStyle(.bordered)
                }
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        let selectedAnswer = countries[number]
        
        rotateAmount[number] += 360
        for notTapped in 0..<3 where notTapped != number {
                    opacityAmount[notTapped] = 0.25
                    scaleAmount[notTapped] = 0.85
                }
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong \nIt's a flag of the \(selectedAnswer)"
            if score < 1 {
                score = 0
            } else {
                score -= 1
            }
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
        opacityAmount = [1.0, 1.0, 1.0]
        scaleAmount = [1.0, 1.0, 1.0]
    }
    
    func reset() {
        countries.shuffle()
        score = 0
        
        opacityAmount = [1.0, 1.0, 1.0]
        scaleAmount = [1.0, 1.0, 1.0]
    }
}

#Preview {
    ContentView()
}
