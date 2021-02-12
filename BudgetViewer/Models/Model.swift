//
//  Model.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-02-07.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Combine

class Model: ObservableObject {
    var isReady = false
    
    private var budget: Budget?
    
    func GetReady() {
        let budgetLoader = BudgetsLoader()
        budgetLoader.loadBudgets(includeAccounts: false) { budgets, defaultBudget, _ in
            if var budget = defaultBudget {
                budgetLoader.loadMonth(for: budget) { currentMonth, _ in
                
                    
                }
            }
        }
        
    }
    
    func GetBudget() -> Budget {
        return budget!
    }
}
