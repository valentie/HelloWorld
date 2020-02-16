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
    private let serviceUseCase: CountryUseCase
    private let dataBaseUseCase: FavoriteUseCase
    private let navigator: CountryListRouter
    
    init(countryUseCase: CountryUseCase, favariteUseCase: FavoriteUseCase, navigator: CountryListRouter) {
        self.serviceUseCase = countryUseCase
        self.dataBaseUseCase = favariteUseCase
        self.navigator = navigator
    }
    
    struct Input {
        let fetchAction: Driver<Void>
        let selection: Driver<IndexPath>
        let index: Driver<Int>
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
            return self.serviceUseCase.getAll()
                .trackActivity(fetch)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let objects = servicesObservable.map{ $0.map { CellDisplayModel(flag: $0.flag, name: $0.name, isFavotite: false) } }
        
        let favorite = self.dataBaseUseCase.fetchFavorite().asDriver(onErrorJustReturn: [])
        
        let tranform = Driver.combineLatest(objects, favorite).map { (data, favorite) -> [CellDisplayModel] in
            let abc = data.map { country -> CellDisplayModel in
                let isFav = favorite.contains { $0.code == country.name }
                return CellDisplayModel(flag: country.flag, name: country.name, isFavotite: isFav)
            }
            return abc
        }
        
        let data = Driver.combineLatest(tranform, input.index) { (content, index) -> [CellDisplayModel] in
            content.filter { object -> Bool in
                let value = object.isFavotite ? 1 : 0
                return value == index
            }
        }
        
        let fetching = fetch.asDriver()
        let errors = errorTracker.asDriver()
        
        let selectedCountry = input.selection
        .withLatestFrom(servicesObservable) { (indexPath, countrys) -> CountryElement in
            return countrys[indexPath.row]
        }
        .do(onNext: navigator.toDetail)
        
        return Output(objects: data, selectedCountry: selectedCountry, fetching: fetching, error: errors)
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
