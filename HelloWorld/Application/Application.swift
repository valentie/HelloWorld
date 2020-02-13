//
//  Application.swift
//  HelloWorld
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit
import Domain
import Platform

final class Application {
    static let shared = Application()

    private let useCaseProvider: Domain.CountryUseCase

    private init() {
        self.useCaseProvider = NetworkUseCaseProvider()
    }

    func configureMainInterface(in window: UIWindow) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage = storyboard.instantiateViewController(ofType: CountryListViewController.self)
        let navigationController = UINavigationController(rootViewController: homePage)
        
        let navigator = DefaultCountryListNavigator(services: useCaseProvider,
        navigationController: navigationController,
        storyBoard: storyboard)
        
        homePage.viewModel = CountryListViewModel(countryUseCase: useCaseProvider, navigator: navigator)
        window.rootViewController = navigationController
        
    }
}
