//
//  CountryListViewController.swift
//  HelloWorld
//
//  Created by creativeme on 12/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SkeletonView

class CountryListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var viewModel: CountryListViewModel!
    private var country = [CellDisplayModel]()
    
    @IBOutlet weak var listView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
    }
    
    override func viewDidLayoutSubviews() {
        view.layoutSkeletonIfNeeded()
    }
    
    func bindUI() {
        let viewWillAppear = rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()
            .startWith(())
        
        let input = CountryListViewModel.Input(fetchAction: viewWillAppear,
                                               selection: listView.rx.itemSelected.asDriver())
        let output = viewModel.transform(input: input)
        
        output.fetching
        .drive(view.rx.showSkeletonLoading)
        .disposed(by: disposeBag)
        
        output.objects
        .drive(onNext: { [weak self] objects in
          guard let self = self else { return }
          self.country = objects
          self.listView.reloadData()
        })
        .disposed(by: disposeBag)
        
        output.selectedCountry
        .drive()
        .disposed(by: disposeBag)
    }
}

// MARK: - TableView

extension CountryListViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return country.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let object = country[indexPath.row]
    let cell = tableView.dequeue(ListTableViewCell.self)
    cell.setUpObject(object: object)
    cell.setNeedsLayout()
    cell.layoutIfNeeded()
    return cell
  }
}

extension CountryListViewController: SkeletonTableViewDataSource  {
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
      return ListTableViewCell.identifier
    }
}


