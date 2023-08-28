//
//  MealWindowView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/6/23.
//

import Foundation
import SwiftUI

struct MealWindowView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @Binding var seeMeal : Bool
    @Binding var mealToBeShown : String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 375, height: 300).shadow(color: Color.gray, radius: 10, x: 0, y: 5)
            VStack{
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
                
                Button(action: {seeMeal = false} ) {
                    Text("Done")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }
            }
        }
    }
}
