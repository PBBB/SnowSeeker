//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Issac Penn on 2019/12/29.
//  Copyright © 2019 Issac Penn. All rights reserved.
//

import SwiftUI

struct ContentView: View {
     let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @ObservedObject var favorites = Favorites()

     var body: some View {
         NavigationView {
             List(resorts) { resort in
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
            
            WelcomeView()
         }
         .environmentObject(favorites)
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
