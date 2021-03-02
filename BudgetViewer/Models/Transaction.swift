//
//  Transaction.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//
import Foundation


enum Frequency: String, Decodable {
    case never = "never"
    case daily = "daily"
    case weekly = "weekly"
    case everyOtherWeek = "everyOtherWeek"
    case twiceAMonth = "twiceAMonth"
    case every4Weeks = "every4Weeks"
    case monthly = "monthly"
    case everyOtherMonth = "everyOtherMonth"
    case every3Momths = "every3Momths"
    case every4Months = "every4Months"
    case twiceAYear = "twiceAYear"
    case yearly = "yearly"
    case everyOtherYear = "everyOtherYear"
}

struct SubTransaction: Identifiable, Decodable {
    
    let id: String
    let transaction_id: String
    let deleted: Bool
    
    @DecodableDefault.Zero var amount: Int
    @DecodableDefault.EmptyString var memo: String
    @DecodableDefault.EmptyString var payee_id: String
    @DecodableDefault.EmptyString var payee_name: String
    @DecodableDefault.EmptyString var category_id: String
    @DecodableDefault.EmptyString var category_name: String
    @DecodableDefault.EmptyString var transfer_account_id: String
    
}

struct ScheduledTransaction: Identifiable, Decodable {
    let id: String
    let date_first: String
    let date_next: String
    let frequency: Frequency
    let amount: Int
    let account_id: String
    let deleted: Bool
    
    @DecodableDefault.EmptyString var memo: String
    @DecodableDefault.EmptyString var payee_id: String
    @DecodableDefault.EmptyString var category_id: String
    @DecodableDefault.EmptyString var transfer_account_id: String

}


struct ScheduledSubTransaction: Identifiable, Decodable {
    let id: String
    let scheduled_transaction_id: String
    let amount: Int
    let deleted: Bool
    
    @DecodableDefault.EmptyString var memo: String
    @DecodableDefault.EmptyString var payee_id: String
    @DecodableDefault.EmptyString var category_id: String
    @DecodableDefault.EmptyString var transfer_account_id: String
    
}

struct Transaction: Identifiable, Decodable {
    
    enum Status: String, Decodable {
        case cleared = "cleared"
        case uncleared = "uncleared"
        case reconciled = "reconciled"
    }
    
    let id: String
    let date: String
    let amount: Int
    let cleared: Status
    let approved: Bool
    let account_id: String
    let deleted: Bool
    
    @DecodableDefault.EmptyString var memo: String
    @DecodableDefault.EmptyString var payee_id: String
    @DecodableDefault.EmptyString var category_id: String
    @DecodableDefault.EmptyString var transfer_account_id: String
    @DecodableDefault.EmptyString var transfer_transaction_id: String
    @DecodableDefault.EmptyString var matched_transaction_id: String
    @DecodableDefault.EmptyString var import_id: String

}
