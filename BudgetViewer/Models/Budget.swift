//
//  Budget.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

class Budget: Identifiable, Decodable {
    
    let id: String
    var name: String
    let first_month: String
    let last_month: String
    let date_format: DateFormat
    var currency_format: Currency
    
    @DecodableDefault.EmptyList var accounts: [Account]
    @DecodableDefault.EmptyList var months: [BudgetMonth]
    @DecodableDefault.EmptyList var payees: [Payee]
    @DecodableDefault.EmptyList var category_groups: [CategoryGroup]
    @DecodableDefault.EmptyList var categories: [Category]
    @DecodableDefault.EmptyList var transactions: [Transaction]
    @DecodableDefault.EmptyList var subtransactions: [SubTransaction]
    @DecodableDefault.EmptyList var scheduled_transactions: [ScheduledTransaction]
    @DecodableDefault.EmptyList var scheduled_subtransactions: [ScheduledSubTransaction]
    
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
            let nextIndex = months.index(after: monthIndex)
            
            if nextIndex < months.endIndex {
                return months[nextIndex]
            }
        }
        return nil

    }
    
    func getMonth(after month: BudgetMonth) -> BudgetMonth? {
        let monthIndex = months.firstIndex{ $0.id == month.id }
        if let monthIndex = monthIndex {
            let previousIndex = months.index(before: monthIndex)
            
            if previousIndex >= months.startIndex {
                return months[previousIndex]
            }
        }
        return nil
    }
    
    func configureFor(month: BudgetMonth) {
        _ = self.category_groups.map {
            $0.categories.removeAll()
        }
        _ = month.categories.map { category in
            self.category_groups.first {
                $0.id == category.category_group_id
            }?.add(category: category)
        }
        
        _ = self.category_groups.map {
            $0.categories.sort { left, right in
                return left.id > right.id
            }
        }
    }
}

struct BudgetMonth: Identifiable, Decodable {
    var id: String {
        return month
    }
    let month: String
    let income: Int
    let budgeted: Int
    let activity: Int
    let to_be_budgeted: Int
    let deleted: Bool
    let categories: [Category]
    
    @DecodableDefault.EmptyString var note: String
    @DecodableDefault.Zero var age_of_money: Int

}
