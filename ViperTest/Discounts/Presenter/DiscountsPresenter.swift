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
