//
//  BudgetViewerApp.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-02-12.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import SwiftUI

@main
struct BudgetViewerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(BudgetViewer())
        }
    }
}
