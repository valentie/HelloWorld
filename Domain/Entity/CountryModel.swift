//
//  CountryModel.swift
//  Domain
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation

public typealias Country = [CountryElement]

// MARK: - CountryElement
public struct CountryElement: Codable {
    public let alpha2Code, alpha3Code, nativeName: String
    public let region: String
    public let borders: [String]
    public let numericCode: String?
    public let currencies: [Currency]
    public let translations: Translations
    public let flag: String
    public let name: String
    public let cioc: String?
    public let callingCodes, timezones: [String]
    public let subregion: String
    public let altSpellings, topLevelDomain: [String]
    public let population: Int
    public let area: Double?
    public let regionalBlocs: [RegionalBloc]
    public let latlng: [Double]
    public let capital: String
    public let gini: Double?
    public let demonym: String
    public let languages: [Language]
}

// MARK: - Currency
public struct Currency: Codable {
    public let name, symbol, code: String?
}

// MARK: - Language
public struct Language: Codable {
    public let nativeName, iso639_2, name: String
    public let iso639_1: String?

    enum CodingKeys: String, CodingKey {
        case nativeName
        case iso639_2
        case name
        case iso639_1
    }
}

// MARK: - RegionalBloc
public struct RegionalBloc: Codable {
    public let otherNames: [String]
    public let otherAcronyms: [String]
    public let acronym: String
    public let name: String
}

// MARK: - Translations
public struct Translations: Codable {
    public let fr, pt, de, it, nl, es, br, hr, fa, ja: String?
}
