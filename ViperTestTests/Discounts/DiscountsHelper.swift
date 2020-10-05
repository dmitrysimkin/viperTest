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
        return [DiscountViewModel(image: anyImage(), index: 0),
                DiscountViewModel(image: anyImage(), index: 1),
                DiscountViewModel(image: anyImage(), index: 2),
                DiscountViewModel(image: anyImage(), index: 3)]
    }
}

extension XCTestCase {
    func anyImage() -> UIImage {
        let colors: [UIColor] = [.red, .yellow, .green]
        let color = colors.randomElement()!
        
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return image
    }
}
