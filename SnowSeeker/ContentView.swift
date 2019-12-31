//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Issac Penn on 2019/12/29.
//  Copyright © 2019 Issac Penn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var showingSortingActionSheet = false
    @State private var showingFilterSheet = false
    @State private var filters = ["country": "All", "size": "All", "price": "All"]
    private var resortsToShow: [Resort] {
        resorts.filter { resort in
            if filters["country"] != nil && filters["country"] != "All" && filters["country"]! != resort.country {
                return false
            }
            
            if filters["size"] != nil && filters["size"] != "All" && filters["size"]! != resort.sizeString {
                return false
            }
            
            if filters["price"] != nil && filters["price"] != "All" && filters["price"]! != resort.priceString {
                return false
            }
            return true
        }
    }
    @ObservedObject var favorites = Favorites()
    
    var body: some View {
        NavigationView {
            List(resortsToShow) { resort in
                 NavigationLink(destination: ResortView(resort: resort)) {
                     Image(resort.country)
                         .resizable()
                         .scaledToFill()
                         .frame(width: 40, height: 25)
                         .clipShape(
                             RoundedRectangle(cornerRadius: 2)
                         )
                         .overlay(
                             RoundedRectangle(cornerRadius: 2)
                                .stroke(Color.black.opacity(0.1), lineWidth: 0.5)
                         )

                     VStack(alignment: .leading) {
                         Text(resort.name)
                             .font(.headline)
                         Text("\(resort.runs) runs")
                             .foregroundColor(.secondary)
                     }
                     .layoutPriority(1)
                    
                    if self.favorites.contains(resort) {
                        Spacer()
                        Image(systemName: "heart.fill")
                        .accessibility(label: Text("This is a favorite resort"))
                            .foregroundColor(Color.red)
                    }
                 }
             }
             .navigationBarTitle("Resorts")
             .navigationBarItems(
                leading: Button("Filter") {
                    self.showingFilterSheet = true
                }, trailing: Button("Sort") {
                    self.showingSortingActionSheet = true
             })
            
            WelcomeView()
         }
         .environmentObject(favorites)
        .actionSheet(isPresented: $showingSortingActionSheet) {
            ActionSheet(title: Text("Sort By"), message: nil, buttons: [.default(Text("Default")) {
                    self.resorts = Bundle.main.decode("resorts.json")
                }, .default(Text("Alphabetical")) {
                    self.resorts = self.resorts.sorted { $0.name < $1.name }
                },.default(Text("Country")) {
                    self.resorts = self.resorts.sorted { $0.country < $1.country }
                },.cancel()])
            
        }
        .sheet(isPresented: $showingFilterSheet) {
            FilterView(resorts: self.$resorts, filters: self.$filters)
        }
     }
}

extension View {
    func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return AnyView(self.navigationViewStyle(StackNavigationViewStyle()))
        } else {
            return AnyView(self)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
