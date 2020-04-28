//
//  TableViewController.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 27/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

class TableViewDataSoruce: NSObject {
    
    var model: TableViewModel
    
    init(model: TableViewModel = TableViewModel()) {
        self.model = model
    }
}

extension TableViewDataSoruce: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = model.items[indexPath.row]
        if Bundle.main.path(forResource: type(of: item).reuseId, ofType: "nib") != nil {
            tableView.register(type(of: item).nib, forCellReuseIdentifier: type(of: item).reuseId)
        } else {
            tableView.register(type(of: item).cell, forCellReuseIdentifier: type(of: item).reuseId)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: type(of: item).reuseId, for: indexPath)
        
        item.configure(cell: cell)
        
        return cell
    }
}
