//
//  Account.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-07.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct Account: Identifiable, Decodable {
    enum AccountType: String, Decodable {
        case Chequing = "checking"
        case Savings = "savings"
        case Cash = "cash"
        case CreditCard = "creditCard"
        case LineOfCredit = "lineOfCredit"
        case OtherAsset = "otherAsset"
        case OtherLiability = "otherLiability"
        case PayPal = "payPal"
        case MerchantAccount = "merchantAccount"
        case Investment = "investmentAccount"
        case Mortgage = "mortgage"
        
    }
    
    let id: String
    let name: String
    let type: AccountType
    let on_budget: Bool
    let closed: Bool
    let balance: Int
    let cleared_balance: Int
    let uncleared_balance: Int
    let transfer_payee_id: String
    let deleted: Bool
    
    @DecodableDefault.EmptyString var note: String
}
