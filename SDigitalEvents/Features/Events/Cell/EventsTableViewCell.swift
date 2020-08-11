//
//  EventsTableViewCell.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

typealias EventsCellConfig = TableCellConfigurator<EventsTableViewCell, EventModel>

class EventsTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    
    func configure(data: EventModel) {
        imageViewEvent.loadImageFromURL(data.image)
        labelTitle.text = data.title
        labelDate.text = data.date
    }
}
