//
//  CountryDetailViewModel.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

class CountryDetailViewModel {
    private let country: CellDisplayModel
    private let useCase: FavoriteUseCase
    private let navigator: CountryDetailRouter
    
    init(country: CellDisplayModel, countryUseCase: FavoriteUseCase, navigator: CountryDetailRouter) {
        self.country = country
        self.useCase = countryUseCase
        self.navigator = navigator
    }
    
    struct Input {
        let checkStatus: Driver<Void>
        let action: Driver<Void>
    }
    
    struct Output {
        let detail: Driver<DisplayModel>
        let isFavorite: Driver<Bool>
        let triggle: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let displayModel = Driver.just(country)
            .map { object -> DisplayModel in
                let fullLanguage = object.languages.map { "\($0.nativeName)" }.joined(separator: ", ")
                return DisplayModel(flag: object.flag,
                                    name: object.name,
                                    languages: fullLanguage)
        }
        
        let isFavorite = Driver.combineLatest(input.checkStatus, displayModel)
            .flatMap { _, content in
                return self.useCase.checkFavorite(name: content.name).asDriverOnErrorJustComplete()
        }
        
        let action = input.action
            .withLatestFrom(displayModel)
            .map { content -> Bool in
                let object = Favorite(code: content.name, flagPath: content.flag)
                return self.useCase.triggleFavorite(object: object)
        }
        
        return Output(detail: displayModel,isFavorite: isFavorite, triggle: action)
    }
}

typealias DisplayModel = CountryDetailViewModel.DisplayModel
// MARK: Display models
extension CountryDetailViewModel {
    struct DisplayModel: Codable {
        let flag: String
        let name: String
        let languages: String
    }
}
