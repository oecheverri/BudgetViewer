//
//  Category.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

class CategoryGroup: Identifiable, ObservableObject, Decodable {
    
    let id: String
    var name: String
    let hidden: Bool
    let deleted: Bool
    
    var categories: [Category]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case hidden = "hidden"
        case deleted = "deleted"
        case categories = "categories"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(String.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
        self.hidden = try values.decode(Bool.self, forKey: .hidden)
        self.deleted = try values.decode(Bool.self, forKey: .deleted)
        
        self.categories = try values.decodeOptional(type: [Category].self, forKey: .categories, defaultingTo: [Category]())
    }
    
    init(id: String, name: String, hidden: Bool, deleted: Bool, categories: [Category]?) {
        self.id = id
        self.name = name
        self.hidden = hidden
        self.deleted = deleted
        self.categories = categories ?? [Category]()
    }
    
    func add(categories: [Category]) -> [Category] {
        self.categories.append(contentsOf: categories)
        return self.categories
    }
    
    func add(category: Category) -> [Category] {
        self.categories.append(category)
        return categories
    }
    
    func replaceAllCategories(with categories: [Category]) {
        self.categories = categories
    }

}

struct Category: Identifiable, Decodable {
    let id: String
    let category_group_id: String
    let name: String
    let hidden: Bool
    let deleted: Bool
    let note: String?
    
    let budgeted: Int
    let activity: Int
    let balance: Int
    
}
