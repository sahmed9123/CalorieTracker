//
//  LogView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct LogView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @State var logMustBeAdded = false
    @State var pickDateToView = false
    @State var seeMeal = false
    @State var mealToBeShown = "Pasta"
    @State var datePicked = Date()
    
    func setColor() -> Color {
        if tracker.getGoalCalories() <= tracker.getDateCals(datePicked) {
            return Color.green
        } else {
            return Color.red
        }
        
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Log")
                        .font(.largeTitle)
                    Image(systemName: "note.text")
                        .resizable()
                        .frame(width: 30, height: 30)
                }.padding()
                
                HStack {
                    Button(action: {logMustBeAdded = true} ) {
                        Text("Log A Meal")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(25.0)
                    }.padding()
                    
                    Button(action: {pickDateToView = true} ) {
                        Text("Pick New Date to View")
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(25.0)
                    }.padding()
                }
                
                HStack {
                    Text("Now Viewing:")
                        .font(.headline)
                    Text("\(tracker.getDateString(datePicked))")
                }
                
                HStack {
                    Text("You had")
                    Text("\(tracker.getDateCals(datePicked))")
                        .font(.headline)
                    Text("calories today!")
                }
                
                VStack {
                    if tracker.getGoalCalories() <= tracker.getDateCals(datePicked) {
                        Text("Calorie Goal Has Been Met!")
                            .font(.headline)
                            .foregroundColor(Color.green)
                        if tracker.getDateCals(datePicked) - tracker.getGoalCalories() > 250 {
                            Text("🚨Warning!🚨")
                                .foregroundColor(Color.red)
                            Text("You are more than 250 calories over your goal")
                                .foregroundColor(Color.red)
                        }
                    } else {
                        Text("Still need to eat \(tracker.getGoalCalories() - tracker.getDateCals(datePicked)) calories")
                            .font(.headline)
                            .foregroundColor(Color.red)
                    }
                }
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                            .opacity(0.2)
                            .foregroundColor(.gray)
                        
                        Rectangle().frame(width: min((CGFloat(tracker.getDateCals(datePicked))/CGFloat(tracker.getGoalCalories()))*geometry.size.width, geometry.size.width), height: geometry.size.height)
                            .foregroundColor(setColor())
                            .animation(.linear)
                    }.cornerRadius(35.0)
                }.frame(height: 20)
                    .padding([.top],-4).padding([.leading,.trailing],10)
                
                TodaysMealsView(datePicked: $datePicked, mealToBeShown: $mealToBeShown, seeMeal: $seeMeal).environmentObject(tracker)
                
            }
            
            
            if seeMeal {
                MealWindowView(seeMeal: $seeMeal, mealToBeShown: $mealToBeShown).environmentObject(tracker)
            }
            if pickDateToView {
                DateToView(pickDateToView: $pickDateToView, datePicked: $datePicked).environmentObject(tracker)
            }
        
            if logMustBeAdded {
                LogMealView(logMustBeAdded: $logMustBeAdded, datePicked: $datePicked).environmentObject(tracker)
            }
        }
    }
}
