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

enum SwipeDirection {
    case left, right
}


protocol DiscountsInputPresenterProtocol {
    func swipe(into: SwipeDirection)
}

//typealias DiscountsPresenterProtocol = DiscountsInputPresenterProtocol & DiscountsOutputPresenterProtocol

final class DiscountsPresenter: DiscountsOutputPresenterProtocol {
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
