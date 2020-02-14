//
//  CountryListRouter.swift
//  HelloWorld
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol CountryListRouter {
    func toDetail(_ country: CountryElement)
}

final class DefaultCountryListNavigator: CountryListRouter {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: CountryUseCase
    private let database: FavoriteUseCase

    init(services: CountryUseCase,
         database: FavoriteUseCase,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.database = database
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toDetail(_ country: CountryElement) {
        let navigator = DefaultCountryDetailNavigator(navigationController: navigationController)
        let viewModel = CountryDetailViewModel(country: country, countryUseCase: database, navigator: navigator)
        let vc = storyBoard.instantiateViewController(ofType: CountryDetailViewController.self)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}
