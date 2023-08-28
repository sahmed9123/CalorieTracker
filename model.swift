//
//  model.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation

struct Meal {
    var calories: Int
    var description: String
    var carbs: Int
    var protein: Int
    var fats: Int
    //var image: Image?
    
    //add image: Image?
    init(calories: Int, description: String, carbs: Int, protein: Int, fats: Int) {
        self.calories = calories
        self.description = description
        self.carbs = carbs
        self.protein = protein
        self.fats = fats
        //self.image = image
    }
}

class CalorieTracker: ObservableObject {
    //@Published var userWeight : Int
    //@Published var userHeight : Int
    @Published var goalCalories : Int
    @Published var mealBook : [String : Meal]
    @Published var calorieLog : [String : Int]
    @Published var mealLog : [String : [String]]
    
    
    init () {
        self.goalCalories = 2000
        self.mealBook = [:]
        self.calorieLog = [:]
        self.mealLog = [:]
        
        self.addMealBook(name: "Pasta", calories: 340, description: "Creamy, rich pasta alla vodka.", carbs: 14, protein: 8, fats: 4)
    }
    
    // Set the user's goal calories
    func setGoalCalories (_ newGoal: Int) {
        goalCalories = newGoal
    }
    
    func getGoalCalories () -> Int {
        return goalCalories
    }
    
    func getMeal(_ name: String) -> Meal {
        return mealBook[name] ?? mealBook["Pasta"]!
    }
    
    // Returns true if a meal was successfully added to the meal book. If a meal with the given name already exists in
    // the meal book, nothing is done and false is returned.
    func addMealBook(name: String, calories: Int, description: String, carbs: Int, protein: Int, fats: Int) -> Bool{
        if mealBook.contains(where: { $0.key == name }) {
            return false
        }
        
        if calories == -1 || carbs == -1 || protein == -1 || fats == -1 || name == "No Meals" {
            return false
        }
        
        let newMeal = Meal(calories: calories, description: description, carbs: carbs, protein: protein, fats: fats)
        mealBook[name] = newMeal
        
        return true
    }
    
    func logMeal (_ mealName: String, _ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYYY"
        let strDate = formatter.string(from: date)
        
        if let meal = mealBook[mealName] {
            if let currentCalories = calorieLog[strDate] {
                calorieLog[strDate] = currentCalories + meal.calories
                mealLog[strDate]?.append(mealName)
            } else {
                calorieLog[strDate] = meal.calories
                mealLog[strDate] = [mealName]
            }
            
        }
        
    }
    
    func deleteMeal(_ mealName: String, _ date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYYY"
        let strDate = formatter.string(from: date)
        
        if let meal = mealBook[mealName] {
            if let currentCalories = calorieLog[strDate] {
                calorieLog[strDate] = currentCalories - meal.calories
                if let index = mealLog[strDate]!.firstIndex(of: mealName) {
                    mealLog[strDate]!.remove(at: index)
                }
            }
        }
    }
    
    func getDateCals(_ date: Date) -> Int {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYYY"
        let strDate = formatter.string(from: date)
        
        return calorieLog[strDate] ?? 0
    }
    
    func getDateMeals(_ date: Date) -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYYY"
        let strDate = formatter.string(from: date)
        
        if let mealNames = mealLog[strDate] {
            return mealNames
        } else {
            return ["No Meals"]
        }
    }
    
    func getMealCalories(_ mealName: String) -> Int {
        return mealBook[mealName]?.calories ?? 0
    }
    
    func getDateString(_ date: Date)-> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM YYYY"
        return formatter.string(from: date)

    }
    
    func isGoalMet(_ date: Date) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMYYYY"
        let strDate = formatter.string(from: date)
        
        let currCals = calorieLog[strDate] ?? 0
        if currCals >= goalCalories {
            return true
        }
        return false
    }
    
    
    
}
