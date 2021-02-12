//
//  CategoryLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-26.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct CategoryListResponse: Decodable {
    let category_groups: [CategoryGroup]
}

struct CategoryResponse: Decodable {
    let category: Category
}

struct CategoryLoader {
    
    func loadCategories(for budget: Budget, then callback: @escaping ([CategoryGroup]?, Error?) -> Void) {
        let loader = EndpointLoader<CategoryListResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/categories") { result in
            switch result {
                case .Success(let categoriesResponse):
                    callback(categoriesResponse.category_groups, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadCategory(id: String, in budget: Budget, then callback: @escaping (Category?, Error?) -> Void) {
        let loader = EndpointLoader<CategoryResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/categories/id"){ result in
            switch result {
                case .Success(let categoryResponse):
                    callback(categoryResponse.category, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
    
    func loadCategory(id: String, in budget: Budget, during month: BudgetMonth, then callback: @escaping (Category?, Error?) -> Void) {
        let loader = EndpointLoader<CategoryResponse>()
        loader.loadDataFrom(endpoint: "/budgets/\(budget.id)/month/\(month.month)/categories/id"){ result in
            switch result {
                case .Success(let categoryResponse):
                    callback(categoryResponse.category, nil)
                case .Failed(let error):
                    callback(nil, error)
            }
        }
    }
}
