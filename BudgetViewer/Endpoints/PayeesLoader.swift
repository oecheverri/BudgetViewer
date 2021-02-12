//
//  PayeesLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-27.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct PayeesResponse: Decodable {
    let payees: [Payee]
}

struct PayeeResponse: Decodable {
    let payee: Payee
}

struct PayeesLoader {
    func loadPayees(for budget: Budget, then callback: @escaping ([Payee]?, Error?) -> Void) {
        let loader = EndpointLoader<PayeesResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/payees") { result in
            switch result {
                case .Success(let payeesResponse):
                    callback(payeesResponse.payees, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadPayee(id: String, for budget: Budget, then callback: @escaping (Payee?, Error?) -> Void) {
        let loader = EndpointLoader<PayeeResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/payees/\(id)") { result in
            switch result {
                case .Success(let payeeResponse):
                    callback(payeeResponse.payee, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
}
