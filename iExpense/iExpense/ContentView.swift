//
//  ContentView.swift
//  iExpense
//
//  Created by Сухарик on 16.10.2024.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    @State private var showingAppExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            if item.amount > 10 && item.amount < 101 {
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.orange)
                            } else if item.amount < 11 {
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.green)
                            } else {
                                Text(item.name)
                                    .font(.headline)
                                    .foregroundColor(.red)
                            }
                            
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "RUB"))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAppExpense.toggle()
                }
            }
            .sheet(isPresented: $showingAppExpense) {
                AddView(expenses: expenses)
            }
        }
    }
    
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}


#Preview {
    ContentView()
}
