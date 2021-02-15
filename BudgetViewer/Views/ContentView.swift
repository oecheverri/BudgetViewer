//
//  ContentView.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2020-07-25.
//  Copyright © 2020 Oscar Echeverri. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var budgetViewer: BudgetViewer
    var body: some View {
        if !self.budgetViewer.ready {
            BudgetLoadingView()
                .onAppear() {
                    budgetViewer.prepare()
                }
        } else {
            BudgetView(budget: budgetViewer.getBudget())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(BudgetViewer())
    }
}
