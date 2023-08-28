//
//  DateToView.swift
//  CalorieTracker
//
//  Created by padma karumuri on 5/4/23.
//

import Foundation
import SwiftUI

struct DateToView: View {
    @EnvironmentObject var tracker: CalorieTracker
    @Binding var pickDateToView: Bool
    @Binding var datePicked: Date
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.white).frame(width: 350, height: 400).shadow(color: Color.gray, radius: 10, x: 0, y: 5)
            VStack {
                Text("Pick a Date To View")
                    .padding()
                    .font(.title)
                DatePicker("Select a date", selection: $datePicked, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                Button(action: {pickDateToView = false} ) {
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
