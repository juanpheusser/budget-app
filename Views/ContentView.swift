import SwiftUI

struct ContentView: View {
    @StateObject private var budget = Budget()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Remaining Budget: $\(budget.remainingBudget, specifier: "%.2f")")
                    .font(.largeTitle)
                    .padding()
                
                List {
                    ForEach(budget.expenses) { expense in
                        HStack {
                            Text(expense.description)
                            Spacer()
                            Text("$\(expense.amount, specifier: "%.2f")")
                        }
                    }
                }
                
                Button("Add Expense") {
                    showingAddExpense = true
                }
                .padding()
            }
            .navigationTitle("Budget App")
            .sheet(isPresented: $showingAddExpense) {
                AddExpenseView(budget: budget)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}