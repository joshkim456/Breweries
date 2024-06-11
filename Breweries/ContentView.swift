//
//  ContentView.swift
//  Breweries
//
//  Created by Kim, Joshua (WING) on 11/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var search: String = ""
    @State private var breweries: [BreweryLightweight] = []
    
    let breweryWebAdaptor = BreweryWebAdaptor.shared
    
    var body: some View {
        NavigationStack {
            TextField("Enter brewery", text: $search)
                .onChange(of: search) { oldValue, newValue in
                    breweryWebAdaptor.search(for: newValue) { results in
                        breweries = results
                    }
                }
                .padding()
    
            Text("List of Breweries")
            
            List {
                ForEach(breweries, id:\.id) { brewery in
                    NavigationLink("\(brewery.name)") {
                        BreweryDetailView(breweryId: brewery.id)
                    }
                }
            }
            .navigationTitle("Brewery API")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
