//
//  BudgetView.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-28.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import SwiftUI

struct BudgetView: View {
    @State var budget: Budget
    var body: some View {
        List {
            ForEach(budget.category_groups.indexed(), id: \.1.id) { groupIndex, categoryGroup in
                CategoryHeader(name: categoryGroup.name)
                ForEach(categoryGroup.categories.indexed(), id: \.1.id) { categoryIndex, category in
                    CategoryView(category: $budget.category_groups[groupIndex].categories[categoryIndex], currency:  $budget.currency_format)
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetView(budget: loadSampleBudget()!)
    }
    
    static func loadSampleBudget() -> Budget? {
        if let path = Bundle.main.path(forResource: "SampleBudget", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let budget = try decoder.decode(Budget.self, from: data)
                budget.categories.forEach { category in
                    budget.category_groups.forEach { categoryGroup in
                        if categoryGroup.id == category.category_group_id {
                            let _ = categoryGroup.add(category: category)
                        }
                    }
                }
                return budget
            } catch {
                print(error)
                return nil
            }
        }
        return nil
    }
}
