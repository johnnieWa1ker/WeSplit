//
//  ContentView.swift
//  WeSplit
//
//  Created by Johnnie Walker on 9/30/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount: String = ""
    @State private var numberOfPeople: String = ""
    @State private var tipPercentage: Int = 2
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    private var peopleCount: Double {
        let numberOfPeopleDouble = Double(numberOfPeople) ?? 0
        return numberOfPeopleDouble
    }
    
    private var grandTotal: Double {
        let tipSelection = Double(tipPercentages[tipPercentage])
        let orderAmount = Double(amount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    private var totalPerPerson: Double {
        guard !grandTotal.isZero && !peopleCount.isZero else { return 0 }
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    TextField("Count of people", text: $numberOfPeople)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("How much tip would you like to tip?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total check amount")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.device)
            .previewDevice("iPhone 11 Pro")
    }
}
