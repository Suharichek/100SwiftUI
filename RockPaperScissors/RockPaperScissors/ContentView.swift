//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Сухарик on 20.07.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["🪨", "📄", "✂️"].shuffled()
    @State private var score = 0
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.lime, Color.darkGreen], startPoint: .top, endPoint: .bottom)
            
            VStack {
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .frame(height: 150, alignment: .top)
                
                Text(moves.first!)
                    .font(.custom("", size: 150))
                    .frame(height: 150, alignment: .center)
                
                Text("What do you need to choose for win?")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .frame(height: 100, alignment: .bottom)
                
                HStack {
                    Button("🪨        ", action: rockTapped)
                        .tint(.black)
                        .font(.title)
                        .frame(width: 100, alignment: . center)
                        .buttonStyle(.bordered)
                    Button("📄        ", action: paperTapped)
                        .tint(.black)
                        .font(.title)
                        .frame(width: 100, alignment: .center)
                        .buttonStyle(.bordered)
                    Button("✂️        ", action: scissorsTapped)
                        .tint(.black)
                        .font(.title)
                        .frame(width: 100, alignment: .center)
                        .buttonStyle(.bordered)
                        
                }
                .frame(height: 100, alignment: .center)
                
                HStack {
                    Text("Score: \(score)")
                        .frame(width: 150,height: 100, alignment: .center)
                        .font(.title2)

                    Button("Repeat", systemImage: "arrow.clockwise",action: resett)
                        .tint(.black)
                        .font(.title3)
                        .frame(width: 150, alignment: . center)
                        .buttonStyle(.bordered)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func rockTapped() {
        moves.first! == "✂️" ? (score += 1) : moves.first! == "📄" ?  (score -= 1) : (score += 0)
        if score < 1 {
            score = 0
        }
        moves.shuffle()
    }
    
    func paperTapped() {
        moves.first! == "🪨" ? (score += 1) : moves.first! == "✂️" ?  (score -= 1) : (score += 0)
        if score < 1 {
            score = 0
        }
        moves.shuffle()
        
    }
    
    func scissorsTapped() {
        moves.first! == "📄" ? (score += 1) : moves.first! == "🪨" ?  (score -= 1) : (score += 0)
        if score < 1 {
            score = 0
        }
        moves.shuffle()
        
    }
    
    func resett() {
        score = 0
        moves.shuffle()
    }
}

extension Color {
    static let lime = Color(red: 198/255, green: 223/255, blue: 32/255)
    static let darkGreen = Color(red: 25/255, green: 118/255, blue: 54/255)
}

#Preview {
    ContentView()
}
