//
//  PsychicAPI.swift
//  Psychics
//
//  Created by Wellington Moreno on 1/27/17.
//  Copyright © 2017 Wellington Moreno. All rights reserved.
//

import Foundation

//Uses Singleton Pattern
class PsychicAPI {
    
    private init() { }
    
    static let instance = PsychicAPI()
    
    private let defaultURL = "https://test-m-api.californiapsychics.com/psychics?format=json"
    
    typealias Callback = ([Psychic]) -> ()

    func loadPsychics(callback: @escaping Callback) {
        loadPsychics(at: defaultURL, callback: callback)
    }
    
    func loadPsychics(at urlString: String, callback: @escaping Callback) {
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            callback([])
            return
        }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print("Encountered error loading psychics from: \(url) | \(error)")
                callback([])
                return
            }
            
            guard let data = data else {
                print("No data found at \(url)")
                callback([])
                return
            }
            
            guard let json = (try? JSONSerialization.jsonObject(with: data, options: []) ) as? NSDictionary else {
                print("Failed to load response as JSON: \(data)")
                callback([])
                return
            }
            
            let stores = self.getArrayOfPsychics(from: json)
            print("Found \(stores.count) stores from \(url)")
            callback(stores)
        }
        task.resume()
    }
    
    private func getArrayOfPsychics(from json: NSDictionary) -> [Psychic] {
        
        let array = findArrayOfPsychics(from: json)
        
        return array.filter() { $0 is NSDictionary }
                    .flatMap() { $0 as? NSDictionary }
                    .flatMap(Psychic.init)
    }
    
    private func findArrayOfPsychics(from json: NSDictionary) -> NSArray {
        return json["results"] as? NSArray ?? NSArray()
    }
}
