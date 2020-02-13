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
        let objects: Driver<[CountryElement]>
        let fetching: Driver<Bool>
        let error: Driver<Error>
    }
    
    func transform(input: Input) -> Output {
        let fetch = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let servicesObservable = input.fetchAction.flatMap { [weak self] objects -> Driver<[CountryElement]> in
            guard let self = self else { return Driver.never() }
            return self.useCase.getAll()
            .trackActivity(fetch)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        }
        
        let fetching = fetch.asDriver()
        let errors = errorTracker.asDriver()
        
        return Output(objects: servicesObservable, fetching: fetching, error: errors)
    }
}
