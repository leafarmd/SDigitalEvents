//
//  TableViewModel.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 27/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import Foundation

import UIKit

final class TableViewModel {
    
    var items: [CellConfigurator]
    
    init(items: [CellConfigurator] = []) {
        self.items = items
    }
}
