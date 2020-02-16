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
import SDWebImageSVGCoder

final class Application {
    static let shared = Application()
    
    private let useCaseProvider: Domain.CountryUseCase
    private let favoriteProvider: Domain.FavoriteUseCase
    
    private init() {
        self.useCaseProvider = NetworkUseCaseProvider()
        self.favoriteProvider = CoreDataUserCaseProvider.instance
    }
    
    func configureMainInterface(in window: UIWindow) {
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homePage = storyboard.instantiateViewController(ofType: CountryListViewController.self)
        let navigationController = UINavigationController(rootViewController: homePage)
        
        let navigator = DefaultCountryListNavigator(services: useCaseProvider,
                                                    database: favoriteProvider,
                                                    navigationController: navigationController,
                                                    storyBoard: storyboard)
        
        homePage.viewModel = CountryListViewModel(countryUseCase: useCaseProvider, favariteUseCase: favoriteProvider, navigator: navigator)
        window.rootViewController = navigationController
        
    }
}
