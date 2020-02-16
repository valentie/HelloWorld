//
//  FavoriteUseCase.swift
//  Domain
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import RxSwift

public protocol FavoriteUseCase {
//    func checkFavorite(object: String) -> Observable<Bool>
    func fetchFavorite() -> Observable<[String]>
    func addFavortie(code: String) -> Observable<Void>
    func deleteFavorite(code: String) -> Observable<Void>
}
