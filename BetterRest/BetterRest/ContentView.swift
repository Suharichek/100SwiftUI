//
//  ContentView.swift
//  BetterRest
//
//  Created by Сухарик on 19.07.2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var bedtimeText = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack {
                        Image(systemName: "bed.double.fill")
                        DatePicker("Enter time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                    }
                } header: {
                    Text("When do you want to wake up?")
                        .foregroundStyle(Color.lightPuprle)
                }
                
                Section {
                    HStack {
                        Image(systemName: "clock")
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }header: {
                    Text("Desired amount of sleep")
                        .foregroundStyle(Color.lightPuprle)
                }
                
                Section {
                    HStack {
                        Image(systemName: "cup.and.saucer")
                        Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount) {
                            ForEach(1...10, id: \.self) {
                                Text("^[\($0) cup](inflect: true)")
                            }
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                        .foregroundStyle(Color.lightPuprle)
                }
                
                Section {
                    Text(calculateBedtime())
                        .frame(width: 400,height: 50, alignment: .center)
                        .font(.largeTitle)
                } header: {
                    Text("Your ideal betime")
                        .foregroundStyle(Color.lightPuprle)
                }

            }
            .navigationTitle("BetterRest 🛌")
            .scrollContentBackground(.hidden)
            .background(Color.darkPuprle)
        }
    }
    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error"
        }
    }
}

extension Color {
    static let darkPuprle = Color(red: 53/255, green: 51/255, blue: 88/255)
    static let lightPuprle = Color(red: 166/255, green: 178/255, blue: 236/255)
}

#Preview {
    ContentView()
}
