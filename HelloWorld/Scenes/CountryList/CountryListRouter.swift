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
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toDetail() {
//        navigationController.dismiss(animated: true)
    }
}
