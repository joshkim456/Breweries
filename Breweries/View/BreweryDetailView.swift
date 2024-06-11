//
//  BreweryDetailView.swift
//  Breweries
//
//  Created by Kim, Joshua (WING) on 11/06/2024.
//

import SwiftUI

struct BreweryDetailView: View {
    let breweryId: String
    let breweryWebAdaptor = BreweryWebAdaptor.shared
    @State var brewery: BrewerySingle?
    
    var body: some View {
        VStack {
            if let brewery = brewery {
                Text("Name: \(brewery.name)")
                Text("Brewery Type: \(brewery.brewery_type)")
                Text("Street: \(brewery.street)")
                Text("City: \(brewery.city)")
            } else {
                Text("Cannot load brewery")
            }
        }
        .onAppear {
            breweryWebAdaptor.singleBrewery(for: breweryId) { returnedBrewery in
                brewery = returnedBrewery
            }
        }
    }
}

#Preview {
    BreweryDetailView(breweryId: "8a2ef743-8539-4d41-828b-fc91dcecf6a1")
}
