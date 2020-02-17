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
        let isfavorite: Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let displayModel = Driver.just(country)
            .map { object -> DisplayModel in
                let fullLanguage = object.languages.map { "\($0.nativeName)" }.joined(separator: ", ")
                return DisplayModel(flag: object.flag,
                                    name: object.name,
                                    languages: fullLanguage)
        }
        
        let action = Driver.combineLatest(input.checkStatus, input.action)
            .withLatestFrom(displayModel)
            .map { content -> Bool in
                let object = Favorite(code: content.name, flagPath: content.flag)
                return self.useCase.triggleFavorite(object: object)
        }
            
//            Driver.combineLatest(input.checkStatus, input.action, displayModel) { _, _, content -> Bool in
//            let object = Favorite(code: content.name, flagPath: content.flag)
//            return self.useCase.triggleFavorite(object: object)
//        }
//        let resultAPI = Driver.zip(input.action, isSuccess)
//          .withLatestFrom(Driver.combineLatest(citizen, phone, location))
//          .flatMap { (id, number, locate) in
//            return UserProvider.logIn(type: "ID_CARD", citizen: id, phone: number, token: nil, location: locate)
//              .trackActivity(activityIndicator)
//              .trackError(error)
//              .asDriverOnErrorJustComplete()
//        }
        
        
        return Output(detail: displayModel, isfavorite: action)
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
