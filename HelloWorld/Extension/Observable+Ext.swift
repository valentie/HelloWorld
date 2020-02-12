//
//  Observable+Ext.swift
//  T-Leasing
//
//  Created by creativeme on 2/11/2562 BE.
//  Copyright © 2562 CreativeMe. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension ObservableType where Element == Bool {
  
  func not() -> Observable<Bool> {
    return self.map(!)
  }
  
  func only(_ value: Bool) -> Observable<Bool> {
    return self.filter { $0 == value }
  }
  
  func onlyTrue() -> Observable<Bool> {
    return self.only(true)
  }
  
  func onlyFalse() -> Observable<Bool> {
    return self.only(false)
  }
  
}

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}

extension ObservableType {
  
  func catchErrorJustComplete() -> Observable<Element> {
    return catchError { _ in
      return Observable.empty()
    }
  }
  
  func asDriverOnErrorJustComplete() -> Driver<Element> {
    return asDriver { error in
      return Driver.empty()
    }
  }
  
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
  
  func skipFirst() -> Observable<Element> {
    return skip(1)
  }
}
