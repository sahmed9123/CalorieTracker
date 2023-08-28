//
//  ContentView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/3/23.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @ObservedObject var tracker: CalorieTracker = CalorieTracker()
    
    var body: some View {
        TabView {
            VStack {
                SettingsView().environmentObject(tracker)
            }.tabItem {Label("Settings", systemImage: "gearshape")}
            
            VStack {
                LogView().environmentObject(tracker)
            }.tabItem {Label("Log", systemImage: "note.text")}
            
            VStack {
                MealView().environmentObject(tracker)
            }.tabItem {Label("Meals", systemImage: "frying.pan.fill")}
            
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
