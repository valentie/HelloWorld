//
//  CountryDetailRouter.swift
//  HelloWorld
//
//  Created by creativeme on 14/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import UIKit
import Domain

protocol CountryDetailRouter {
    
}

final class DefaultCountryDetailNavigator: CountryDetailRouter {
    
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}
