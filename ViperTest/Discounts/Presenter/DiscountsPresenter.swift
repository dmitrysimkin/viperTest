//
//  DiscountsPresenter.swift
//  ViperTest
//
//  Created by Dzmitry Simkin on 10/6/20.
//  Copyright © 2020 Dzmitry Simkin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

struct DiscountViewModel {
    let image: UIImage
    let index: Int
    let id = UUID()
}


protocol DiscountsOutputPresenterProtocol {
    var discount: Observable<DiscountViewModel> { get }
    var discountsCount: Int { get }
}

protocol DiscountsInputPresenterProtocol {
    func showNext()
}

typealias DiscountsPresenterProtocol = DiscountsInputPresenterProtocol & DiscountsOutputPresenterProtocol

final class DiscountsPresenter: DiscountsPresenterProtocol {
    func showNext() {
        let currentIndex = try! discountSubject.value().index
        var nextIndex: Int = currentIndex + 1
        if nextIndex >= discountsCount {
            nextIndex = 0
        }
        changeDiscount(at: nextIndex)
    }
    
    var discount: Observable<DiscountViewModel> { discountSubject.asObserver() }
    var discountSubject: BehaviorSubject<DiscountViewModel>
    
    var discountsCount: Int { discounts.count }
    private let discounts: [DiscountViewModel]
    
    func changeDiscount(at index: Int) {
        discountSubject.onNext(discounts[index])
    }
    
    init(discounts: [DiscountViewModel]) {
        self.discounts = discounts
        discountSubject = BehaviorSubject<DiscountViewModel>(value: discounts.first!)
    }
}
