//
//  Country.swift
//  CountriesRXSwift
//
//  Created by Mwai Banda on 6/1/22.
//

import Foundation

struct CountryResponse: Codable {
    var fetchMessage: String
    var collection: [Country]
    
    enum CodingKeys: String, CodingKey {
        case fetchMessage = "msg"
        case collection = "data"
    }
}

struct Country: Codable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var unicodeFlag: String
    var flagURL: String?
    var cities: [String]?

    enum CodingKeys: String, CodingKey {
        case name
        case unicodeFlag
        case cities
        case flagURL = "flag"
    }
}





