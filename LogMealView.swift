//
//  LogMealView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/4/23.
//

import Foundation
import SwiftUI

struct LogMealView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @Binding var logMustBeAdded: Bool
    @State private var selectedOption = 0
    @Binding var datePicked : Date
    @State private var selectedDate : Date
    
    init(logMustBeAdded: Binding<Bool>, datePicked: Binding<Date>) {
           self._logMustBeAdded = logMustBeAdded
           self._datePicked = datePicked
           self._selectedDate = State<Date>(initialValue: datePicked.wrappedValue)
    }

    
    func addMealToTracker(name: String, date: Date) {
        tracker.logMeal(name, date)
        logMustBeAdded = false
    }
    
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 350, height: 700).shadow(color: Color.gray, radius: 10, x: 0, y: 5)
            VStack{
                Text("🍜")
                    .padding()
                    .font(.largeTitle)
                Text("Log A Meal")
                    .padding()
                    .font(.title)
                
                let mealOptions = Array(tracker.mealBook.keys)
                Text("Select A Meal:")
                    .font(.headline)
                Picker(selection: $selectedOption, label: Text("Select Meal")) {
                    ForEach(0..<mealOptions.count) { i in
                        Text(mealOptions[i]).tag(i)
                    }
                }
                
                let mealChosen = mealOptions[selectedOption]
                
                Text("Select A Date:")
                    .font(.headline)
                
                DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                
                Button(action: {addMealToTracker(name: mealChosen, date: selectedDate)} ) {
                    Text("Done")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }.padding()
                
            }
        }
    }
}
