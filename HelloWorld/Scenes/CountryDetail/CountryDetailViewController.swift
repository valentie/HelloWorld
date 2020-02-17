//
//  CountryDetailViewController.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountryDetailViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var viewModel: CountryDetailViewModel!
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
        .mapToVoid()
        .asDriverOnErrorJustComplete()
        .startWith(())
        let action = favoriteButton.rx.tap.asDriver()
        let input = CountryDetailViewModel.Input(checkStatus: viewWillAppear, action: action)
        let output = viewModel.transform(input: input)
        
        output.detail.drive(onNext: { [weak self] object in
            guard let self = self else { return }
            guard let svgUrl = URL(string: object.flag) else { return }
            let bitmapSize = CGSize(width: 300, height: 200)
            self.flagImage.sd_setImage(with: svgUrl, placeholderImage: UIImage(named: "noImage"), options: [], context: [.imageThumbnailPixelSize : bitmapSize])
            self.title = object.name
            self.nameLabel.text = "Name : \(object.name)"
            self.languageLabel.text = "Language : \(object.languages)"
        }).disposed(by: disposeBag)
        
        output.isFavorite.drive(onNext: { [weak self] isShow in
            guard let self = self else { return }
            self.setStar(isShow)
        }).disposed(by: disposeBag)
        
        output.triggle.drive(onNext: { [weak self] isFavorite in
            guard let self = self else { return }
            self.setStar(isFavorite)
        }).disposed(by: disposeBag)
    }
    
    func setStar(_ setStar: Bool) {
        if setStar {
            self.favoriteButton.setBackgroundImage(UIImage(named: "star"), for: .normal)
        }else{
            self.favoriteButton.setBackgroundImage(UIImage(named: "blackStar"), for: .normal)
        }
    }
}
