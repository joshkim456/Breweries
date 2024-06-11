//
//  BreweryWebAdaptor.swift
//  Breweries
//
//  Created by Kim, Joshua (WING) on 11/06/2024.
//

import Foundation

class BreweryWebAdaptor {
    static let shared = BreweryWebAdaptor()
    
    private init() {}
    
    private let baseUrl = "https://api.openbrewerydb.org/v1/breweries/"
    private let decoder = JSONDecoder()
    
    func search(for query: String, completion: @escaping([BreweryLightweight]) -> Void) {
        
        // Make a URL object
        let query = "autocomplete?query=\(query)"
        guard let url = URL(string: baseUrl + query) else {
            print("Invalid URL")
            return
        }
        // Make a URLSession dataTask (object for calling a web api using a url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let results = try? self.decoder.decode([BreweryLightweight].self, from: data) else {
                print("Error decoding JSON")
                return
            }
            
            completion(results)
            
        }
        
        // Run this dataTask (initiate)
        task.resume()
    }
    
    func singleBrewery(for query: String, completion: @escaping(BrewerySingle) -> Void) {
        // Make a URL object
        let query = query
        
        guard let url = URL(string: baseUrl + query) else {
            print("Invalid URL")
            return
        }
        
        // Make a URLSession dataTask (object for calling a web api using a url)
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let results = try? self.decoder.decode(BrewerySingle.self, from: data) else {
                print("Error decoding JSON")
                return
            }
            
            completion(results)
        }
        
        // Run this dataTask (initiate)
        task.resume()
    }
}
