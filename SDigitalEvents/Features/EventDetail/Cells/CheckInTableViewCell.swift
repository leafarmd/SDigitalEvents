//
//  CheckInTableViewCell.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

protocol CheckInDelegate: class {
    func checkEvent(with model: EventDetailModel)
}

typealias CheckInCellConfig = TableCellConfigurator<CheckInTableViewCell, (model: EventDetailModel, delegate: CheckInDelegate)>

class CheckInTableViewCell: UITableViewCell, ConfigurableCell {
    weak var delegate: CheckInDelegate?
    var model: EventDetailModel?
    
    func configure(data: (model: EventDetailModel, delegate: CheckInDelegate)) {
        self.delegate = data.delegate
        model = data.model
    }
    @IBAction func checkIntouched(_ sender: Any) {
        guard let model = model else { return }
        delegate?.checkEvent(with: model)
    }
}
