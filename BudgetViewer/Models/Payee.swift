//
//  Vendor.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct Payee: Identifiable, Decodable {
    let id: String
    let name: String
    let transfer_account_id: String?
    let deleted: Bool
}
