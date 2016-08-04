//
//  DisableEditingTableViewDelegate.swift
//  peka
//
//  Created by Tomasz Pikć on 04/08/16.
//  Copyright © 2016 WhallaLabs. All rights reserved.
//

import UIKit

final class DisableEditingTableViewDelegate: NSObject, UITableViewDelegate {
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .None
    }
}
