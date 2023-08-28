//
//  ChangeGoalView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct ChangeGoalView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @State var inputNewGoal: String = String()
    @Binding var goalMustBeChanged: Bool
    
    @State private var showAlert = false
    @State var alertMessage: String = String()
    
    func done (_ newGoal: Int) {
        if newGoal == -1 {
            alertMessage = "Change Failed! Make sure to enter a valid input."
        } else {
            tracker.setGoalCalories(newGoal)
            alertMessage = "Successfully changed calories to \(newGoal)."
        }
        showAlert = true
    }
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 300, height: 250).shadow(color: Color.gray, radius: 10, x: 0, y: 5)
            VStack{
                Text("🍽")
                    .padding()
                    .font(.largeTitle)
                Text("Enter new calorie goal: ")
                    .padding()
                    .font(.headline)
                HStack {
                    TextField("",text:$inputNewGoal)
                        .padding()
                        .frame(width:100, height:20, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("calories")
                }
                let newGoal = Int(inputNewGoal) ?? -1
                Button(action: {done(newGoal)} ) {
                    Text("Done")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(25.0)
                }.padding()
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Goal Change Status"),
                            message: Text("\(alertMessage)"),
                            dismissButton: .default(Text("OK")) {
                                goalMustBeChanged = false
                            }
                        )
                    }
                
            }
            
        }
    }
}

