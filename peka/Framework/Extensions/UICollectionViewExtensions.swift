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
    
    func register<T: UICollectionViewCell where T: ReusableView>(_: T.Type) {
        self.registerClass(T.self, forCellWithReuseIdentifier: T.identifier)
    }
    
    func register<T: UICollectionViewCell where T: protocol<ReusableView, NibLoadableView>>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.registerNib(nib, forCellWithReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCellWithReuseIdentifier(T.identifier, forIndexPath: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func register<T: UICollectionReusableView where T: protocol<ReusableView, NibLoadableView>>(_: T.Type, forSupplementaryViewOfKind supplementaryViewOfKind: String) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.registerNib(nib, forSupplementaryViewOfKind: supplementaryViewOfKind, withReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableView<T: UICollectionReusableView where T: ReusableView>(elementKind elementKind: String, forIndexPath indexPath: NSIndexPath) -> T {
        guard let view = self.dequeueReusableSupplementaryViewOfKind(elementKind, withReuseIdentifier: T.identifier, forIndexPath: indexPath) as? T else {
            fatalError("Could not dequeue view with identifier: \(T.identifier)")
        }
        return view
    }
    
    func configurableCells<S: SequenceType, Cell: UICollectionViewCell, O : ObservableType where O.E == S, Cell: protocol<ReusableView, Configurable>, Cell.T == S.Generator.Element>
        (_: Cell.Type)
        -> (source: O)
        -> Disposable {
            return { source in
                return source.bindTo(self.rx_itemsWithCellIdentifier(Cell.identifier, cellType: Cell.self)) { _, model, cell in
                    cell.configure(model)
                }
            }
    }
}