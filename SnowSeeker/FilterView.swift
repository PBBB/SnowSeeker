//
//  FilterView.swift
//  SnowSeeker
//
//  Created by PBB on 2019/12/31.
//  Copyright © 2019 Issac Penn. All rights reserved.
//

import SwiftUI

struct FilterView: View {
    @Binding var resorts: [Resort]
    @Binding var filters: [String: String]
    
    private let countries = ["All", "Austria", "Canada", "France", "Italy", "United States"]
    private let sizes = ["All", "Small", "Average", "Large"]
    private let prices = ["All", "$$", "$$$"]
    
    @State private var selectedCountry = "All"
    @State private var selectedSize = "All"
    @State private var selectedPrice = "All"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $selectedCountry, label: Text("Country")) {
                    ForEach (countries, id: \.self) { country in
                        Text(country)
                    }
                }
                
                HStack {
                    Text("Size")
                        .padding(.trailing, 30)
                    Picker(selection: $selectedSize, label: Text("Size")) {
                            ForEach (sizes, id: \.self) { size in
                                Text(size)
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                HStack {
                    Text("Price")
                        .padding(.trailing, 24)
                    Picker(selection: $selectedPrice, label: Text("Price")) {
                            ForEach (prices, id: \.self) { price in
                                Text(price)
                            }
                        }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Apply Filter") {
                        self.filters = ["country": self.selectedCountry, "size": self.selectedSize, "price": self.selectedPrice]
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
                
                Section {
                    Button("Clear Filter") {
                        self.selectedCountry = "All"
                        self.selectedSize = "All"
                        self.selectedPrice = "All"
                    }
                    .foregroundColor(.red)
                }
                
                
            }
            .navigationBarTitle(Text("Filter"), displayMode: .inline)
            .navigationBarItems(leading: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
        .onAppear {
            self.selectedCountry = self.filters["country"] ?? "All"
            self.selectedSize = self.filters["size"] ?? "All"
            self.selectedPrice = self.filters["price"] ?? "All"
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        let resorts = Binding.constant([Resort.example])
        let filters = Binding.constant(["country": "All", "size": "All", "price": "All"])
        return FilterView(resorts: resorts, filters: filters)
    }
}
