//
//  TodaysMealsView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/4/23.
//

import Foundation
import SwiftUI

struct TodaysMealsView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @Binding var datePicked: Date
    @Binding var mealToBeShown: String
    @Binding var seeMeal: Bool
    
    var todaysMeals: [String] {
        tracker.getDateMeals(datePicked)
    }
    
    func deleteMeal(_ mealName: String, _ date: Date) {
        tracker.deleteMeal(mealName, date)
    }
    var body: some View {
        
        List {
            if !(todaysMeals.count == 1 && todaysMeals[0] == "No Meals") {
                ForEach(todaysMeals, id: \.self) { mealName in
                    HStack{
                        if mealName == "No Meals" {
                            // do nothing
                        } else {
                            Button(action: {mealToBeShown = mealName
                                seeMeal = true} ) {
                                Text(mealName)
                            }
                            let cals = tracker.getMealCalories(mealName)
                            Spacer()
                            Text("\(cals) calories")
                        }
                    }
                }.onDelete(perform: deleteMeal)
            }
        }
    }
    
    func deleteMeal(at offsets: IndexSet) {
        for index in offsets {
            let mealName = todaysMeals[index]
            tracker.deleteMeal(mealName, datePicked)
        }
    }
}
