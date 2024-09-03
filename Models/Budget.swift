import Foundation

struct Expense: Identifiable, Codable {
    let id = UUID()
    let amount: Double
    let description: String
    let date: Date
}

class Budget: ObservableObject {
    @Published var totalBudget: Double
    @Published var expenses: [Expense]
    @Published var remainingBudget: Double
    
    init(totalBudget: Double = 0) {
        self.totalBudget = totalBudget
        self.expenses = []
        self.remainingBudget = totalBudget
        
        if let savedBudget = UserDefaults.standard.data(forKey: "budget"),
           let decodedBudget = try? JSONDecoder().decode(Budget.self, from: savedBudget) {
            self.totalBudget = decodedBudget.totalBudget
            self.expenses = decodedBudget.expenses
            self.remainingBudget = decodedBudget.remainingBudget
        }
    }
    
    func addExpense(amount: Double, description: String) {
        let expense = Expense(amount: amount, description: description, date: Date())
        expenses.append(expense)
        remainingBudget -= amount
        save()
    }
    
    func resetBudget() {
        expenses = []
        remainingBudget = totalBudget
        save()
    }
    
    private func save() {
        UserDefaults.standard.set(try? JSONEncoder().encode(self), forKey: "budget")
    }
}