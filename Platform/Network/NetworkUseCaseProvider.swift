//
//  NetworkUseCase.swift
//  Platform
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Domain
import Moya
import RxSwift

public final class NetworkUseCaseProvider: Domain.CountryUseCase {
    
    public init() {
    }
    
    public func getAll() -> Observable<Country> {
        let service = CountryService.getAllCountry
        return provider.rx
            .request(MultiTarget(service))
            .filterSuccessfulStatusAndRedirectCodes()
            .map(Country.self)
            .asObservable()
    }
}
