//
//  DiscountsViewTests.swift
//  ViperTestTests
//
//  Created by Dzmitry Simkin on 10/5/20.
//  Copyright © 2020 Dzmitry Simkin. All rights reserved.
//

import Foundation
import XCTest
@testable import ViperTest
import RxSwift

final class DiscountsViewTests: XCTestCase {
    
    func test_showFirstDiscountOnInit() {
        let discounts = anyDiscounts()
        let presenter = StubDiscountsPresenter(discounts: discounts)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DiscountsViewController.self))
        let sut = storyboard.instantiateInitialViewController() as! DiscountsViewController
        sut.presenter = presenter
        let window = UIWindow()
        window.rootViewController = sut
        window.makeKeyAndVisible()
        XCTAssertEqual(sut.imageView.image!, discounts.first!.image)
        XCTAssertEqual(sut.pageControl.currentPage, 0)
        XCTAssertEqual(sut.pageControl.numberOfPages, discounts.count)
        
        let newDiscountIndex = 2
        presenter.changeDiscount(at: newDiscountIndex)
        
        XCTAssertEqual(sut.imageView.image!, discounts[newDiscountIndex].image)
        XCTAssertEqual(sut.pageControl.currentPage, newDiscountIndex)
    }
}


final class StubDiscountsPresenter: DiscountsPresenterProtocol {
    func showNext() {
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
