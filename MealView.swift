//
//  MealView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct MealView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @State var mealMustBeAdded: Bool = false
    @State var mealToBeShown: String = "Pasta"
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Meals")
                        .font(.largeTitle)
                    Image(systemName: "frying.pan.fill")
                        .resizable()
                        .frame(width: 45, height: 30)
                }.padding()
                Spacer()
                
                Button(action: {mealMustBeAdded = true} ) {
                    Text("Add New Meal")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(25.0)
                }.padding()
                
                Text("Now Showing: \(mealToBeShown)!")
                    .font(.headline)
                    .padding()
                
                let shownMeal = tracker.getMeal(mealToBeShown)
                
                HStack {
                    Text("   Calories:")
                        .font(.headline)
                    Text("\(shownMeal.calories)")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                HStack {
                    Text("   Description:")
                        .font(.headline)
                    Text("\(shownMeal.description)")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                HStack {
                    Text("   Carbs:")
                        .font(.headline)
                    Text("\(shownMeal.carbs) grams")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    Text("   Protein:")
                        .font(.headline)
                    Text("\(shownMeal.protein) grams")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                HStack {
                    Text("   Fats:")
                        .font(.headline)
                    Text("\(shownMeal.fats) grams")
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                
                MealBookView(mealToBeShown: $mealToBeShown).environmentObject(tracker)
            }
            
            if mealMustBeAdded{
                AddMealView(mealMustBeAdded: $mealMustBeAdded).environmentObject(tracker)
            }
        }
    }
}
