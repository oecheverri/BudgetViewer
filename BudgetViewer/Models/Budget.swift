//
//  Budget.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

class Budget: Identifiable, Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case first_month = "first_month"
        case last_month = "last_month"
        case date_format = "date_format"
        case currency_format = "currency_format"
        
        case accounts = "accounts"
        case months = "months"
        case payees = "payees"
        case category_groups = "category_groups"
        case categories = "categories"
        case transactions = "transactions"
        case subtransactions = "subtransactions"
        case scheduled_transactions = "scheduled_transactions"
        case scheduled_subtransactions = "scheduled_subtransactions"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.first_month = try values.decode(String.self, forKey: .first_month)
        self.last_month = try values.decode(String.self, forKey: .last_month)
        self.date_format = try values.decode(DateFormat.self, forKey: .date_format)
        self.currency_format = try values.decode(Currency.self, forKey: .currency_format)
        
        self.accounts = try values.decodeOptional(type: [Account].self, forKey: .accounts, defaultingTo: [Account]())
        self.months = try values.decodeOptional(type: [BudgetMonth].self, forKey: .months, defaultingTo: [BudgetMonth]())
        self.payees = try values.decodeOptional(type: [Payee].self, forKey: .payees, defaultingTo: [Payee]())
        self.category_groups = try values.decodeOptional(type: [CategoryGroup].self, forKey: .category_groups, defaultingTo: [CategoryGroup]())
        self.categories = try values.decodeOptional(type: [Category].self, forKey: .categories, defaultingTo: [Category]())
        self.transactions = try values.decodeOptional(type: [Transaction].self, forKey: .transactions, defaultingTo: [Transaction]())
        self.subtransactions = try values.decodeOptional(type: [SubTransaction].self, forKey: .subtransactions, defaultingTo: [SubTransaction]())
        self.scheduled_transactions = try values.decodeOptional(type: [ScheduledTransaction].self, forKey: .scheduled_transactions, defaultingTo: [ScheduledTransaction]())
        self.scheduled_subtransactions = try values.decodeOptional(type: [ScheduledSubTransaction].self, forKey: .scheduled_subtransactions, defaultingTo: [ScheduledSubTransaction]())
        
    }
    
    let id: String
    var name: String
    let first_month: String
    let last_month: String
    let date_format: DateFormat
    var currency_format: Currency
    
    var accounts: [Account]
    var months: [BudgetMonth]
    var payees: [Payee]
    var category_groups: [CategoryGroup]
    var categories: [Category]
    var transactions: [Transaction]
    var subtransactions: [SubTransaction]
    var scheduled_transactions: [ScheduledTransaction]
    var scheduled_subtransactions: [ScheduledSubTransaction]
    
    func getCurrentMonth() -> BudgetMonth? {
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: Date())
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        for month in months {
            if let monthDate = formatter.date(from: month.month) {
                if calendar.component(.month, from: monthDate) == currentMonth {
                    return month
                }
            }
        }
        return nil
    }
    
    func getMonth(before month: BudgetMonth) -> BudgetMonth? {
        let monthIndex = months.firstIndex{ $0.id == month.id }
        
        if let monthIndex = monthIndex {
            let previousIndex = months.index(before: monthIndex)
            
            if previousIndex >= months.startIndex {
                return months[previousIndex]
            }
        }
        return nil
    }
    
    func getMonth(after month: BudgetMonth) -> BudgetMonth? {
        let monthIndex = months.firstIndex{ $0.id == month.id }
        
        if let monthIndex = monthIndex {
            let nextIndex = months.index(after: monthIndex)
            
            if nextIndex <= months.endIndex {
                return months[nextIndex]
            }
        }
        return nil
    }
    
    func configureFor(month: BudgetMonth) {
        categories.removeAll(keepingCapacity: true)
        _ = month.categories.map { category in
            self.category_groups.first {
                $0.id == category.category_group_id
            }?.add(category: category)
        }
    }
}

struct BudgetMonth: Identifiable, Decodable {
    var id: String {
        return month
    }
    let month: String
    let note: String?
    let income: Int
    let budgeted: Int
    let activity: Int
    let to_be_budgeted: Int
    let age_of_money: Int?
    let deleted: Bool
    let categories: [Category]

}
