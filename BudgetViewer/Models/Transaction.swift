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
    let amount: Int
    let memo: String?
    let payee_id: String?
    let payee_name: String?
    let category_id: String?
    let category_name: String?
    let transfer_account_id: String?
    let deleted: Bool
}

struct ScheduledTransaction: Identifiable, Decodable {
    let id: String
    let date_first: String
    let date_next: String
    
    let frequency: Frequency
    let amount: Int
    let memo: String?
    
    let account_id: String
    let payee_id: String?
    let category_id: String?
    let transfer_account_id: String?
    
    let deleted: Bool
}


struct ScheduledSubTransaction: Identifiable, Decodable {
    let id: String
    let scheduled_transaction_id: String
    let amount: Int
    let memo: String?
    let payee_id: String?
    let category_id: String?
    let transfer_account_id: String?
    let deleted: Bool
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
    
    let memo: String?
    let cleared: Status
    
    let approved: Bool
    
    let account_id: String
    let payee_id: String?
    let category_id: String?
    let transfer_account_id: String?
    let transfer_transaction_id: String?
    let matched_transaction_id: String?
    let import_id: String?
    let deleted: Bool
    
}
