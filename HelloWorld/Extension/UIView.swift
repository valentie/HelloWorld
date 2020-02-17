//
//  UIView.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SkeletonView

extension UIView {
  static var identifier: String {
    return String(describing: self)
  }
}

// MARK: - Skeleton + Rx

extension Reactive where Base: UIView {
  
  var showSkeletonLoading: Binder<Bool> {
    return Binder<Bool>(base) { baseView, isLoading in
      if isLoading {
        baseView.showAnimatedSkeleton()
      } else {
        baseView.hideSkeleton()
      }
    }
  }
  
}
