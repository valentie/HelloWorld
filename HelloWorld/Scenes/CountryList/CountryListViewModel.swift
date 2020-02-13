//
//  CountryListViewModel.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

import Domain
import NetworkPlatform

class CountryListViewModel {
    private let useCase: CountryUseCase
    private let navigator: CountryListRouter
    
    init(countryUseCase: CountryUseCase, navigator: CountryListRouter) {
        self.useCase = countryUseCase
        self.navigator = navigator
    }
    
    struct Input {
        let fetchAction: Driver<Void>
    }
    
    struct Output {
//        let objects: Country
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(input: Input) -> Output {
        let fetch = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let servicesObservable = input.fetchAction.flatMap { [weak self] objects -> Observable<Country> in
            guard let self = self else { return Observable.never() }
            return useCase.getAll()
            .trackActivity(fetch)
            .trackError(errorTracker)
        }
        
        return Output(fetching: fetch.asDriver(), error: errorTracker.asDriver())
    }
}
