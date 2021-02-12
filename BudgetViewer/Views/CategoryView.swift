//
//  CategoryView.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2020-07-25.
//  Copyright © 2020 Oscar Echeverri. All rights reserved.
//

import SwiftUI

struct CategoryHeader: View {
    
    var name: String
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.flexible(minimum: 50, maximum: 150)), GridItem(.fixed(100)), GridItem(.fixed(100))],
            content: {
                Text(LocalizedStringKey(name))
                    .font(.headline)
                    .lineLimit(2)
                Text(LocalizedStringKey("Activity"))
                    .font(.headline)
                Text(LocalizedStringKey("Balance"))
                    .font(.headline)
        })
    }
}
struct CategoryView: View {
    
    @Binding var category: Category
    @Binding var currency: Currency
    
    var body: some View {
        LazyVGrid(
            columns: [GridItem(.flexible(minimum: 50, maximum: 150)), GridItem(.fixed(100)), GridItem(.fixed(100))],
            content: {
                Text(self.category.name)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(currency.stringValue(of: category.activity))
                    .foregroundColor(self.category.activity >= 0 ? .green : .red)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                 Text(currency.stringValue(of: category.balance))
                    .foregroundColor(self.category.balance > 0 ? .green : .red)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .trailing)
        })
    }
}

struct CategoryPreviewView: View {
    @State var categoryGroup: CategoryGroup
    @State var currency: Currency
    
    var body: some View {
            List {
                CategoryHeader(name: categoryGroup.name)
                ForEach(categoryGroup.categories.indexed(), id: \.1.id) { index, category in
                    CategoryView(category: self.$categoryGroup.categories[index], currency: $currency)
                }
            }
    }
}

struct CategoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        let locale = Locale.autoupdatingCurrent
        let currency = Currency(iso_code: locale.currencySymbol ?? "USD")
     
        let categoryGroup = CategoryGroup(id: UUID().uuidString, name: "Test Group", hidden: false, deleted: false, categories: nil)
        
        let _ = categoryGroup.add(category: .init(id: UUID().uuidString, category_group_id: "", name: "Test Category 1", hidden: false, deleted: false, note: "", budgeted: 11000, activity: -1234, balance: 11000-1234))
        let _ = categoryGroup.add(category: .init(id: UUID().uuidString, category_group_id: "", name: "Test Category 2", hidden: false, deleted: false, note: "", budgeted: 110000, activity: -12340, balance: 110000-12340))
        let _ = categoryGroup.add(category: .init(id: UUID().uuidString, category_group_id: "", name: "Test Category 3", hidden: false, deleted: false, note: "", budgeted: 1100000, activity: -123400, balance: 1100000-123400))
        let _ = categoryGroup.add(category: .init(id: UUID().uuidString, category_group_id: "", name: "Test Category 4", hidden: false, deleted: false, note: "", budgeted: 11000000, activity: -12340000, balance: 11000000-1234000))
        
        return CategoryPreviewView(categoryGroup: categoryGroup, currency: currency)
    }
}
