//
//  UITableViewExtensions.swift
//  peka
//
//  Created by Tomasz Pikć on 28/07/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

extension UITableView {
    
    func register<T: UITableViewCell where T: ReusableView>(_: T.Type) {
        self.registerClass(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func register<T: UITableViewCell where T: protocol<ReusableView, NibLoadableView>>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: T.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = self.dequeueReusableCellWithIdentifier(T.identifier, forIndexPath: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.identifier)")
        }
        return cell
    }
    
    func configurableCells<S: SequenceType, Cell: UITableViewCell, O : ObservableType where O.E == S, Cell: protocol<ReusableView, Configurable>, Cell.T == S.Generator.Element>
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