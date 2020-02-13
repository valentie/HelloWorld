//
//  UseCaseProvider.swift
//  Domain
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    
    func makeUseCase() -> CountryUseCase
}
