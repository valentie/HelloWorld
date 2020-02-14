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
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let objects: Driver<[CellDisplayModel]>
        let selectedCountry: Driver<CountryElement>
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
        
        let objects = servicesObservable.map{ $0.map { CellDisplayModel(flag: $0.flag, name: $0.name, isFavotite: false) } }
        
        //fetch CoreData Favorite and change value
        
        //split 2 section
        
        let fetching = fetch.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedCountry = input.selection
        .withLatestFrom(servicesObservable) { (indexPath, countrys) -> CountryElement in
            return countrys[indexPath.row]
        }
        .do(onNext: navigator.toDetail)
        
        return Output(objects: objects, selectedCountry: selectedCountry, fetching: fetching, error: errors)
    }
}

typealias CellDisplayModel = CountryListViewController.CellDisplayModel
// MARK: Display models
extension CountryListViewController {
    struct CellDisplayModel: Codable {
        var flag: String
        var name: String
        var isFavotite: Bool
    }
}
