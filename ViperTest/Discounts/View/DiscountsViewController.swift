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
    var presenter: DiscountsPresenterProtocol?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.discount.subscribe(onNext: { [weak self] vm in
            self?.animateNextDiscount(vm.image)
            }).disposed(by: disposeBag)
        presenter.discount.map({ $0.index }).bind(to: self.pageControl.rx.currentPage).disposed(by: disposeBag)
        pageControl.numberOfPages = presenter.discountsCount
        let gr = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(gr)
    }
    
    private func animateNextDiscount(_ image: UIImage) {
        guard let snapshotView = imageView.snapshotView(afterScreenUpdates: false) else {
            imageView.image = image
            return
        }
        view.addSubview(snapshotView)
        snapshotView.translatesAutoresizingMaskIntoConstraints = false
        snapshotView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        snapshotView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        snapshotView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        snapshotView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        
        let width = imageView.bounds.size.width
        imageView.transform = CGAffineTransform(translationX: width, y: 0)
        imageView.image = image
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageView.transform = .identity
            snapshotView.transform = CGAffineTransform(translationX: -width, y: 0)
        }, completion: { _ in
            snapshotView.removeFromSuperview()
        })
        
    }
    
    @objc func tapped() {
        presenter?.showNext()
    }
}
