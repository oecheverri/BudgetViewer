//
//  Currency.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-01-08.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import Foundation

struct Currency: Decodable {
    let iso_code: String
}

extension Currency {
    func stringValue(of milliunits: Int) -> String {
        let floatVal = Float(milliunits) / 1000.00
        
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .currency
        formatter.currencyCode = iso_code
        
        return formatter.string(from: floatVal as NSNumber) ?? "NaN"
        
    }
}
