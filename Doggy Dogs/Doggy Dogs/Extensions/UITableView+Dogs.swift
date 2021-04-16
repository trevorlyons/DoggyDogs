//
//  UITableView+Dogs.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 15/04/2021.
//

import UIKit

extension UITableView {
    
    func dequeue<T: UITableViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
    func register<T : UITableViewCell>(cell: T.Type) {
        let name = String(describing: cell)
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
}
