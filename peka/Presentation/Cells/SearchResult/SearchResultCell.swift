//
//  SearchResultCell.swift
//  peka
//
//  Created by Tomasz Pikć on 01/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class SearchResultCell: UITableViewCell {
    
}

extension SearchResultCell: NibLoadableView {

}

extension SearchResultCell: Configurable {
    func configure(model: SearchResult) {
        switch model {
        case .Line(let name):
            self.textLabel?.text = "linia - \(name)"
        case .Stop(let model):
            self.textLabel?.text = "przystanek - \(model.name)"
        case .Street(let name):
            self.textLabel?.text = "ulica - \(name)"
        }
    }
}