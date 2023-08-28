//
//  AddMealView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct AddMealView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @State var inputName: String = String()
    @State var inputCalories: String = String()
    @State var inputDescription: String = String()
    @State var inputCarbs: String = String()
    @State var inputProtein: String = String()
    @State var inputFats: String = String()
    
    @State private var showAlert = false
    @State var alertMessage: String = String()
    
    @Binding var mealMustBeAdded: Bool
    
    func addMeal(name: String, calories: Int, description: String, carbs: Int, protein: Int, fats: Int) {
        //add meal
        let addSuccess = tracker.addMealBook(name: name, calories: calories, description: description, carbs: carbs, protein: protein, fats: fats)
        
        if addSuccess {
            alertMessage = "Successfully added new meal."
        } else {
            alertMessage = "Meal was not added. Make sure all fields are correct."
        }
        showAlert = true
        
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 350, height: 700).shadow(color: Color.gray, radius: 10, x: 0, y: 5)
            VStack{
                Text("🍽")
                    .padding()
                    .font(.largeTitle)
                Text("Add new Meal")
                    .padding()
                    .font(.headline)
                VStack {
                    HStack {
                        Text("Meal Name: ")
                        TextField("",text: $inputName)
                            .frame(width:150, height:20, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    HStack {
                        Text("Calories: ")
                        TextField("",text: $inputCalories)
                            .frame(width:100, height:20, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }.padding()
                    HStack {
                        VStack {
                            Text("Meal Description: ")
                            TextField("",text: $inputDescription)
                                .frame(width: 250, height:20, alignment: .center)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }
                    }.padding()
                    HStack {
                        Text("Carbs: ")
                        TextField("",text: $inputCarbs)
                            .frame(width:50, height:20, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("grams")
                    }.padding()
                    HStack {
                        Text("Protein: ")
                        TextField("",text: $inputProtein)
                            .frame(width:50, height:20, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("grams")
                    }.padding()
                    HStack {
                        Text("Fats: ")
                        TextField("",text: $inputFats)
                            .frame(width:50, height:20, alignment: .center)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text("grams")
                    }.padding()
                }
                let mealCalories = Int(inputCalories) ?? -1
                let mealCarbs = Int(inputCarbs) ?? -1
                let mealProtein = Int(inputProtein) ?? -1
                let mealFats = Int(inputProtein) ?? -1
                
                Button(action: {addMeal(name: inputName, calories: mealCalories, description: inputDescription, carbs: mealCarbs, protein: mealProtein, fats: mealFats)} ) {
                    Text("Add Meal")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }.padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Meal Add Status"),
                        message: Text("\(alertMessage)"),
                        dismissButton: .default(Text("OK")) {
                            mealMustBeAdded = false
                        }
                    )
                }
            }
        }
    }
}
