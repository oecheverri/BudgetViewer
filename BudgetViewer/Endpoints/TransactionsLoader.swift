//
//  TransactionsLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-27.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct TransactionsResponse: Decodable {
    let transactions: [Transaction]
}

struct TransactionResponse: Decodable {
    let transaction: Transaction
}

struct ScheduledTransactionsResponse: Decodable {
    let scheduled_transactions: [ScheduledTransaction]
}

struct ScheduledTransactionResponse: Decodable {
    let scheduled_transaction: ScheduledTransaction
}

struct TransactionsLoader {
    func loadTransactions(for budget: Budget, then callback: @escaping ([Transaction]?, Error?) -> Void) {
        let loader = EndpointLoader<TransactionsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/transactions") { result in
            switch result {
                case .Success(let transactionsResponse):
                    callback(transactionsResponse.transactions, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadTransaction(id: String, for budget: Budget, then callback: @escaping (Transaction?, Error?) -> Void) {
        let loader = EndpointLoader<TransactionResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/transactions/\(id)") { result in
            switch result {
                case .Success(let transactionResponse):
                    callback(transactionResponse.transaction, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadTransactions(for budget: Budget, in account: Account, then callback: @escaping ([Transaction]?, Error?) -> Void) {
        let loader = EndpointLoader<TransactionsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/accounts/\(account.id)/transactions") { result in
            switch result {
                case .Success(let transactionsResponse):
                    callback(transactionsResponse.transactions, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadTransaction(id: String, for budget: Budget, in account: Account, then callback: @escaping (Transaction?, Error?)->Void) {
        let loader = EndpointLoader<TransactionResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/accounts/\(account.id)/transactions/\(id)") { result in
            switch result {
                case .Success(let transactionResponse):
                    callback(transactionResponse.transaction, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadTransactions(for budget: Budget, in category: Category, then callback: @escaping ([Transaction]?, Error?) -> Void) {
        let loader = EndpointLoader<TransactionsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/categories/\(category.id)/transactions") { result in
            switch result {
                case .Success(let transactionsResponse):
                    callback(transactionsResponse.transactions, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadTransactions(for budget: Budget, to payee: Payee, then callback: @escaping ([Transaction]?, Error?) -> Void) {
        let loader = EndpointLoader<TransactionsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/payees/\(payee.id)/transactions") { result in
            switch result {
                case .Success(let transactionsResponse):
                    callback(transactionsResponse.transactions, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadScheduledTransactions(for budget: Budget, then callback: @escaping ([ScheduledTransaction]?, Error?) -> Void) {
        let loader = EndpointLoader<ScheduledTransactionsResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/scheduled_transactions") { result in
            switch result {
                case .Success(let scheduledTransactions):
                    callback(scheduledTransactions.scheduled_transactions, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadScheduledTransaction(id: String, for budget: Budget, then callback: @escaping (ScheduledTransaction?, Error?) -> Void) {
        let loader = EndpointLoader<ScheduledTransactionResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/scheduled_transactions/\(id)") { result in
            switch result {
                case .Success(let scheduledTransactionResponse):
                    callback(scheduledTransactionResponse.scheduled_transaction, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
}
