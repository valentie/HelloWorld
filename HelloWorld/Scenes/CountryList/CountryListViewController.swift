//
//  CountryListViewController.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit
import RxSwift

class CountryListViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private var viewModel: CountryListViewModel!
    
    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    func bindUI() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
        .mapToVoid()
        .asDriverOnErrorJustComplete()
        .startWith(())
        
        let input = CountryListViewModel.Input(fetchAction: viewWillAppear)
        let output = viewModel.transform(input: input)
        
        output.objects
        .drive(onNext: { [weak self] objects in
            guard let self = self else { return }
            print(objects)
        })
        .disposed(by: disposeBag)
    }
}
