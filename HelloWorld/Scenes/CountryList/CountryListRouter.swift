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
    func toDetail()
}

final class DefaultCountryListNavigator: CountryListRouter {
    
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: CountryUseCase

    init(services: CountryUseCase,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toDetail() {
//        navigationController.dismiss(animated: true)
    }
}
