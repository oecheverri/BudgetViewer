//
//  AccountsLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-25.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct AccountsListResponse: Decodable {
    let accounts: [Account]
}

struct AccountResponse: Decodable {
    let account: Account
}
struct AccountsLoader {
    func loadAccounts(for budget: Budget, then callback: @escaping ([Account]?, Error?) -> Void) {
        let loader = EndpointLoader<AccountsListResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/accounts") { result in
            switch result {
                case .Success(let accountsResponse):
                    callback(accountsResponse.accounts, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
            
        }
    }
    
    func loadAccount(id accountId: String, from budget: Budget, then callback: @escaping (Account?, Error?) -> Void) {
        let loader = EndpointLoader<AccountResponse>()
        loader.loadDataFrom(endpoint: "budgets/\(budget.id)/accounts/\(accountId)"){ result in
            switch result {
                case .Success(let accountResponse):
                    callback(accountResponse.account, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
}
