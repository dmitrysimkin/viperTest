//
//  DiscountsViewController.swift
//  ViperTest
//
//  Created by Dzmitry Simkin on 10/6/20.
//  Copyright © 2020 Dzmitry Simkin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa


final class DiscountsViewController: UIViewController {
    var presenter: DiscountsOutputPresenterProtocol?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.discount.map({ $0.image }).bind(to: self.imageView.rx.image).disposed(by: disposeBag)
        presenter.discount.map({ $0.index }).bind(to: self.pageControl.rx.currentPage).disposed(by: disposeBag)
        pageControl.numberOfPages = presenter.discountsCount
    }
}
