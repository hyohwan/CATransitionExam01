//
//  Dynamic.swift
//  CATransitionExam01
//
//  Created by Hyohwan Seo on 2021/11/03.
//

import Foundation

class Dynamic<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }

    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }

    var value: T {
        didSet {
            print("Dynamic didSet \(value)")
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }
}
