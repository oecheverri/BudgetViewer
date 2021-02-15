//
//  BudgetsLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-24.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct BudgetsResponse: Decodable {
    let budgets: [Budget]
    let default_budget: Budget?
}
struct BudgetResponse: Decodable {
    let budget: Budget
}

struct BudgetMonthResponse: Decodable {
    let month: BudgetMonth
}

struct BudgetMonthsResponse: Decodable {
    let months: [BudgetMonth]
}
struct BudgetsLoader {
    func loadBudgets(includeAccounts: Bool, callback: @escaping ([Budget]?, Budget?, Error?) -> Void) {
        let loader = EndpointLoader<BudgetsResponse>()
        loader.loadDataFrom(endpoint: "/budgets", with: [URLQueryItem(name: "include_accounts", value: String(includeAccounts))]) { result in
            switch result {
                case .Success(let response):
                    callback(response.budgets, response.default_budget, nil)
                case .Failed(let error):
                    callback(nil, nil, error)
            }
        }
    }
    
    func loadBudget(id: String, callback: @escaping (Budget?, Error?) -> Void) {
        let loader = EndpointLoader<BudgetResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(id)") { result in
            switch result {
                case .Success(let response):
                    callback(response.budget, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadMonth(month: String = "current", for budget: Budget, then callback: @escaping(BudgetMonth?, Error?) -> Void) {
        let loader = EndpointLoader<BudgetMonthResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/months/\(month)") { result in
            switch result {
            case .Success(let response):
                callback(response.month, nil)
            case .Failed(let error):
                callback(nil, error)
            }
        }
    }
    
    func loadMonths(for budget: Budget, then callback: @escaping([BudgetMonth]?, Error?) -> Void) {
        let loader = EndpointLoader<BudgetMonthsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/months") { result in
            switch result {
            case .Success(let response):
                callback(response.months, nil)
            case .Failed(let error):
                callback(nil, error)
            }
        }
    }
}
