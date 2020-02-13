//
//  CountryUseCase.swift
//  Domain
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import RxSwift

public protocol CountryUseCase {
    func getAll() -> Observable<Country>
}
