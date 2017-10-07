//
//  UICollectionViewExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell>(_: T.Type) where T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind supplementaryViewOfKind: String) where T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.register(nib, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(elementKind: String, forIndexPath indexPath: IndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.identifier)")
        }
        return view
    }
    
    func configurableCells<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
        (_: Cell.Type)
        -> (_ source: O)
        -> Disposable where O.E == S, Cell: Configurable, Cell.T == S.Iterator.Element {
            return { source in
                return source.bindTo(self.rx.items(cellIdentifier: Cell.identifier, cellType: Cell.self)) { _, model, cell in
                    cell.configure(model)
                }
            }
    }
}
