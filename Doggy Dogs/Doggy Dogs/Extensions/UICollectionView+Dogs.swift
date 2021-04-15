//
//  UICollectionView+Dogs.swift
//  Doggy Dogs
//
//  Created by Trevor Lyons on 15/04/2021.
//

import UIKit

extension UICollectionView {
    
    func dequeue<T: UICollectionViewCell>(cell: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
    }
    
    func register<T : UICollectionViewCell>(cell: T.Type) {
        let name = String(describing: cell)
        register(UINib(nibName: name, bundle: nil), forCellWithReuseIdentifier: name)
    }
}
