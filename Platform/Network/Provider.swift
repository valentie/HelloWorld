//
//  Provider.swift
//  Platform
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Alamofire
import Moya

class DefaultAlamofireSession: Alamofire.Session {
    static let shared: DefaultAlamofireSession = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 20 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 20 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireSession(configuration: configuration)
    }()
}

public let provider: MoyaProvider<MultiTarget> = {
  let networkLoggerPluggin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
  
  return MoyaProvider<MultiTarget>(session: DefaultAlamofireSession.shared, plugins: [networkLoggerPluggin])
}()
