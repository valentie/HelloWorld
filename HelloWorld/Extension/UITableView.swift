//
//  UITableView.swift
//  HelloWorld
//
//  Created by creativeme on 13/2/2563 BE.
//  Copyright © 2563 creativeme. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(_ cellType: UITableViewCell.Type) {
        let cellNib = UINib(nibName: cellType.identifier, bundle: nil)
        register(cellNib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeue<Cell: UITableViewCell>(_ cellType: Cell.Type, at indexPath: IndexPath) -> Cell {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? Cell else {
                fatalError("Cannot deqeue reusable cell with identifier of \(cellType.identifier)")
        }
        return cell
    }
    
    func dequeue<Cell: UITableViewCell>(_ cellType: Cell.Type) -> Cell {
        guard
            let cell = dequeueReusableCell(withIdentifier: cellType.identifier) as? Cell else {
                fatalError("Cannot deqeue reusable cell with identifier of \(cellType.identifier)")
        }
        return cell
    }
    
    func get<Cell: UITableViewCell>(_ cellType: Cell.Type, at indexPath: IndexPath) -> Cell {
        guard
            let cell = cellForRow(at: indexPath) as? Cell else {
                fatalError("Cannot deqeue reusable cell with identifier of \(cellType.identifier)")
        }
        return cell
    }
}
