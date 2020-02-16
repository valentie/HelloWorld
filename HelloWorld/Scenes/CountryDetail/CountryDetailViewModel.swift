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
    private let country: CountryElement
    private let useCase: FavoriteUseCase
    private let navigator: CountryDetailRouter
    
    init(country: CountryElement, countryUseCase: FavoriteUseCase, navigator: CountryDetailRouter) {
        self.country = country
        self.useCase = countryUseCase
        self.navigator = navigator
    }
    
    struct Input {
        let action: Driver<Void>
    }
    
    struct Output {
        let detail: Driver<DisplayModel>
    }
    
    func transform(input: Input) -> Output {
        let displayModel = Driver.just(country).map { object -> DisplayModel in
            let fullLanguage = object.languages.map { "\($0.nativeName)" }.joined(separator: ", ")
            return DisplayModel(flag: object.flag,
                                name: object.name,
                                languages: fullLanguage)
        }
        
        //fetch favorite display image
//        useCase.fetchFavorite()
        //action click favorite button
        
        let save = input.action.withLatestFrom(displayModel)
            .map { content in
                return content.name
        }
        
//        let save = input.action.withLatestFrom(Driver.just(country))
//            .map { content in
//                return content.name
//        }
//        .map { (title, content) in
//            return Post(body: content, title: title)
//        }
//        .flatMapLatest { [unowned self] in
//            return self.createPostUseCase.save(post: $0)
//                    .trackActivity(activityIndicator)
//                    .asDriverOnErrorJustComplete()
//        }
        
        return Output(detail: displayModel)
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
