//
//  ContentView.swift
//  WordScramble
//
//  Created by Сухарик on 23.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.brown]
        }
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var score = 0
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .foregroundColor(.brown)
                }
                
                Section {
                    HStack {
                        Text("Score: \(score)")
                            .frame(width: 100, alignment: .center)
                            .font(.title3)
                            .foregroundColor(.brown)
                        
                        Button("",systemImage: "arrow.clockwise", action: startGame)
                            .frame(width: 250,alignment: .trailing)
                            .foregroundColor(.brown)
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit (addNewWord)
            .onAppear(perform: startGame)
            .scrollContentBackground(.hidden)
            .background(Color.peach)
            
            .alert(errorTitle, isPresented: $showingError) {
                
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            wordError(title: "Too short word", message: "Think better!")
            return
        }
        
        guard answer != rootWord else {
            wordError(title: "It's a root word", message: "Don't cheat!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
            score += answer.count
        }
        
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = []
                score = 0
                return
            }
        }
        
        fatalError("Couldn't load start.txt from bundle.")
    }
    
    func isOriginal(word:String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word:String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

extension Color {
    static let peach = Color(red: 250/255, green: 206/255, blue: 168/255)
}

#Preview {
    ContentView()
}
