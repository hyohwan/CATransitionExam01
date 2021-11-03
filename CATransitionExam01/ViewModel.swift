//
//  ViewModel.swift
//  CATransitionExam01
//
//  Created by Hyohwan Seo on 2021/11/03.
//

import UIKit

class ViewModel {
    
    enum Direction {
        case none
        case prev, next
    }
    
    let current = Dynamic(0)
    
    var circularPrev: Int {
        let prev = current.value - 1
        return prev >= 0 ? prev : pages.count - 1
    }
    var circularNext: Int {
        let next = current.value + 1
        return next < pages.count ? next : 0
    }
    var currentPage: Page {
        pages[current.value]
    }
    var direction: Direction = .none
    let pages = [
        Page(title: "Page 01", decsription: "first page", bgColor: .red, titleColor: .white),
        Page(title: "Page 02", decsription: "second page", bgColor: .orange, titleColor: .white),
        Page(title: "Page 03", decsription: "third page", bgColor: .yellow),
        Page(title: "Page 04", decsription: "fourth page", bgColor: .green, titleColor: .purple),
        Page(title: "Page 05", decsription: "fifth page", bgColor: .blue, titleColor: .white),
        Page(title: "Page 06", decsription: "sixth page", bgColor: .purple, titleColor: .white),
    ]
    
    func setPage(direction: Direction) {
        self.direction = direction
        switch direction {
        case .prev:
            current.value = circularPrev
        case .next:
            current.value = circularNext
        default:
            break
        }
    }
}

struct Page {
    var title: String?
    var decsription: String?
    var bgColor: UIColor = .white
    var titleColor: UIColor = .black
}
