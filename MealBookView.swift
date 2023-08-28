//
//  MealBookView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct MealBookView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @Binding var mealToBeShown: String
    
    
    var body: some View {
        let mealBook = tracker.mealBook
        List (Array(mealBook), id: \.0) { key, value in
            HStack {
                Button(action: {mealToBeShown = key} ) {
                    Text("\(key)")
                }.padding()
                
                Spacer()
                Text("Calories: \(value.calories)")
            }
        }
    }
}
