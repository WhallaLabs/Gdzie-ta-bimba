//
//  FavoriteCellFactory.swift
//  peka
//
//  Created by Tomasz Pikć on 13/01/2017.
//  Copyright © 2017 WhallaLabs. All rights reserved.
//

import UIKit
import RxDataSources

final class FavoriteCellFactory {
    weak var delegate: BollardCellDelegate?
    
    func create() -> RxTableViewSectionedAnimatedDataSource<FavoriteSection>.CellFactory {
        return { [unowned self] (dataSoruce, tableView, index, model) in
            switch model {
            case .favorite(let bollard):
                let cell: BollardCell = tableView.dequeueReusableCell(forIndexPath: index)
                cell.configure(bollard)
                cell.delegate = self.delegate
                return cell
            case .nearest(let stopPoint):
                let cell: StopPointCell = tableView.dequeueReusableCell(forIndexPath: index)
                cell.configure(stopPoint)
                return cell
            }
        }
    }
}
