//
//  CountryService.swift
//  Platform
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Moya

enum CountryService {
  case getAllCountry
}

extension CountryService: TargetType {
  
  var baseURL: URL { return URL(string: "https://restcountries.eu/rest/v2")! }

  var path: String {
    switch self {
    case .getAllCountry:
      return "/all"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .getAllCountry:
      return .get
    }
  }
  
  var sampleData: Moya.Data {
    switch self {
    case .getAllCountry:
      return "".data(using: String.Encoding.utf8)!
    }
  }
  
  var task: Task {
    switch self {
    case .getAllCountry:
      return .requestPlain
    }
  }
  
  var headers: [String : String]? {
    switch self {
    case .getAllCountry:
      return ["Content-type": "application/json"]
    }
  }

  
}
