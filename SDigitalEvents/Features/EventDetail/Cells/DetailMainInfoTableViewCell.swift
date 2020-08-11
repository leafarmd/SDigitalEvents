//
//  DetailMainInfoTableViewCell.swift
//  Test-iOS
//
//  Created by Rafael Damasceno on 28/07/19.
//  Copyright © 2019 Rafael Damasceno. All rights reserved.
//

import UIKit

typealias EventDetailCellConfig = TableCellConfigurator<DetailMainInfoTableViewCell, EventDetailModel>

class DetailMainInfoTableViewCell: UITableViewCell, ConfigurableCell {
    @IBOutlet weak var imageViewEvent: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    
    
    func configure(data: EventDetailModel) {
        imageViewEvent.loadImageFromURL(data.image)
        labelTitle.text = data.title
        labelDescription.text = data.description
        labelDate.text = data.date.fromFormat("MMMM, dd yyyy")
    }
}
