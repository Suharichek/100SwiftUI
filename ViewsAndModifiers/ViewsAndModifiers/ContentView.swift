//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Сухарик on 19.07.2024.
//

import SwiftUI

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
            content
                .font(.largeTitle.bold())
                .foregroundStyle(.blue)
                .padding()
    }
}

extension View {
    func titleStyle () -> some View {
        modifier(TitleStyle())
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            RadialGradient(
                colors: [.orange, .mint],
                center: .center,
                startRadius: 40,
                endRadius: 300
            )
            Text("Suharichek")
                .titleStyle()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
