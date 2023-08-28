//
//  SettingsView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @State var goalMustBeChanged: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }.padding()
                
                Spacer()
                Image("Calorie")
                            .resizable()
                            .scaledToFit()
                HStack {
                    Text("Current Goal: ")
                        .font(.headline)
                    Text("\(tracker.getGoalCalories()) calories")
                }.padding()
                Button(action: {goalMustBeChanged = true} ) {
                    Text("Set New Calorie Goal")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(25.0)
                }.padding()
                
                Button(action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            let content = UNMutableNotificationContent()
                            content.title = "Get your calories in! 🍝"
                            content.subtitle = "Eat some food and log a meal in the Calorie Tracker"
                            content.sound = UNNotificationSound.default
                            
                            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: true)
                            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                            UNUserNotificationCenter.current().add(request)
                            
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }){
                    Image(systemName: "alarm")
                        .accessibilityLabel("Alarm clock")
                    Text("Remind me")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(40)
                Spacer()
            }
            
            if goalMustBeChanged {
                ChangeGoalView(goalMustBeChanged: $goalMustBeChanged).environmentObject(tracker)
            }
            
        }
        
        
        
        
    }
}
