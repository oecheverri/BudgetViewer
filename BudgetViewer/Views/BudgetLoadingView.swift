//
//  BudgetLoader.swift
//  BudgetViewer
//
//  Created by Oscar Echeverri on 2021-02-07.
//  Copyright © 2021 Oscar Echeverri. All rights reserved.
//

import SwiftUI

struct BudgetLoadingView: View {
    @EnvironmentObject private var budgetViewer: BudgetViewer
    @State private var angle: Double = 0.0
    @State private var scale: CGFloat = 1.0

    private var animation: Animation {
        Animation.linear(duration: 1.5)
        .repeatForever(autoreverses: false)
    }
    
    var body: some View {
        ZStack {
            Text("$")
                .font(.system(size: 150))
                .scaleEffect(x: 1.05, y: 1.05, anchor: .center)
            Text("$")
                .font(.system(size: 150))
                .foregroundColor(.green)
        }
        .rotationEffect(.degrees(self.angle))
        .scaleEffect(self.scale)
        .onAppear {
            withAnimation(animation) {
                self.angle = 360
                
            }
            withAnimation(Animation.linear(duration: 1.5).repeatForever(autoreverses: true)) {
                self.scale = 2.5
            }
        }
    }
}

struct BudgetLoader_Previews: PreviewProvider {
    static var previews: some View {
        BudgetLoadingView()
    }
}
