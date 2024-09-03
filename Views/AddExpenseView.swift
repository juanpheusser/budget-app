import SwiftUI

struct AddExpenseView: View {
    @ObservedObject var budget: Budget
    @State private var amount = ""
    @State private var description = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
                TextField("Description", text: $description)
                
                Button("Add Expense") {
                    if let amount = Double(amount) {
                        budget.addExpense(amount: amount, description: description)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationTitle("Add Expense")
        }
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(budget: Budget())
    }
}