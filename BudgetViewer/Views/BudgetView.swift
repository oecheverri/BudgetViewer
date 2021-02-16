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
            HStack {
                
                Button(action: {
                    budgetViewer.goToPreviousMonth()
                }) {
                    Image(systemName: "chevron.left.circle.fill")
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                }
                .padding(.leading, 20)
                .disabled(budget.getMonth(before: budgetViewer.configuredMonth!) == nil)
                .accentColor(.green)
                Spacer()
                
                Text(budgetViewer.getDisplayString(for: budgetViewer.configuredMonth!))
                    .font(.title2)
                
                Spacer()
                
                Button(action: {
                    budgetViewer.goToNextMonth()
                }) {
                    Image(systemName: "chevron.right.circle.fill")
                        .scaleEffect(CGSize(width: 1.5, height: 1.5))
                }
                .padding(.trailing, 20)
                .disabled(budget.getMonth(after: budgetViewer.configuredMonth!) == nil)
                .accentColor(.green)
                
            }
            
            HStack {
                Text(LocalizedStringKey("To be budgeted: "))
                    .font(.headline)
                Spacer()
                Text(budget.currency_format.stringValue(of: budgetViewer.configuredMonth!.to_be_budgeted))
                    .foregroundColor(budgetViewer.configuredMonth!.to_be_budgeted >= 0 ? .green : .red)
                    .font(.headline)
            }
            .padding()
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
        budgetViewer.configuredMonth = budgetViewer.budget!.getCurrentMonth()
        budgetViewer.budget?.configureFor(month: budgetViewer.configuredMonth!)
        
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
