//
//  BudgetView.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-28.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import SwiftUI

struct BudgetView: View {
    @EnvironmentObject var budgetViewer: BudgetViewer
    @State var budget: Budget
    var body: some View {
        VStack {
            Text(budgetViewer.getBudget().name)
                .font(.title)
            Text(budgetViewer.getDisplayString(for: budgetViewer.configuredMonth!))
            List {
                ForEach(budget.category_groups.indexed(), id: \.1.id) { groupIndex, categoryGroup in
                    if categoryGroup.shouldShow {
                        CategoryHeader(name: categoryGroup.name)
                        ForEach(categoryGroup.categories.indexed(), id: \.1.id) { categoryIndex, category in
                            if !category.hidden {
                                CategoryView(category: $budget.category_groups[groupIndex].categories[categoryIndex], currency:  $budget.currency_format)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct BudgetView_Previews: PreviewProvider {
    static var budgetViewer = prepare()
    static var previews: some View {
        BudgetView(budget: budgetViewer.getBudget())
            .environmentObject(budgetViewer)
    }
    
    static func prepare() -> BudgetViewer {
        let budgetViewer = BudgetViewer()
        budgetViewer.budget = loadSampleBudget()
        budgetViewer.ready = true
        budgetViewer.error = false
        return budgetViewer
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
                            _ = categoryGroup.add(category: category)
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
