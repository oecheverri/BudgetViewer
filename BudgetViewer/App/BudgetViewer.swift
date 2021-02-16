//
//  BudgetViewer.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-02-12.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

class BudgetViewer: ObservableObject {
    
    @Published var ready = false
    @Published var error = false
    @Published var configuredMonth: BudgetMonth?
    
    var budget: Budget?
    
    func getBudget() -> Budget {
        return budget!
    }
    
    func prepare() {
        let budgetLoader = BudgetsLoader()
        budgetLoader.loadBudgets(includeAccounts: true) { budgets, defaultBudget, error in
            if let budgets = budgets {
                if budgets.count == 0 {
                    self.updateState(ready: false, error: true)
                }
                else if budgets.count == 1{
                    self.loadBudget(id: budgets.first!.id)
                }
                else if let defaultBudget = defaultBudget {
                    self.loadBudget(id: defaultBudget.id)
                } else {
                    self.updateState(ready: false, error: true)
                }
            } else {
                self.updateState(ready: false, error: true)
            }
        }
    }
    
    func updateState(ready: Bool, error: Bool) {
        DispatchQueue.main.async {
            self.ready = ready
            self.error = error
        }
    }

    func loadBudget(id: String) {
        let budgetsLoader = BudgetsLoader()
        budgetsLoader.loadBudget(id: id) { budget, error in
            if let budget = budget {
                self.budget = budget
                if let currentMonth = self.budget!.getCurrentMonth() {
                    DispatchQueue.main.async {
                        self.configuredMonth = currentMonth
                        self.budget!.configureFor(month: currentMonth)
                        self.updateState(ready: true, error: false)
                    }
                } else {
                    self.updateState(ready: false, error: true)
                }
            } else {
                self.updateState(ready: false, error: true)
            }
        }
    }
    
    func getDisplayString(for month: BudgetMonth) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: month.month) {
            formatter.dateFormat = "MMMM yyyy"
            return formatter.string(from: date)
        }
        return NSLocalizedString("Unknown Month", comment: "String for indicating that the budget month is unknown")
    }
    
    func goToPreviousMonth() {
        if let month = budget!.getMonth(before: configuredMonth!) {
            budget?.configureFor(month: month)
            self.configuredMonth = month
        }
    }
    
    func goToNextMonth() {
        if let month = budget?.getMonth(after: configuredMonth!) {
            budget?.configureFor(month: month)
            self.configuredMonth = month
        }
    }
}
