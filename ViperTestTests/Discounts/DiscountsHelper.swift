//
//  DiscountsHelper.swift
//  ViperTestTests
//
//  Created by Dzmitry Simkin on 10/6/20.
//  Copyright © 2020 Dzmitry Simkin. All rights reserved.
//

import XCTest
@testable import ViperTest
import UIKit

extension XCTestCase {
    func anyDiscounts() -> [DiscountViewModel] {
        return [DiscountViewModel(image: UIImage.anyImage(), index: 0),
                DiscountViewModel(image: UIImage.anyImage(), index: 1),
                DiscountViewModel(image: UIImage.anyImage(), index: 2),
                DiscountViewModel(image: UIImage.anyImage(), index: 3)]
    }
}

